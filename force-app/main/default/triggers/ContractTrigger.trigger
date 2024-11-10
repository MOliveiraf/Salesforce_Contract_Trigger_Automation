trigger ContractTrigger on Contrato__c (after insert, after update) {
    // Conjunto de IDs de contratos recém-criados ou atualizados
    Set<Id> contratoIds = new Set<Id>();
    
    // Adiciona os IDs dos contratos no conjunto
    for (Contrato__c contrato : Trigger.new) {
        contratoIds.add(contrato.Id);
    }
    
    // Chama a classe para salvar o PDF
    SalvarPDF.salvar(contratoIds);
}
