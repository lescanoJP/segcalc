Dado('os parâmetros para fazer a cotação de seguros válidos com casa e veículo') do
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