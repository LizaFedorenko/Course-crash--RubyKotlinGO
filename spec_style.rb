require 'minitest/autorun'
require 'minitest/spec'
require_relative 'Student'
require 'minitest/reporters'



Minitest::Reporters.use! [
Minitest::Reporters::HtmlReporter.new(
reports_dir: 'test/reports/spec',
report_filename: 'test_spec_results.html'
)]


describe Student do
  before do
    Student.class_variable_set(:@@students, [])
    @student1 = Student.add_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
    @student2 = Student.add_student('Surname', 'Yelyzaveta', "2004-09-12")
  
  end
  
  after do
    
    Student.class_variable_set(:@@students, [])
  
  end
  
  it 'raises an ArgumentError' do
    expect { Student.new('Some', 'Thing', 'invalid_date') }.must_raise(ArgumentError)
  end

  it 'raises an ArgumentError' do
    expect {Student.add_student('Fedorenko', 'Yelyzaveta', "2004-09-12")}.must_raise(ArgumentError)
  end

  it 'returns students by name' do
    expect(Student.get_students_by_name('Yelyzaveta')).must_equal([@student1, @student2])
  end

  describe '.remove_student' do
    it 'removes specified students' do
      Student.remove_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
      Student.remove_student('Surname', 'Yelyzaveta', "2004-09-12")
      expect(Student.get_students_by_name('Yelyzaveta')).must_equal([])
    end
  end
  it 'get by age' do
    expect(Student.get_students_by_age(20)).must_equal([@student1, @student2])
  end

  it 'calculates age' do
    expect(20).must_equal(@student1.age)
  end

  describe '#initialize' do
      
    student = Student.new("Will", "William", "2004-07-07")
    expected_attributes = {
      surname: "Will",
      name: "William",
      date_of_birth: "2004-07-07",
      age: 20
    }
  
    it 'initializes' do
    assert_equal expected_attributes[:surname], student.surname
    assert_equal expected_attributes[:name], student.name
    assert_equal expected_attributes[:date_of_birth], student.date_of_birth
    assert_equal expected_attributes[:age], student.age
    end 
  end
end

  

