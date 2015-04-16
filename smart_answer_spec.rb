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
  
  context 'EU student' do
    before do
      subject.student_origin = SmartAnswer::EU
    end

    context 'with children under 17' do
      before do
        subject.has_children = true
      end

      it 'should not display information about childcare grant' do
        expect(subject.outcome).not_to match('Info about childcare grant')
      end
    end
  end
  
  context 'UK student' do
    before do
      subject.student_origin = SmartAnswer::UK
    end
    
    it 'should display maximum maintenance grant amount if household income is less than or equal to 25000' do
      subject.household_income = 25000
      expect(subject.outcome).to match('3387')
    end
    
    it 'should display calculated maintenance grant amount if household income is greater than 25000 and less than or equal to 42620' do
      subject.household_income = 30000
      expect(subject.outcome).to match('2441')

      subject.household_income = 35000
      expect(subject.outcome).to match('1494')

      subject.household_income = 40000
      expect(subject.outcome).to match('547')

      subject.household_income = 42620
      expect(subject.outcome).to match('50')
    end
    
    it 'should display zero maintenance grant amount if household income is greater than 42620' do
      subject.household_income = 42620 + 1
      expect(subject.outcome).to match('0')
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
    
    context 'with children under 17' do
      before do
        subject.has_children = true
      end
      
      it 'should display information about childcare grant' do
        expect(subject.outcome).to match('Info about childcare grant')
      end
    end
    
    context 'without children under 17' do
      before do
        subject.has_children = false
      end

      it 'should not display information about childcare grant' do
        expect(subject.outcome).not_to match('Info about childcare grant')
      end
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

    context 'with children under 17' do
      before do
        subject.has_children = true
      end

      it 'should not display information about childcare grant' do
        expect(subject.outcome).not_to match('Info about childcare grant')
      end
    end
  end
end
