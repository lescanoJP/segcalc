class UserInfo < ApplicationRecord
  extend Enumerize

  has_one :vehicle
  has_one :house
  has_one :insurance_plan

  enumerize :marital_status, in: { single: 0, married: 1 }

  validates :marital_status, :age, :dependents, :income, presence: true

  validates :income, :dependents, :age, numericality: { greater_than_or_equal_to: 0 }

  validate :valid_risk_questions, on: :create
  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :house

  def check_insurance_possibility
    vehicle.present? && house.present? && income.positive?
  end

  def is_sixty?
    age >= 60
  end

  def valid_risk_questions
    risk_questions_array = JSON.parse(risk_questions)

    if risk_questions_array.length > 3 || risk_questions.length < 3
      errors.add(:base, :risk_questions_size)
      throw :abort
    end

    values = risk_questions_array.map { |question| question.is_a?(Integer) && (question == 0 || question == 1) }

    if values.include?(false)
      errors.add(:base, :risk_question_invalid)
    end
  end

end
