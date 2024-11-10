public class ContentVersionTriggerHandler extends TriggerHandler {
    
    // Lista para armazenar os novos registros de ContentVersion que foram inseridos.
    private List<ContentVersion> trgNew;
    
    // Construtor da classe ContentVersionTriggerHandler.
    // Inicializa a lista 'trgNew' com os registros de ContentVersion que estão no contexto do trigger (os registros novos inseridos).
    public ContentVersionTriggerHandler(){
        trgNew = Trigger.New;
    }
    
    // Método executado logo após a inserção dos registros.
    // Esse método sobrescreve a implementação padrão e utiliza a classe ContentVersionBO para validar os documentos.
    // A chamada ao método 'validarDocumentos' passa a lista de novos registros para aplicar as regras de validação neles.
    public override void afterInsert(){
        ContentVersionBO.validarDocumentos(trgNew);
    }

}
