public with sharing class ContractController {
    private final Contrato__c contrato;

    public ContractController(ApexPages.StandardController stdController) {
        this.contrato = (Contrato__c) stdController.getRecord();
    }

    public PageReference save() {
        try {
            insert contrato;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Contrato salvo com sucesso!'));
            return null;
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Erro ao salvar contrato: ' + e.getMessage()));
            return null;
        }
    }
}