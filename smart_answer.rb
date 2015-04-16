class SmartAnswer
  class MaintenanceGrant
    MAXIMUM = 3387
    HOUSEHOLD_INCOME_LOWER_THRESHOLD = 25000
    HOUSEHOLD_INCOME_UPPER_THRESHOLD = 42620
    HOUSEHOLD_INCOME_DIVISOR = 5.28

    attr_reader :student

    def initialize(student)
      @student = student
    end
    
    def available?
      student.uk_origin? && student.full_time?
    end
    
    def amount
      case student.household_income
      when 0..HOUSEHOLD_INCOME_LOWER_THRESHOLD
        MAXIMUM
      when (HOUSEHOLD_INCOME_LOWER_THRESHOLD + 1)..HOUSEHOLD_INCOME_UPPER_THRESHOLD
        household_income_above_lower_threshold = (student.household_income - HOUSEHOLD_INCOME_LOWER_THRESHOLD)
        MAXIMUM - (household_income_above_lower_threshold / HOUSEHOLD_INCOME_DIVISOR).floor
      else
        0
      end
    end
  end
  
  class Student
    attr_accessor :study_mode
    attr_accessor :student_origin
    attr_accessor :tuition_fees
    attr_accessor :has_children
    attr_accessor :household_income
    
    def full_time?
      study_mode == FULL_TIME
    end
  
    def uk_origin?
      student_origin == UK
    end
  end
  
  EU = :eu
  UK = :uk

  PART_TIME = :part_time
  FULL_TIME = :full_time

  FULL_TIME_TUITION_FEES_MAXIMUM = 9000
  PART_TIME_TUITION_FEES_MAXIMUM = 6750
  
  extend Forwardable

  def_delegator :@student, :study_mode, :study_mode
  def_delegator :@student, :student_origin, :student_origin
  def_delegator :@student, :tuition_fees, :tuition_fees
  def_delegator :@student, :has_children, :has_children
  def_delegator :@student, :household_income, :household_income

  def_delegator :@student, :study_mode=, :study_mode=
  def_delegator :@student, :student_origin=, :student_origin=
  def_delegator :@student, :tuition_fees=, :tuition_fees=
  def_delegator :@student, :has_children=, :has_children=
  def_delegator :@student, :household_income=, :household_income=
  
  def_delegator :@student, :full_time?, :full_time?
  def_delegator :@student, :uk_origin?, :uk_origin?

  def initialize
    @student = Student.new
  end
  
  def outcome
    student_origin_info = uk_origin? ? 'UK' : 'EU'
    study_mode_info = full_time? ? 'Full-Time' : 'Part-Time'
    childcare_grant_info = eligible_for_childcare_grant? ? 'Info about childcare grant' : nil
    maintenance_grant_info = eligible_for_maintenance_grant? ? "Maintenance grant: #{maintenance_grant}" : nil
    "#{student_origin_info} #{study_mode_info} Tuition fees: #{tuition_fees} #{childcare_grant_info} #{maintenance_grant_info}"
  end
  
  def valid?
    if full_time?
      tuition_fees <= FULL_TIME_TUITION_FEES_MAXIMUM
    else
      tuition_fees <= PART_TIME_TUITION_FEES_MAXIMUM
    end
  end
  
  def eligible_for_childcare_grant?
    has_children && uk_origin? && full_time?
  end
  
  def eligible_for_maintenance_grant?
    MaintenanceGrant.new(@student).available?
  end
  
  def maintenance_grant
    MaintenanceGrant.new(@student).amount
  end
end
