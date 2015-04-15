class SmartAnswer
  EU_FULL_TIME = :eu_full_time
  EU_PART_TIME = :eu_part_time

  FULL_TIME_TUITION_FEES_MAXIMUM = 9000
  PART_TIME_TUITION_FEES_MAXIMUM = 6750

  attr_accessor :student_type
  attr_accessor :tuition_fees

  def outcome
    text = (student_type == EU_FULL_TIME) ? "EU Full-Time" : "EU Part-Time"
    "#{text} #{tuition_fees}"
  end
  
  def valid?
    if student_type == EU_FULL_TIME
      tuition_fees <= FULL_TIME_TUITION_FEES_MAXIMUM
    else
      tuition_fees <= PART_TIME_TUITION_FEES_MAXIMUM
    end
  end
end
