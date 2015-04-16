class SmartAnswer
  EU_FULL_TIME = :eu_full_time
  EU_PART_TIME = :eu_part_time
  UK_FULL_TIME = :uk_full_time
  UK_PART_TIME = :uk_part_time

  FULL_TIME_TUITION_FEES_MAXIMUM = 9000
  PART_TIME_TUITION_FEES_MAXIMUM = 6750

  attr_accessor :student_type
  attr_accessor :tuition_fees

  def outcome
    text = case student_type
    when EU_FULL_TIME
      "EU Full-Time"
    when EU_PART_TIME
      "EU Part-Time"
    when UK_FULL_TIME
      "UK Full-Time"
    when UK_PART_TIME
      "UK Part-Time"
    end
    "#{text} #{tuition_fees}"
  end
  
  def valid?
    case student_type
    when EU_FULL_TIME, UK_FULL_TIME
      tuition_fees <= FULL_TIME_TUITION_FEES_MAXIMUM
    else
      tuition_fees <= PART_TIME_TUITION_FEES_MAXIMUM
    end
  end
end
