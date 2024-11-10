// A classe 'lote' implementa a interface 'Database.Batchable<sObject>' para permitir o processamento de grandes volumes de registros em lotes no Salesforce.
public class lote implements Database.Batchable<sObject> {
    
    // Variável que armazena a lista de contas que serão processadas em lote.
    List<Account> lstContas;
    
    // Construtor que inicializa a lista de contas recebida como parâmetro.
    public lote(List<Account> lstContas){
        this.lstContas = lstContas;
    }
    
    // Método 'start' inicia o batch e retorna os registros que serão processados em lotes.
    // Aqui, retorna a lista de contas passada ao construtor.
    public System.Iterable<sObject> start(Database.BatchableContext bc){
        return lstContas; // Retorna a lista de contas para processamento.
    }
    
    // O método 'execute' é chamado para processar cada lote de registros.
    // Este método processa a lista de contas e atualiza o campo 'Department' dos contatos associados.
    public void execute(Database.BatchableContext bc, List<sObject> lstContas){
        
        // Conjunto para armazenar os IDs das contas que serão processadas.
        Set<ID> idsContas = new Set<ID>();
        
        // Adiciona os IDs das contas do lote atual ao conjunto 'idsContas'.
        for(Account acc : (list<Account>)lstContas ){
            idsContas.add(acc.Id);
        }
        
        // Lista para armazenar os contatos que serão atualizados.
        List<Contact> listaContatosParaAtualizar = new List<Contact>();
        
        // Se houver contas no lote, procede com a atualização dos contatos.
        if(!lstContas.isEmpty()){
            
            // Consulta os contatos que pertencem às contas sendo processadas.
            List<Contact> listaContatos = [SELECT Id, Department, AccountId FROM Contact WHERE AccountId IN : idsContas];
            
            // Mapa para armazenar contatos, relacionando o ID do contato com o objeto Contact.
            Map<ID, Contact> listaContatosIdUnicos = new Map<ID, Contact>();
            
            // Popula o mapa com os contatos retornados na consulta.
            for(Contact contato : listaContatos){
                listaContatosIdUnicos.put(contato.Id, contato);
            }
            
            // Itera sobre as contas e contatos para verificar correspondência entre ID de conta e contato.
            // Se os IDs coincidirem, atualiza o campo 'Department' do contato com o valor do campo 'Site' da conta.
            for(Account acc : (list<Account>)lstContas){
                for(Contact lt: listaContatosIdUnicos.values()){
                    
                    if(lt.AccountId == acc.Id){
                        // Atualiza o campo 'Department' do contato com o valor do campo 'Site' da conta.
                        lt.Department = acc.Site;
                        
                        // Adiciona o contato atualizado à lista para ser salvo no Salesforce.
                        listaContatosParaAtualizar.add(lt);
                    }
                }
            }
        }
        
        // Realiza a atualização da lista de contatos no Salesforce.
        update listaContatosParaAtualizar;
    }
    
    // O método 'finish' é chamado após o processamento de todos os lotes do batch.
    // Neste caso, o método está vazio, mas pode ser usado para enviar notificações ou realizar um tratamento final.
    public void finish(Database.BatchableContext bc){}
}
