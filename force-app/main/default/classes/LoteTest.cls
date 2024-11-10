@isTest
public class LoteTest {
    
    // Método de configuração que será executado uma vez antes de todos os testes da classe.
    // Ele cria 200 contas e contatos de teste no banco de dados para serem usados nos testes.
    @testSetup
    private static void setup(){
        // Chama o método 'listaContas' da classe 'AtualizarContatoBancoDeDados' para criar dados de teste.
        List<Account> contasTeste = AtualizarContatoBancoDeDados.listaContas();
        
        // Certifique-se de que o campo Cliente__c está preenchido para todas as contas criadas.
        for (Account conta : contasTeste) {
            System.assertNotEquals(null, conta.Cliente__c, 'O campo Cliente__c deve estar preenchido para a conta criada.');
        }
    }
    
    // Método de teste para verificar a execução do processamento em lote.
    @isTest
    private static void testarLote(){
        
        // Consulta até 200 contas de teste, incluindo os campos 'Id', 'Site', 'BillingPostalCode' e 'Cliente__c'.
        List<Account> lstContas = [SELECT Id, Site, BillingPostalCode, Cliente__c FROM Account LIMIT 200];
        
        // Certifica-se de que o campo Cliente__c está preenchido para todas as contas consultadas.
        for (Account acc : lstContas) {
            System.assertNotEquals(null, acc.Cliente__c, 'O campo Cliente__c deve estar preenchido na conta recuperada.');
        }
        
        // Inicia o bloco de teste para verificar a execução de código assíncrono e limites do sistema.
        Test.startTest();
        
        // Enfileira um job para processar as contas de forma assíncrona.
        // Aqui, estamos usando 'MetodoDeFila' para processar a lista de contas de teste.
        System.enqueueJob(new MetodoDeFila(lstContas));

        // Finaliza o bloco de teste. Tudo entre startTest e stopTest será executado em um ambiente monitorado.
        Test.stopTest();
    }
}
