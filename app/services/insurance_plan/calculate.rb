class InsurancePlan::Calculate < BusinessProcess::Base
  needs :user_info
  needs :base_score

  steps :init_score_calculation,
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

  def init_score_calculation
    @auto = base_score
    @disability = base_score
    @life = base_score
    @home = base_score
  end

  def init_insurance_plan
    @auto_plan = ''
    @disability_plan = ''
    @life_plan = ''
    @home_plan = ''
  end

  def check_if_can_have_basic_insurances
    return if user_info.check_insurance_possibility

    @auto_plan = 'inelegivel'
    @home_plan = 'inelegivel'
    @disability_plan = 'inelegivel'
  end

  def check_if_user_is_sixty
    return unless user_info.is_sixty?

    @disability_plan = 'inelegivel'
    @life_plan = 'inelegivel'
  end

  def check_user_age
    if user_info.age < 30
      @auto = @auto - 2
      @disability = @disability - 2
      @life = @life - 2
      @home = @home -2
    elsif user_info.age >= 30 && user_info.age <= 40
      @auto = @auto - 1
      @disability = @disability - 1
      @life = @life - 1
      @home = @home -1
    end
  end

  def check_user_income
    return if user_info.income <= 200_000

    @auto = @auto - 1
    @disability = @disability - 1
    @life = @life - 1
    @home = @home -1
  end

  def check_if_user_house_is_rented
    return if user_info.house.nil?
    return if user_info.house.ownership_status.owned?

    @home = @home + 1
    @disability = @disability + 1
  end

  def check_if_has_dependents
    return if user_info.dependents.zero?

    @disability = @disability + 1
    @life = @life + 1
  end

  def check_if_user_is_married
    return if user_info.marital_status.single?

    @home = @home + 1
    @disability = @disability - 1
  end

  def check_vehicle
    return if user_info.vehicle.nil?
    return unless user_info.vehicle.is_recent_made?

    @auto = @auto + 1
  end

  def calculate_insurance
    @insurance_plan = user_info.build_insurance_plan(auto: calculate_plan(@auto_plan, @auto),
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
end
