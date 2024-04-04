Dado('os parâmetros para fazer a cotação de seguros válidos com casa e veículo') do
  @params = {
    age: 35,
    dependents: 2,
    income: 10000,
    marital_status: 'married',
    house: { ownership_status: 'rented' },
    risk_questions: [0, 1, 0],
    vehicle: { year: 2018 }
  }
end

Quando('o usuário submete o seu cadastro no formulário') do
  @user_info_response = UserInfo::CalculateInsuranceType.call(user_info_params: @params)
end

Então('é retornado com sucesso a sua cotação de planos para o seguro') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
end

Dado('os parâmetros para fazer a cotação de seguros sem veículo') do
  @params = {
    age: 35,
    dependents: 2,
    income: 0,
    marital_status: 'married',
    house: { ownership_status: 'rented' },
    risk_questions: [0, 1, 0]
  }
end

Então('é retornado que o seguro auto, residencial e de invalidez são inelegiveis') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
  expect(@user_info_response.result[:auto]).to eq 'inelegivel'
  expect(@user_info_response.result[:home]).to eq 'inelegivel'
  expect(@user_info_response.result[:disability]).to eq 'inelegivel'
end

Dado('os parâmetros para fazer a cotação de seguros sem informações da residência') do
  @params = {
    age: 35,
    dependents: 2,
    income: 0,
    marital_status: 'married',
    risk_questions: [0, 1, 0],
    vehicle: { year: 2018 }
  }
end

Dado('os parâmetros para fazer a cotação de seguros com a renda zerada') do
  @params = {
    age: 35,
    dependents: 2,
    income: 0,
    marital_status: 'married',
    house: { ownership_status: 'rented' },
    risk_questions: [0, 1, 0],
    vehicle: { year: 2018 }
  }
end

Dado('os parâmetros para fazer a cotação de seguros com idade acima de sessenta anos') do
  @params = {
    age: 70,
    dependents: 2,
    income: 100_000,
    marital_status: 'married',
    house: { ownership_status: 'rented' },
    risk_questions: [0, 1, 0],
    vehicle: { year: 2018 }
  }
end

Então('é retornado que o seguro de vida e o de invalidez são inelegiveis') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
  expect(@user_info_response.result[:life]).to eq 'inelegivel'
  expect(@user_info_response.result[:disability]).to eq 'inelegivel'
end

Dado('os parâmetros para fazer a cotação de seguros com idade menor que trinta anos') do
  @params = {
    age: 29,
    dependents: 0,
    income: 100_000,
    marital_status: 'single',
    house: { ownership_status: 'owned' },
    risk_questions: [1, 1, 1],
    vehicle: { year: 2000 }
  }
end

Então('é retornado a cotação sobre seu seguro e deve estar no plano padrão') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
  expect(@user_info_response.result.values.uniq).to include 'padrao'
end

Dado('os parâmetros para fazer a cotção de seguros com a casa alugada') do
  @params = {
    age: 35,
    dependents: 0,
    income: 100_000,
    marital_status: 'single',
    house: { ownership_status: 'rented' },
    risk_questions: [1, 1, 1],
    vehicle: { year: 2000 }
  }
end

Então('é retornado a cotação sobre o seu seguro, e os seguros invalidez e residencial devem ser avançados') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
  expect(@user_info_response.result[:home]).to eq 'avancado'
  expect(@user_info_response.result[:disability]).to eq 'avancado'
end

Então('o seguro de vida e o auto devem ser padrão') do
  expect(@user_info_response.result[:auto]).to eq 'padrao'
  expect(@user_info_response.result[:life]).to eq 'padrao'
end

Dado('os parâmetros para fazer a cotação de seguros com um numero positivo de dependentes') do
  @params = {
    age: 35,
    dependents: 3,
    income: 100_000,
    marital_status: 'single',
    house: { ownership_status: 'owned' },
    risk_questions: [1, 1, 1],
    vehicle: { year: 2000 }
  }
end

Então('é retornado a cotação sobre o seu seguro, e os seguros invalidez e vida devem ser avançados') do
  expect(@user_info_response.success?).to be true
  expect(@user_info_response.error.present?).to be false
  expect(@user_info_response.result.keys).to eq [:auto, :disability, :home, :life]
  expect(@user_info_response.result[:life]).to eq 'avancado'
  expect(@user_info_response.result[:disability]).to eq 'avancado'
end

Então('o seguro de carro e o seguro residencial devem ser padrão') do
  expect(@user_info_response.result[:auto]).to eq 'padrao'
  expect(@user_info_response.result[:home]).to eq 'padrao'
end