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

  def outcome
    student_origin_info = (student_origin == EU) ? 'EU' : 'UK'
    study_mode_info = (study_mode == PART_TIME) ? 'Part-Time' : 'Full-Time'
    "#{student_origin_info} #{study_mode_info} #{tuition_fees}"
  end
  
  def valid?
    if study_mode == FULL_TIME
      tuition_fees <= FULL_TIME_TUITION_FEES_MAXIMUM
    else
      tuition_fees <= PART_TIME_TUITION_FEES_MAXIMUM
    end
  end
end
