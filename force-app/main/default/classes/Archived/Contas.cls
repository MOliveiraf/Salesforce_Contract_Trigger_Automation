public class Contas {
    
    private String retornaString(){
        String nome = 'BCD';
        
        return nome;
    }
    
    public void criarConta(){
        String nome = retornaString();
        
        Account acc = new Account();
        acc.Name = nome;
        
        insert acc;
            
    }        
}