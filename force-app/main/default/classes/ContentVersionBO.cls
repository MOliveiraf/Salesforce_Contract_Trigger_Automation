public class ContentVersionBO {
    
    // Método que valida documentos e atualiza as contas associadas com base nos títulos dos documentos.
    public static void validarDocumentos(List<ContentVersion> lista){
        
        // Conjunto para armazenar IDs dos documentos de conteúdo (ContentDocumentId)
        Set<Id> ids = new Set<Id>();
        
        // Conjunto para armazenar IDs das contas associadas aos documentos
        Set<Id> idsContas = new Set<Id>();
        
        // Mapa que relaciona IDs de documentos a IDs de conta e títulos de documentos
        Map<ID, Map<ID, String>> mapDoc = new Map<ID, Map<ID, String>>();
        
        // Percorre a lista de ContentVersion (documentos) que acionaram o gatilho
        for(ContentVersion ct : lista){
            // Adiciona o ID do documento ao conjunto de IDs
            ids.add(ct.ContentDocumentId);
        }
        
        // Realiza uma consulta para buscar links entre ContentDocuments e outras entidades
        List<ContentDocumentLink> link = [SELECT Id, LinkedEntityId, ContentDocumentId, ContentDocument.Title
                                         FROM ContentDocumentLink
                                         WHERE ContentDocumentId IN : ids];
        
        // Percorre os links para identificar associações com contas
        for(ContentDocumentLink lt : link){
            // Verifica se o link está associado a uma conta (pelo prefixo do tipo de objeto)
            if(String.valueOf(lt.LinkedEntityId).substring(0, 3) == Account.sObjectType.getDescribe().getKeyPrefix()){
                // Adiciona o ID da conta ao conjunto de IDs de contas
                idsContas.add(lt.LinkedEntityId);
                
                // Associa o ID do documento ao ID da conta e ao título no mapa de documentos
                mapDoc.put(lt.ContentDocumentId, new Map<ID, String>{lt.LinkedEntityId => lt.ContentDocument.Title});
            }
        }
        
        // Realiza uma consulta para buscar as contas associadas aos documentos para atualização de campos
        List<Account> lstConta = [SELECT Id, Faturamentos__c, InscricaoEstadual__c, ResumoPatrimonial__c
                                 FROM Account
                                 WHERE Id IN : idsContas];
        
        // Lista que armazenará as contas que precisarão de atualização
        List<Account> lstContaUP = new List<Account>();
        
        // Obtém todos os registros do metadado personalizado Documentos__mdt
        List<Documentos__mdt> metadados = Documentos__mdt.getAll().values();
        
        // Percorre as contas para atualizar campos com base nos títulos dos documentos associados
        for(Account acc : lstConta){
            for(ContentDocumentLink lt : link){
                // Verifica se o título do documento relacionado à conta existe no mapa de documentos
                if(mapDoc.get(lt.ContentDocumentId).get(lt.LinkedEntityId) != null){
                    // Obtém o título do documento associado à conta
                    String titulo = mapDoc.get(lt.ContentDocumentId).get(lt.LinkedEntityId);
                    
                    // Percorre os metadados para encontrar o campo correspondente ao título do documento
                    for(Documentos__mdt mt : metadados){
                        
                        // Verifica se o título do documento corresponde ao valor do metadado
                        if(titulo == mt.Titulo__c){
                            
                            // Exibe o valor do campo antes da atualização para fins de depuração
                            System.debug('Valor antes da atualização: ' + acc.get(mt.Campo__c));
                            
                            // Atualiza o campo específico da conta conforme definido no metadado
                            acc.put(mt.Campo__c, true);
                            
                            // Exibe o valor do campo após a atualização
                            System.debug('Valor após a atualização: ' + acc.get(mt.Campo__c));
                            
                            // Adiciona a conta atualizada à lista de contas que serão salvas
                            lstContaUP.add(acc);                            
                        }  
                    }            
                }            
            }
        }
        
        // Realiza a atualização das contas no banco de dados com os novos valores dos campos
        update lstContaUP;
    }
}
