@isTest
private class AtualizarContatoTeste {

    // Método de configuração executado uma vez antes de todos os testes
    // Ele garante que a conta e o contato de teste existam no banco de dados
    @testSetup
    private static void setup(){
        // Cria uma conta e um contato associados no banco de dados para serem usados nos testes
        // Verifique se 'criarConta()' na classe 'AtualizarContatoBancoDeDados' está preenchendo 'Cliente__c' corretamente
        Account contaTeste = AtualizarContatoBancoDeDados.criarConta();
        
        // Certifique-se de que o campo Cliente__c está preenchido após a criação
        System.assertNotEquals(null, contaTeste.Cliente__c, 'O campo Cliente__c está vazio após a criação da conta.');
    }
    
    // Método de teste para verificar a funcionalidade do método 'atualizarCampo' da classe AtualizarContato
    @isTest
    private static void AtualizarContato(){
                
        // Consulta uma lista de contas no banco de dados de teste,
        // selecionando os campos 'Id', 'Site', 'BillingPostalCode' e 'Cliente__c' para verificação
        List<Account> contas = [SELECT Id, Site, BillingPostalCode, Cliente__c FROM Account]; 
        
        // Verifique se a conta foi criada e se o campo Cliente__c está preenchido corretamente após a consulta
        System.assert(contas.size() > 0, 'Nenhuma conta encontrada para teste.');
        System.assertNotEquals(null, contas[0].Cliente__c, 'O campo Cliente__c está vazio na conta recuperada.');

        // Configuração do mock para simular respostas de uma API externa
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();        
        
        // Configura o endpoint simulado usando um recurso estático, simulando uma chamada para o serviço "ViaCep"
        multimock.setStaticResource('https://viacep.com.br/ws/'+ contas[0].BillingPostalCode +'/json/', 'Cep');
        
        // Define o código de status da resposta HTTP como 200 (sucesso)
        multimock.setStatusCode(200);
        
        // Define o cabeçalho da resposta como 'application/json'
        multimock.setHeader('Content-Type', 'application/json');
                
        // Configura o sistema para usar esse mock em chamadas HTTP durante o teste
        Test.setMock(HttpCalloutMock.class, multimock);
                
        // Inicia um bloco de teste assíncrono para testar o comportamento de métodos que usam @future (chamadas assíncronas)
        Test.startTest();
        
        // Chama o método a ser testado, passando a lista de contas para simular a execução da lógica de atualização
        AtualizarContato.atualizarCampo(contas);
        
        // Finaliza o bloco de teste. Todas as operações entre startTest e stopTest serão monitoradas
        Test.stopTest();
    }
}
