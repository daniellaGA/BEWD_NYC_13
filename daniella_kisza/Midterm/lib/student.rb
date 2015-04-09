class Student
  attr_reader :student_id, :first_name, :last_name, :email, :status, :status_updated_at

  def initialize(student_data)
    @student_id = student_data[0]
    @first_name = student_data[1]
    @last_name = student_data[2]
    @email = student_data[3]
    @status = student_data[4]
    @status_updated_at = student_data[5]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
