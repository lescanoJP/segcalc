class Api::V1::UserInfosController < ApplicationController
  def create
    response = UserInfo::CalculateInsuranceType.call(user_info_params: user_info_params)

    if response.success?
      byebug
      return render json: response.result, status: :ok if response.success?
    else
      return render json: { errors: [response.error] }, status: :unprocessable_entity
    end
  end

  private

  def user_info_params
    params.permit(:age, :income, :dependents, :marital_status, risk_questions: [],
                  vehicle: [:year], house: [:ownership_status])
  end
end
