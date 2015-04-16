class SmartAnswer
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
    maintenance_grant = case household_income
    when 0..25000
      3387
    when 25001..42620
      3387 - ((household_income - 25000) / 5.28).floor
    else
      0
    end
    "#{student_origin_info} #{study_mode_info} Tuition fees: #{tuition_fees} #{childcare_grant_info} Maintenance grant: #{maintenance_grant}"
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
end
