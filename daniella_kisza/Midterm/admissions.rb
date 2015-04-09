require 'pry'
require 'rightsignature'
require_relative 'lib/student'
require_relative 'lib/courses'
require_relative 'lib/ga'

# Reads in raw student data as array of arrays
csv = File.read('data/fewd.csv')
students_data = csv.split("\n").map do |student|
  student.split(',')
end

# Removes titles from raw student data
titles = students_data.shift

# Creates student objects from raw student data using class: student_data in student.rb
students = students_data.map do |student_data|
  Student.new(student_data)
end


# Initalizes connection with rightsignature
client = RightSignature::Connection.new(api_token: "vwttmGQ26nC6JkThn0ghOL8PptnXOaSefGvaSUUb")

# Build an array of hashes of templates
templates = client.templates_list['page']['templates']['template'].map do |template|
  {
    subject: template['subject'],
    guid: template['guid'],
    created_at: template['created_at']
  }
end

# Iterate over the array of hashes and prompt the user which template they would like to use
puts "Please choose a template:"
templates.each_with_index do |template, i|
  i += 1
  puts "#{i}: #{template[:subject]}, Created on: #{template[:created_at]}"
end

# Ask for the index of the template they would like to use
user_requested_template = gets.strip.to_i - 1

puts "Please enter the name of Admissions Producer to display on contract"
user_requested_admissions_name = gets.strip
puts "Please enter today's date in format MM/DD/YYYY"
current_date = gets.strip


def course_selection 
  #courses = ['Front-end Web Development', 'Back-end Web Development', 'Product Management', ]
  puts "Please choose a course:"
  COURSES.each_with_index do |course, i|
    puts "#{i + 1}: #{course[:name]}"
  end
  input = gets.strip.to_i
  COURSES[input - 1]
end

selected_course = course_selection

# Gets the unique ID of the first template
raw_template_guid = templates[user_requested_template][:guid]

# Loop over each student object
students.each do |student|
  # Prepackage a template for each particular student
  prepackaged_template = client.prepackage(raw_template_guid)
  # Finds the subject of the template defined in RightSignature
  template_subject = prepackaged_template['template']['subject']
  # Finds the new unique id for the new prepackaged student template
  template_guid = prepackaged_template['template']['guid']

  # Sets up the translation between what the user has to enter on the contract with.. 
  # ..what is in the student object
  options = {
    merge_fields: [
      {student_name: student.full_name},
      {admissions_signer: user_requested_admissions_name},
      {admissions_title: 'Admissions Prodcuer'},
      {certification_number: 'N/A'},
      {todays_date: current_date},
      {course_name: selected_course[:name]},
      {course_hours: selected_course[:hours]},
      {course_weeks: selected_course[:weeks]}
    ]
  }

  # Sends the template with the required parameters
  client.send_template(
    template_guid, 
    template_subject,
    [
      {'signer_A' => {name: student.full_name, email: student.email}}, 
      {'cc_A' => {name: 'Admissions', email: 'admissions@generalassemb.ly'}}
    ], 
    options
  )
end