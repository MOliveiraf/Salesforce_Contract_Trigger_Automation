public class Cliente extends Pessoa {
    
    Integer valor = 600;
    
    public override void pagar(){
        System.debug('Vai pagar: ' + valor);
    }
    public override void receber(){}

}