require 'bundler/setup'
require 'rspec'

$LOAD_PATH.unshift('.')

require 'smart_answer'

RSpec.describe SmartAnswer do
  context 'EU student full-time' do
    before do
      subject.student_type = SmartAnswer::EU_FULL_TIME
      subject.tuition_fees = 8000
    end

    it 'should display information about finance for full-time EU students' do
      expect(subject.outcome).to match('EU Full-Time')
    end

    it 'should display tuition fees' do
      expect(subject.outcome).to match('8000')
    end
    
    it 'should have valid tuition fees if fees are less than or equal to the maximum' do
      subject.tuition_fees = SmartAnswer::FULL_TIME_TUITION_FEES_MAXIMUM
      expect(subject).to be_valid
    end
    
    it 'should not have valid tuition fees if fees are more than the maximum' do
      subject.tuition_fees = SmartAnswer::FULL_TIME_TUITION_FEES_MAXIMUM + 1
      expect(subject).to_not be_valid
    end
  end

  context 'EU student part-time' do
    before do
      subject.student_type = SmartAnswer::EU_PART_TIME
      subject.tuition_fees = 6000
    end

    it 'should display information about finance for part-time EU students' do
      expect(subject.outcome).to match('EU Part-Time')
    end

    it 'should display tuition fees' do
      expect(subject.outcome).to match('6000')
    end
    
    it 'should have valid tuition fees if fees are less than or equal to the maximum' do
      subject.tuition_fees = SmartAnswer::PART_TIME_TUITION_FEES_MAXIMUM
      expect(subject).to be_valid
    end
    
    it 'should not have valid tuition fees if fees are more than the maximum' do
      subject.tuition_fees = SmartAnswer::PART_TIME_TUITION_FEES_MAXIMUM + 1
      expect(subject).to_not be_valid
    end
  end

  context 'UK student full-time' do
    before do
      subject.student_type = SmartAnswer::UK_FULL_TIME
      subject.tuition_fees = 8000
    end
    
    it 'should display information about finance for full-time UK students' do
      expect(subject.outcome).to match('UK Full-Time')
    end

    it 'should display tuition fees' do
      expect(subject.outcome).to match('8000')
    end

    it 'should have valid tuition fees if fees are less than or equal to the maximum' do
      subject.tuition_fees = SmartAnswer::FULL_TIME_TUITION_FEES_MAXIMUM
      expect(subject).to be_valid
    end
    
    it 'should not have valid tuition fees if fees are more than the maximum' do
      subject.tuition_fees = SmartAnswer::FULL_TIME_TUITION_FEES_MAXIMUM + 1
      expect(subject).to_not be_valid
    end
  end

  context 'UK student part-time' do
    before do
      subject.student_type = SmartAnswer::UK_PART_TIME
      subject.tuition_fees = 6000
    end
    
    it 'should display information about finance for part-time UK students' do
      expect(subject.outcome).to match('UK Part-Time')
    end

    it 'should display tuition fees' do
      expect(subject.outcome).to match('6000')
    end

    it 'should have valid tuition fees if fees are less than or equal to the maximum' do
      subject.tuition_fees = SmartAnswer::PART_TIME_TUITION_FEES_MAXIMUM
      expect(subject).to be_valid
    end
    
    it 'should not have valid tuition fees if fees are more than the maximum' do
      subject.tuition_fees = SmartAnswer::PART_TIME_TUITION_FEES_MAXIMUM + 1
      expect(subject).to_not be_valid
    end
  end
end
