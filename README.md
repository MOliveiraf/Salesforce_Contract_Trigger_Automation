# Salesforce Contract Trigger Automation

## Descrição

O **Salesforce Contract Trigger Automation** é uma aplicação criada para automatizar a gestão de contratos no Salesforce. O sistema é projetado para monitorar e gerenciar os contratos de clientes de forma eficiente, garantindo que operações críticas, como geração de PDF e análise de dados, sejam realizadas automaticamente através de triggers Apex e classes auxiliares.

## Funcionalidades Principais

- **Automação de Triggers**: Triggers Apex que automatizam processos de criação, atualização e verificação de contratos.
- **Geração de PDFs**: Criação automática de documentos PDF para cada contrato, armazenados no Salesforce.
- **Integração com Visualforce**: Páginas Visualforce para entrada de dados e geração de relatórios.
- **Análise e Relatórios de Dados**: Geração de relatórios analíticos usando SOQL.
- **Integração com ContentVersion**: Salva e organiza PDFs no sistema.

## Estrutura do Projeto

Abaixo está a estrutura do projeto e uma breve descrição de cada pasta e arquivo:

### `force-app/main/default/classes`

Contém as classes Apex que implementam a lógica do projeto, incluindo:

- **`AccountPDFController.cls`**: Controlador para a geração de PDFs a partir de dados de contas.
- **`ContractTriggerHandler.cls`**: Manipulador de trigger que processa contratos automaticamente.
- **`ContentVersionBO.cls`**: Classe para validação de documentos e atualização de contas associadas.
- **`TriggerHandler.cls`**: Classe base para gerenciar o contexto dos triggers.
- **Arquivos de teste**: Testam a funcionalidade das classes principais para garantir que cada uma funcione corretamente.

### `force-app/main/default/triggers`

Contém o arquivo `ContractTrigger.trigger`, que ativa os processos automáticos para contratos.

### `force-app/main/default/pages`

Contém as páginas Visualforce, como:

- **`AccountPDF.page`**: Página Visualforce para visualização e geração de PDFs de contas.
- **`ContractForm.page`**: Formulário para entrada de dados do contrato.

### `force-app/main/default/objects`

Custom objects e campos adicionais, incluindo:

- **`Contrato__c`**: Objeto personalizado para armazenar dados dos contratos.
- **`Documentos__mdt` e `WebService__mdt`**: Metadados personalizados para configurar serviços e integrações externas.

## Pré-requisitos

Antes de iniciar, certifique-se de ter o seguinte configurado:

- **Salesforce CLI**: Para deploy e execução de testes.
- **Conta Salesforce Developer**: O projeto deve ser configurado e testado em uma sandbox ou ambiente de desenvolvedor.
- **Visual Studio Code** com a **extensão Salesforce** para facilitar o desenvolvimento.

## Como Instalar e Configurar

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/Salesforce_Contract_Trigger_Automation.git
   cd Salesforce_Contract_Trigger_Automation

2. **Conecte-se ao Salesforce: Execute o comando abaixo para autenticar-se no Salesforce**:
   ```bash
   sfdx force:auth:web:login -d -a AnaliseDeTriggerApex

3. **Desdobre o código: Faça o deploy de todos os arquivos para a org do Salesforce**:
   ```bash
   sfdx force:source:deploy --sourcepath force-app/main/default --target-org AnaliseDeTriggerApex

4. **Execute os testes: Rode todos os testes Apex para garantir que o sistema esteja funcionando corretamente**:
   ```bash
   sfdx force:apex:test:run --target-org AnaliseDeTriggerApex --result-format human --code-coverage

## Uso

### Geração de PDF
Quando um contrato é atualizado, um PDF é gerado automaticamente e salvo como `ContentVersion`, associado ao registro da conta correspondente.

### Verificação de Dados do Contrato
O sistema possui triggers e classes que verificam se todos os dados obrigatórios dos contratos estão preenchidos antes de confirmar as operações. Se algum campo obrigatório estiver vazio, uma exceção será lançada.

## Estrutura de Classes e Lógica

### Triggers
- **ContractTrigger**: Ativa a automação para novos contratos e atualizações.

### Controladores e Manipuladores
- **AccountPDFController**: Controlador responsável por fornecer dados à página Visualforce para geração de PDF.
- **ContractTriggerHandler**: Processa a criação e atualização de contratos, incluindo a integração com `ContentVersion` para salvamento de PDFs.

### Validação e Integração
- **ContentVersionBO**: Verifica os documentos, atualiza os campos nas contas e garante a integridade dos dados.
- **TriggerHandler**: Classe genérica para definir o contexto de triggers (inserção, atualização, exclusão).

## Testes
O projeto inclui classes de teste para garantir a funcionalidade e a cobertura de código necessária para deploy no Salesforce.

- **AtualizarContatoTeste**: Testa a funcionalidade de atualização de campos de contato com simulação de chamadas externas (mock).
- **LoteTest**: Testa o processamento em lote de dados de contas e contatos.

    **Para visualizar o relatório dos testes e verificar a cobertura, execute o comando**:
    ```bash
    sfdx force:apex:test:report -i <TestRunId> --target-org AnaliseDeTriggerApex


## Erros Comuns e Soluções

1. **Erro `REQUIRED_FIELD_MISSING`**: Certifique-se de que todos os campos obrigatórios estão preenchidos, especialmente o campo `Cliente__c` no objeto `Account`.
   
2. **Exceções `StringException`**: Verifique se os IDs utilizados são válidos e se todas as referências a outros objetos estão corretas.

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests. Para alterações importantes, por favor, discuta previamente as mudanças que deseja fazer.


