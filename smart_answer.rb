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
  
  def outcome
    student_origin_info = (student_origin == EU) ? 'EU' : 'UK'
    study_mode_info = full_time? ? 'Full-Time' : 'Part-Time'
    childcare_grant_info = nil
    if (has_children && student_origin == UK && full_time?)
      childcare_grant_info = 'Info about childcare grant'
    end
    "#{student_origin_info} #{study_mode_info} #{tuition_fees} #{childcare_grant_info}"
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
end
