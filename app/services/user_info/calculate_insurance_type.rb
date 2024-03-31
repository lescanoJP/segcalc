class UserInfo::CalculateInsuranceType < BusinessProcess::Base
  needs :user_info_params

  steps :log_params

  def call
    process_steps
  end

  private

  def log_params
    puts user_info_params
  end
end
