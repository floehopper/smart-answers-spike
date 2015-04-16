require 'bundler/setup'
require 'rspec'

$LOAD_PATH.unshift('.')

require 'smart_answer'

RSpec.describe SmartAnswer do
  
  it 'should display tuition fees' do
    subject.tuition_fees = 6000
    expect(subject.outcome).to match('6000')
  end

  context 'Full-time student' do
    before do
      subject.study_mode = SmartAnswer::FULL_TIME
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

  context 'Part-time student' do
    before do
      subject.study_mode = SmartAnswer::PART_TIME
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

  context 'EU student full-time' do
    before do
      subject.study_mode = SmartAnswer::FULL_TIME
      subject.student_origin = SmartAnswer::EU
    end

    it 'should display information about finance for full-time EU students' do
      expect(subject.outcome).to match('EU Full-Time')
    end
  end

  context 'EU student part-time' do
    before do
      subject.study_mode = SmartAnswer::PART_TIME
      subject.student_origin = SmartAnswer::EU
    end

    it 'should display information about finance for part-time EU students' do
      expect(subject.outcome).to match('EU Part-Time')
    end
  end

  context 'UK student full-time' do
    before do
      subject.study_mode = SmartAnswer::FULL_TIME
      subject.student_origin = SmartAnswer::UK
    end
    
    it 'should display information about finance for full-time UK students' do
      expect(subject.outcome).to match('UK Full-Time')
    end
  end

  context 'UK student part-time' do
    before do
      subject.study_mode = SmartAnswer::PART_TIME
      subject.student_origin = SmartAnswer::UK
    end
    
    it 'should display information about finance for part-time UK students' do
      expect(subject.outcome).to match('UK Part-Time')
    end
  end
end
