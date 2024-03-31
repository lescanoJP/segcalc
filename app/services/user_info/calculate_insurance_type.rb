class UserInfo::CalculateInsuranceType < BusinessProcess::Base
  needs :user_info_params

  steps :parse_params,
        :save_user_info

  def call
    process_steps
    @user_info
  end

  private

  def parse_params
    received_params = user_info_params.to_h.deep_symbolize_keys
    vehicle_year = received_params.dig(:vehicle, :year)
    house_ownership_status = received_params.dig(:house, :ownership_status)
    byebug
    @params = received_params.except(:vehicle, :house)
    @params[:vehicle] = Vehicle.new(year: vehicle_year)
    @params[:house] = House.new(ownership_status: house_ownership_status)
  end

  def save_user_info
    byebug
    @user_info = UserInfo.create(@params)
  end
end
