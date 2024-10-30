require 'date'

class Student 
  @@students = []
  attr_accessor :surname, :name, :date_of_birth, :age
  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth
    @age = calculate_age
  end

  def calculate_age
    birth_date = Date.parse(@date_of_birth) 
    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date.next_year(age)
    raise ArgumentError, "Date is incorrect" if age < 0
    age
  end

  def self.add_student(surname, name, date_of_birth)
    student = Student.new(surname, name, date_of_birth)
    raise ArgumentError, "This student is already in list" if @@students.any? { |student| 
    student.surname == surname && 
    student.name == name && 
    student.date_of_birth == date_of_birth
  }
    @@students << student
    student
  end

  def self.remove_student(surname, name, date_of_birth)
    @@students.delete_if { |student| student.surname == surname && student.name == name && student.date_of_birth ==  date_of_birth}
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end
end

student1 = Student.add_student('Fedorenko', 'Yelyzaveta', "2004-09-12")
student2 = Student.add_student('Smith', 'John', "2004-09-12")
student2 = Student.add_student('Zelenskii', 'John', "2004-09-12")

students_age = Student.get_students_by_age(20)
students_name = Student.get_students_by_name('John')

p students_age
#p students_name