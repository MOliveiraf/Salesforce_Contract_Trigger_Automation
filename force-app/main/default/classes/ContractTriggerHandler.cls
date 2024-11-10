public class ContractTriggerHandler {
    public static void beforeInsert(List<Contrato__c> newContracts) {
        for (Contrato__c contract : newContracts) {
            if (contract.Valor__c > 10000) {
                contract.Status__c = 'Pending Approval';
            }
        }
    }

    public static void beforeUpdate(List<Contrato__c> updatedContracts) {
        for (Contrato__c contract : updatedContracts) {
            if (contract.Status__c == 'Cancelled') {
                contract.Valor__c = 0;
            }
        }
    }
}
