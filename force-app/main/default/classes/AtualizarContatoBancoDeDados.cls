public class AtualizarContatoBancoDeDados {

    // Método para criar uma conta de teste com um contato associado no banco de dados.
    public static Account criarConta(){
        // Cria um contato de teste para associar à conta
        Contact contato = new Contact(LastName = 'Teste Contato');
        insert contato;

        // Cria uma nova conta e associa o ID do contato ao campo Cliente__c
        Account conta = new Account();
        conta.Name = 'Conta Teste'; // Define o nome da conta como 'Conta Teste'.
        conta.Site = 'Site Teste'; // Define o site da conta como 'Site Teste'.
        conta.BillingPostalCode = '12345678'; // Atribui um código postal fictício à conta.
        conta.Cliente__c = contato.Id; // Atribui dinamicamente o ID do contato ao campo Cliente__c.
        insert conta; // Insere a conta no banco de dados.

        return conta; // Retorna a conta criada.
    }
    
    // Método que cria uma lista de 200 contas de teste e seus respectivos contatos.
    public static List<Account> listaContas(){
        
        // Cria uma lista para armazenar os contatos e associar a cada conta
        List<Contact> contatos = new List<Contact>();
        
        // Cria 200 contatos de teste
        for(Integer i = 0; i < 200; i++) {
            contatos.add(new Contact(LastName = 'Teste Contato ' + i));
        }
        insert contatos;

        // Cria uma lista para armazenar as contas.
        List<Account> contas = new List<Account>();
        
        // Loop para criar 200 contas de teste.
        for(Integer i = 0; i < 200; i++){
            Account acc = new Account(
                Name = 'Test ' + i, // Define o nome da conta como 'Test' seguido de um número.
                Site = 'teste ' + i, // Define o site da conta como 'teste' seguido de um número.
                Cliente__c = contatos[i].Id // Associa cada conta ao ID de um contato na lista.
            );
            contas.add(acc); // Adiciona a conta à lista.
        }
        
        insert contas; // Insere todas as contas no banco de dados de uma só vez.

        return contas; // Retorna a lista de contas criadas.
    }
}
