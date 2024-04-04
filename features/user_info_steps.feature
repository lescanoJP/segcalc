#language: pt

Funcionalidade: Enviando dados de um usuário para fazer o cálculo do seu seguro

  Cenário: Usuário pede uma cotação de seguro com os dados válidos
    Dado os parâmetros para fazer a cotação de seguros válidos com casa e veículo
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado com sucesso a sua cotação de planos para o seguro

  Cenário: Usuario não fornece veículo
    Dado os parâmetros para fazer a cotação de seguros sem veículo
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado que o seguro auto, residencial e de invalidez são inelegiveis

  Cenário: Usuario não fornece informações da residência
    Dado os parâmetros para fazer a cotação de seguros sem informações da residência
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado que o seguro auto, residencial e de invalidez são inelegiveis

  Cenário: Usuario envia informações sobre a renda zerada
    Dado os parâmetros para fazer a cotação de seguros com a renda zerada
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado que o seguro auto, residencial e de invalidez são inelegiveis

  Cenário: Usuario envia dados com idade acima de sessenta anos
    Dado os parâmetros para fazer a cotação de seguros com idade acima de sessenta anos
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado que o seguro de vida e o de invalidez são inelegiveis

  Cenário: Usuario envia dados com idade menor que trinta anos
    Dado os parâmetros para fazer a cotação de seguros com idade menor que trinta anos
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado a cotação sobre seu seguro e deve estar no plano padrão

  Cenário: Usuario envia dados válidos e sua casa é alugada
    Dado os parâmetros para fazer a cotção de seguros com a casa alugada
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado a cotação sobre o seu seguro, e os seguros invalidez e residencial devem ser avançados
    E o seguro de vida e o auto devem ser padrão

  Cenário: Usuario envia dados possuindo dependentes
    Dado os parâmetros para fazer a cotação de seguros com um numero positivo de dependentes
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado a cotação sobre o seu seguro, e os seguros invalidez e vida devem ser avançados
    E o seguro de carro e o seguro residencial devem ser padrão
