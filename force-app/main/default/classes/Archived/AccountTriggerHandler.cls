// A classe AccountTriggerHandler estende a TriggerHandler, que provavelmente contém a lógica fundamental
// para a execução de triggers em registros.
public class AccountTriggerHandler extends TriggerHandler {
    
    // Duas listas para armazenar as versões atualizadas e anteriores dos registros de contas (Account),
    // permitindo a comparação entre o estado dos registros antes e depois da atualização.
    private List<Account> listaContasNovas;   // Contas após a atualização (versão nova).
    private List<Account> listaContasAntigas; // Contas antes da atualização (versão antiga).
    
    // Construtor da AccountTriggerHandler que inicializa as listas com os dados dos triggers.
    public AccountTriggerHandler() {
        this.listaContasNovas = trigger.new;   // Lista com os registros de contas atualizados.
        this.listaContasAntigas = trigger.old; // Lista com os registros de contas antes da atualização.
    }
    
    // Este método é executado automaticamente após uma atualização em registros de contas.
    // Ele substitui o método afterUpdate da classe TriggerHandler.
    public override void afterUpdate() {
        
        // Aqui chamaria o método 'atualizarCampo' da classe AtualizarContato, passando as contas atualizadas
        // como argumento. Este código está comentado, mas provavelmente atualizaria algum campo específico.
        // AtualizarContato.atualizarCampo(listaContasNovas);
        
        // Cria um conjunto (Set) para armazenar os IDs das contas que foram atualizadas.
        Set<ID> ids = new Set<ID>();
        
        // Adiciona os IDs das contas atualizadas ao conjunto de IDs.
        for(Account acc : listaContasNovas){
            ids.add(acc.Id); // Adiciona o ID da conta atual ao conjunto de IDs.
        }
        
        // Chama o método 'salvar' da classe SalvarPDF, passando o conjunto de IDs das contas atualizadas.
        // Este método provavelmente salva ou gera PDFs relacionados às contas que foram alteradas.
        SalvarPDF.salvar(ids);        
    }
}
