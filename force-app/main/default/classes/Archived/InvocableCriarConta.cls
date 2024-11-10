public class InvocableCriarConta {
    
    @InvocableMethod
    public static List<ClasseRetorno> recebeValores (List<RecebeVariaveis> var) {
        criaConta(var);
        
        // Como tem que retornar, tem que instanciar a classe
        ClasseRetorno retorno = new ClasseRetorno();
        retorno.mensagem = 'Deu certooo';
        
        // Trata-se do retorno de uma lista
        return new List<ClasseRetorno>{retorno};
    }
    
    private static void criaConta(List<RecebeVariaveis> var){
        
        List<Account> accLista = new List<Account>();
        
        for(RecebeVariaveis vr : var){
            
            Account acc = new Account();
            acc.name = vr.variaveisRecebidas.nomeConta;
            acc.Phone = vr.variaveisRecebidas.telefone;
            acc.CNPJ__c = String.valueOf(vr.variaveisRecebidas.cnpj);
            
            accLista.add(acc);
        }
        insert accLista;
        
    }
    
    public class RecebeVariaveis{
         @InvocableVariable
        public ObjectVirtualVO variaveisRecebidas;
        
    }
    
    public class ClasseRetorno{
        
        @InvocableVariable
        public String mensagem;
        
    }

}