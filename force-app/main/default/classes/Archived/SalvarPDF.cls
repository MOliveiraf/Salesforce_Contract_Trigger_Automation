public class SalvarPDF {
 
    @Future(callout=true)
    public static void salvar(Set<Id> contractIds) {
        System.debug('Entrou no método salvar. IDs dos contratos: ' + contractIds);
        save(new List<Id>(contractIds));
    }
 
    private static void save(List<Id> contractIds) {
        List<ContentVersion> lstCT = new List<ContentVersion>();
        System.debug('Iniciando o processo de geração de PDF.');
        
        // Criação dos PDFs e inserção em ContentVersion
        for(Id contractId : contractIds) {
            System.debug('Processando contrato com ID: ' + contractId);
            PageReference pageRef = new PageReference('/apex/AccountPDF?id=' + contractId);
            Blob b;
            try {
                b = pageRef.getContent();
                System.debug('PDF gerado com sucesso para contrato ' + contractId);
            } catch(Exception e) {
                System.debug('Erro ao gerar PDF para contrato ' + contractId + ': ' + e.getMessage());
                continue;
            }
            
            ContentVersion contvers = new ContentVersion();
            contvers.Title = 'PDFdoContrato' + contractId;
            contvers.PathOnClient = 'PDFdoContrato' + contractId + '.pdf';
            contvers.VersionData = b;
            lstCT.add(contvers);
        }
        
        if (!lstCT.isEmpty()) {
            insert lstCT;
            System.debug('PDFs inseridos no ContentVersion: ' + lstCT);
        }
        
        // Obtenha o ContentDocumentId após a inserção e crie links associados aos contratos
        List<ContentDocumentLink> links = new List<ContentDocumentLink>();
        for (Integer i = 0; i < lstCT.size(); i++) {
            ContentVersion cv = lstCT[i];
            Id contractId = contractIds[i];

            // Consultar o ContentDocumentId do ContentVersion recém-criado
            ContentVersion cvWithDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
            
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cvWithDocId.ContentDocumentId; // Atribua o ContentDocumentId corretamente
            cdl.LinkedEntityId = contractId; // Associa ao contrato correspondente
            cdl.ShareType = 'V'; // Define o tipo de compartilhamento como Visualização
            links.add(cdl);
        }
        
        if (!links.isEmpty()) {
            insert links;
            System.debug('Links de PDF criados para os contratos.');
        }
    }
}
