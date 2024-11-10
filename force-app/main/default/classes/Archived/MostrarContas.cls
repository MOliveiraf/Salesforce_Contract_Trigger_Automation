public class MostrarContas {
    
    public static void mostrarConta(){ 
      
        
        for(Account acc : SelectAccount.retornaContas()){
            System.debug(acc.Phone);            
        }        
    }
}