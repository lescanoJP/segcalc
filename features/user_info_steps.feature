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

  Cenário: Usuario envia dados informando que é casado
    Dado os parâmetros para fazer a cotação de seguros com a informação de que é casado
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado a cotação sobre o seu seguro, e o seguro de vida deve ser avancado e o seguro invalidez padrao
    E o seguro de carro e o seguro residencial devem ser avancados

  Cenário: Usuário envia dados informando que o carro foi produzido nos ultimos 5 anos
    Dado os parâmetros para fazer a cotação de seguros com a informação de que o carro foi produzido recentemente
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado a cotação sobre o seu seguro, e o seguro auto deve ser avancado
    E os demais seguros devem ser padrões

  Cenário: Usuário envia informações sem informar a renda
    Dado os parâmetros para fazer a cotação de seguros sem a informação da renda
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a renda não pode ficar em branco

  Cenário: Usuário envia informações com a renda negativa
    Dado os parâmetros para fazer a cotação de seguros com uma renda negativa
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a renda não ser menor que zero

  Cenário: Usuário envia informações sem informar a idade
    Dado os parâmetros para fazer a cotação de seguros sem a informação da idade
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a idade não pode ficar em branco

  Cenário: Usuário envia informações com idade negativa
    Dado os parâmetros para fazer a cotação de seguros com idade negativa
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a idade não pode ser menor que zero

  Cenário: Usuário envia informações sem informar o número de dependentes
    Dado os parâmetros para fazer a cotação de seguros sem a informação sobre dependentes
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que os dependentes não podem ficar em branco

  Cenário: Usuário envia informações com dependentes negativos
    Dado os parâmetros para fazer a cotação de seguros sobre dependentes negativos
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que os dependentes devem ser maior igual a zero

  Cenário: Usuário envia informações sem informar estado civil
    Dado os parâmetros para fazer a cotação de seguros sem informar o estado civil
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que o estado civil não pode ficar em branco

  Cenário: Usuário envia informações sobre estado civil inválidas
    Dado os parâmetros para fazer a cotação de seguros com uma informação inválida sobre o estado civil
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que o estado civil não está incluido na lista

  Cenário: Usuário envia informações sobre questões de risco com apenas uma informação
    Dado os parâmetros para fazer a cotação de seguros com apenas uma informação sobre questões de risco
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que o as questões de risco devem conter três dados

  Cenário: Usuário envia informações sobre questões de risco com dados diferentes de zero e um
    Dado os parâmetros para fazer a cotação de seguros com dados diferentes de zero e um
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que são aceitos apenas números zero e um

  Cenário: Usuário envia informações sobre a casa inválidas
    Dado os parâmetros para fazer a cotação de seguros com informações inválidas sobre a casa
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a informação sobre a casa não está na lista

  Cenário: Usuário envia informações sobre com número menor que zero
    Dado os parâmetros para fazer a cotação de seguros com ano de fabricação de veículo negativo
    Quando o usuário submete o seu cadastro no formulário
    Então é retornado um erro informando que a informação que o ano do veículo deve ser maior que zero


