public class EnderecoVO {

    // Construtor padrão da classe, vazio, pois não há lógica de inicialização.
    public EnderecoVO(){}

    // Atributos públicos da classe, correspondendo aos campos do objeto Endereço.
    // Estes campos serão populados com os dados de resposta da API de CEP.

    public String cep;           // Código postal (CEP) do endereço.
    public String logradouro;    // Nome da rua ou logradouro.
    public String complemento;   // Complemento do endereço, se existir.
    public String bairro;        // Bairro do endereço.
    public String localidade;    // Cidade ou localidade do endereço.
    public String uf;            // Unidade Federativa (estado) do endereço.
    public String ibge;          // Código IBGE da cidade.
    public String gia;           // Código GIA (Guia de Informações e Apurações do ICMS) do município.
    public String ddd;           // Código de Discagem Direta à Distância (DDD) da cidade.
    public String siafi;         // Código SIAFI (Sistema Integrado de Administração Financeira) do município.

}