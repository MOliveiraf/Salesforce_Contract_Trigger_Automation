// Classe de controle para fornecer dados à página Visualforce que gera o PDF para o contrato
public class AccountPDFController { 
    
    // Variável pública 'dados' do tipo 'Dados', que será usada para passar informações para a página Visualforce
    public Dados dados {get; set;}
    
    // Construtor da classe 'AccountPDFController'
    public AccountPDFController(){
        // Inicializa o objeto 'dados' e define o nome de uma escola de exemplo
        dados = new Dados();
        dados.nomeEscola = 'Escola Salesforce'; // Nome fictício da escola para exibição
        
        // Busca as informações do contrato e atribui à propriedade 'contrato' do objeto 'dados'
        dados.contrato = buscarContrato();
    }
    
    // Método privado 'buscarContrato' para obter informações do contrato atual no Salesforce
    private Contrato buscarContrato(){       
        // Realiza uma consulta SOQL para encontrar o contrato com o ID que foi passado na URL da página Visualforce
        Contrato__c contrato = [SELECT Id, Name, Status__c, Valor__c, Data_de_Expiracao__c
                                FROM Contrato__c
                                WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
        
        // Cria uma nova instância do objeto 'Contrato' e preenche com os dados do contrato encontrado
        Contrato contratoInfo = new Contrato();
        contratoInfo.nome = contrato.Name;
        contratoInfo.status = contrato.Status__c;
        contratoInfo.valor = contrato.Valor__c;
        contratoInfo.dataExpiracao = contrato.Data_de_Expiracao__c;
        
        // Retorna o objeto 'contratoInfo' com as informações preenchidas
        return contratoInfo;
    }
    
    // Classe interna 'Dados' que armazena os dados que serão passados para a página Visualforce
    public class Dados {
        public Contrato contrato {get; set;} // Armazena informações do contrato individual
        public String nomeEscola {get; set;} // Armazena o nome da escola para exibição
    }
    
    // Classe interna 'Contrato' que representa os detalhes de um contrato individual
    public class Contrato {
        public String nome {get; set;}       // Nome do contrato
        public String status {get; set;}     // Status do contrato
        public Decimal valor {get; set;}     // Valor do contrato
        public Date dataExpiracao {get; set;} // Data de expiração do contrato
    }
}
