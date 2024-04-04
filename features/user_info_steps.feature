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