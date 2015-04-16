class SmartAnswer
  class MaintenanceGrant
    MAXIMUM = 3387
    HOUSEHOLD_INCOME_LOWER_THRESHOLD = 25000
    HOUSEHOLD_INCOME_UPPER_THRESHOLD = 42620
    HOUSEHOLD_INCOME_DIVISOR = 5.28

    attr_reader :household_income

    def initialize(household_income)
      @household_income = household_income
    end
    
    def amount
      case household_income
      when 0..HOUSEHOLD_INCOME_LOWER_THRESHOLD
        MAXIMUM
      when (HOUSEHOLD_INCOME_LOWER_THRESHOLD + 1)..HOUSEHOLD_INCOME_UPPER_THRESHOLD
        household_income_above_lower_threshold = (household_income - HOUSEHOLD_INCOME_LOWER_THRESHOLD)
        MAXIMUM - (household_income_above_lower_threshold / HOUSEHOLD_INCOME_DIVISOR).floor
      else
        0
      end
    end
  end
  
  EU = :eu
  UK = :uk

  PART_TIME = :part_time
  FULL_TIME = :full_time

  FULL_TIME_TUITION_FEES_MAXIMUM = 9000
  PART_TIME_TUITION_FEES_MAXIMUM = 6750
  
  attr_accessor :study_mode
  attr_accessor :student_origin
  attr_accessor :tuition_fees
  attr_accessor :has_children
  attr_accessor :household_income
  
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
  
  def full_time?
    study_mode == FULL_TIME
  end
  
  def uk_origin?
    student_origin == UK
  end
  
  def eligible_for_childcare_grant?
    has_children && uk_origin? && full_time?
  end
  
  def eligible_for_maintenance_grant?
    uk_origin? && full_time?
  end
  
  def maintenance_grant
    MaintenanceGrant.new(household_income).amount
  end
end
