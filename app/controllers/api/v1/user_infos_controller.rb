class Api::V1::UserInfosController < ApplicationController
  def create
    response = UserInfo::CalculateInsuranceType.call(user_info_params: user_info_params)

    render json: response.result
  end

  private

  def user_info_params
    params.permit(:age, :income, :dependents, :marital_status, risk_questions: [],
                  vehicle: [:year], house: [:ownership_status])
  end
end
