public class AtualizarContato { 
    
    // Método principal chamado inicialmente para atualizar campos e processar as contas.
    public static void atualizarCampo(List<Account> trg){
        
        // Conjunto para armazenar os IDs das contas que possuem o campo Site preenchido.
        Set<ID> idsContas = new Set<ID>();
        
        // Cria uma nova lista de contas para processar posteriormente.
        List<Account> lstContas = new List<Account>();
        
        // Itera sobre as contas na lista 'trg'.
        for(Account acc : trg ){
            
            // Verifica se o campo Site da conta está preenchido.
            if(acc.Site != null){
                // Adiciona o ID da conta ao conjunto de IDs de contas com Site preenchido.
                idsContas.add(acc.Id);
                // Adiciona a conta à lista para processamento.
                lstContas.add(acc);                
            }
        }        
        
        // Se houver contas na lista 'lstContas', adiciona uma tarefa à fila para processá-las de forma assíncrona.
        if(!lstContas.isEmpty()) System.enqueueJob(new MetodoDeFila(lstContas));

        // Faz uma segunda chamada de serviço para buscar informações de endereço com base nos IDs das contas.
        buscarSite(idsContas); 
    }    
  
    // Método assíncrono para buscar informações de endereço usando o CEP (código postal) das contas.
    @future(callout=true)
    public static void buscarSite(Set<ID> idsContas){
        
       	// Obtém a configuração 'ViaCep' do tipo de metadado personalizado 'WebService__mdt',
        // onde provavelmente estão armazenados detalhes da API (como URL e autenticação).
        WebService__mdt dados = WebService__mdt.getInstance('ViaCep');
        
        // Variável para armazenar o CEP da conta.
        String codigo;
        
        try {
            // Busca uma conta pelo ID, selecionando dados de endereço como rua, cidade, estado e CEP.
            Account acc = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingPostalCode 
                           FROM Account 
                           WHERE Id IN : idsContas 
                           LIMIT 1];
            
            // Armazena o CEP da conta na variável 'codigo'.
            codigo = acc.BillingPostalCode;
        
        } catch(QueryException e) {
            // Log de erro caso ocorra um problema na consulta.
            system.debug('Erro: ' + e.getMessage());
            
            // Lança uma exceção com uma mensagem personalizada para indicar o erro.
            throw new QueryException('Erro na consulta: ' + e.getMessage());            
        }        

        // Instancia um objeto HTTP para fazer a requisição.
        Http h = new Http();
        
        // Cria a requisição HTTP.
        HttpRequest req = new HttpRequest();
        
       	// Define o endpoint da requisição concatenando a URL base do metadado com o CEP da conta e o sufixo '/json/'.
        req.setEndpoint(dados.Endpoint__c + codigo + '/json/');

        // Define o método HTTP como GET para recuperar os dados.
        req.setMethod('GET');
        
        // Envia a requisição e armazena a resposta.
        HttpResponse res = h.send(req);
        
        // Verifica se o código de status da resposta não é 200 (OK) ou 201 (Criado).
        // Se não for, lança uma exceção indicando que a requisição falhou.
        if(res.getStatusCode() != 200 && res.getStatusCode() != 201) {
            throw new TesteRequisicaoException('Requisição falhou com status: ' + res.getStatusCode());
        }

        // Desserializa o corpo da resposta JSON para um objeto da classe EnderecoVO.
        EnderecoVO resposta = (EnderecoVO)JSON.deserialize(res.getBody(), EnderecoVO.class);
        
        // Log do endereço retornado pela API para depuração.
        System.debug('Endereço retornado: '+ resposta.logradouro);
    }
}
