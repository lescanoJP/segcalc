class UserInfo::CalculateInsuranceType < BusinessProcess::Base
  needs :user_info_params

  steps :parse_params,
        :save_user_info,
        :calculate_base_score,
        :init_score_calculation,
        :init_insurance_plan,
        :check_if_can_have_basic_insurances,
        :check_if_user_is_sixty,
        :check_user_age,
        :check_user_income,
        :check_if_user_house_is_rented,
        :check_if_has_dependents,
        :check_if_user_is_married,
        :check_vehicle,
        :calculate_insurance,
        :parse_response


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

  def init_score_calculation
    @auto = @base_score
    @disability = @base_score
    @life = @base_score
    @home = @base_score
  end

  def init_insurance_plan
    @auto_plan = ''
    @disability_plan = ''
    @life_plan = ''
    @home_plan = ''
  end

  def check_if_can_have_basic_insurances
    return if @user_info.check_insurance_possibility

    @auto_plan = 'inelegivel'
    @home_plan = 'inelegivel'
    @disability_plan = 'inelegivel'
  end

  def check_if_user_is_sixty
    return unless @user_info.is_sixty?

    @disability_plan = 'inelegivel'
    @life_plan = 'inelegivel'
  end

  def check_user_age
    if @user_info.age < 30
      @auto = @auto - 2
      @disability = @disability - 2
      @life = @life - 2
      @home = @home -2
    elsif @user_info.age >= 30 && @user_info.age <= 40
      @auto = @auto - 1
      @disability = @disability - 1
      @life = @life - 1
      @home = @home -1
    end
  end

  def check_user_income
    return if @user_info.income <= 200_000

    @auto = @auto - 1
    @disability = @disability - 1
    @life = @life - 1
    @home = @home -1
  end

  def check_if_user_house_is_rented
    return if @user_info.house.nil?
    return if @user_info.house.ownership_status.owned?

    @home = @home + 1
    @disability = @disability + 1
  end

  def check_if_has_dependents
    return if @user_info.dependents.zero?

    @disability = @disability + 1
    @life = @life + 1
  end

  def check_if_user_is_married
    return if @user_info.marital_status.single?

    @home = @home + 1
    @disability = @disability - 1
  end

  def check_vehicle
    return if @user_info.vehicle.nil?
    return unless @user_info.vehicle.is_recent_made?

    @auto = @auto + 1
  end

  def calculate_insurance
    @insurance_plan = @user_info.build_insurance_plan(auto: calculate_plan(@auto_plan, @auto),
                                                      disability: calculate_plan(@disability_plan, @disability),
                                                      home: calculate_plan(@home_plan, @home),
                                                      life: calculate_plan(@life_plan, @life))

    fail(@insurance_plan.errors.full_messages) unless @insurance_plan.save
  end

  def parse_response
    @response = {
      auto: @insurance_plan.auto,
      disability: @insurance_plan.disability,
      home: @insurance_plan.home,
      life: @insurance_plan.life
    }
  end

  def calculate_plan(insurance_type, score)
    return insurance_type if insurance_type.present?

    if score <= 0
      @plan = 'economico'
    elsif score >= 1 && score <= 2
      @plan = 'padrao'
    else
      @plan = 'avancado'
    end
    @plan
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
