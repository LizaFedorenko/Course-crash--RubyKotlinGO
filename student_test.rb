require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [
Minitest::Reporters::HtmlReporter.new(
reports_dir: 'test/reports',
report_filename: 'test_results.html'
)]

require_relative 'Student'

class StudentTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, [])
    @student1 = Student.add_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
    @student2 = Student.add_student('Surname', 'Yelyzaveta', "2004-09-12")
  
  end
  
  def teardown
    
    Student.class_variable_set(:@@students, [])
  
  end

  def test_for_invalid_date
    assert_raises(ArgumentError) do
      Student.new('Some', 'Thing', 'invalid_date')
    end
  end

  def test_add_duplicate_student
    assert_raises(ArgumentError) do
      Student.add_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
    end
  end

  def test_get_by_name

       assert_equal Student.get_students_by_name('Yelyzaveta'), [@student1, @student2]

  end

  def test_remove
    Student.remove_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
    Student.remove_student('Surname', 'Yelyzaveta', "2004-09-12")
    assert_equal Student.get_students_by_name('Yelyzaveta'), []
  end

  def test_get_by_age

    assert_equal Student.get_students_by_age(20), [@student1, @student2]

  end

  def test_calculate_age

    assert_equal 20, @student1.age

  end

  def test_initialize
      
    student = Student.new("Will", "William", "2004-07-07")
    expected_attributes = {
      surname: "Will",
      name: "William",
      date_of_birth: "2004-07-07",
      age: 20
    }
  
      
    assert_equal expected_attributes[:surname], student.surname
    assert_equal expected_attributes[:name], student.name
    assert_equal expected_attributes[:date_of_birth], student.date_of_birth
    assert_equal expected_attributes[:age], student.age


    end 
end
