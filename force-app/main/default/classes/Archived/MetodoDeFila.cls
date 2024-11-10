public class MetodoDeFila implements Queueable {
    
    List<Account> contas;
    
    public MetodoDeFila(List<Account> lstContas){
        this.contas = lstContas;
    }
    
    public void execute(QueueableContext context) {
        
        Set<ID> idsContas = new Set<ID>();
        
        for(Account acc : contas){
            idsContas.add(acc.Id);
        }
        List<Contact> listaContatosAtualizar = new List<Contact>();
        
        List<Contact> contatos = [SELECT Id, AccountId, Department FROM Contact WHERE AccountId IN : idsContas];
        
        for(Account acc : contas){
            for(Contact ct : contatos){
                
                if(acc.Id == ct.AccountId){
                    
                    ct.Department = acc.Site;
                    listaContatosAtualizar.add(ct);
                }
            }
        }
        update listaContatosAtualizar;
        
    }

}