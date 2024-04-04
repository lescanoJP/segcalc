class UserInfo::CalculateInsuranceType < BusinessProcess::Base
  needs :user_info_params

  steps :parse_params,
        :save_user_info,
        :calculate_base_score,
        :calculate_insurance_plans


  def call
    process_steps
    @response
  end

  private

  def parse_params
    received_params = user_info_params.to_h.deep_symbolize_keys
    vehicle_year = received_params.dig(:vehicle, :year)
    house_ownership_status = received_params.dig(:house, :ownership_status)

    @params = received_params.except(:vehicle, :house)
    init_vehicule(@params, vehicle_year)
    init_house(@params, house_ownership_status)
  end

  def save_user_info
    @user_info = UserInfo.create(@params)

    fail(@user_info.errors.full_messages) unless @user_info.persisted?
  end

  def calculate_base_score
    @base_score = @params[:risk_questions].sum
  end

  def calculate_insurance_plans
    @response = InsurancePlan::Calculate.call(user_info: @user_info, base_score: @base_score).result
  end

  def init_vehicule(params, year)
    return if year.nil?

    params[:vehicle] = Vehicle.new(year: year)
  end

  def init_house(params, ownership_status)
    return if ownership_status.nil?

    params[:house] = House.new(ownership_status: ownership_status)
  end
end
