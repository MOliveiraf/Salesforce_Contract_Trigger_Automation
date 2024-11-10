public class Funcionario extends Pessoa {
    
    Integer valor = 500;
    
    public override void pagar(){}
    
    public override void receber(){
        System.debug('Vai receber: ' + valor);
    }

}