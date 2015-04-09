# Creating and retreiving Classes and their Objects
#
# In this exercise, we're going to create a command line blogging tool that
# will be able to take user input destined for a blog, and model it with
# Classes and Objects.
#
# First, we're going to want to populate a class that represents a blog post.
# This blog post will have three separate attributes: title, author and body.
# The class has been created for you below, but you will need to write the
# getters and setters for each of the three attributes. Do so inside the class
# definition below.
class Post
  def title=(submitted_title)
    @title = submitted_title
  end

  def author=(submitted_author)
    @author = submitted_author
  end

  def body=(submitted_body)
    @body = submitted_body
  end

  def name
    @name
  end

  def title
    @title
  end

  def author
    @author
  end

  def body
    @body
  end
end

# Next, we have a class that has already been created for us called `Author`.
# This class models the attributes and methods that an author of a post would
# typically have. You will need to create getters and setters for the following
# three attributes: first_name, last_name and email.
class Author

  def first_name=(submitted_first_name)
    @first_name = submitted_first_name
  end

  def first_name
    @first_name
  end

  def last_name=(submitted_last_name)
    @last_name = submitted_last_name
  end

  def last_name
    @last_name
  end

  def email=(submitted_email)
    @email = submitted_email
  end

  def email
    @email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # Once the class is defined, create a method called `full_name` which uses
  # string interpolation to join together the first_name and last_name and
  # returns the Author's full name.

end

# Great, now that the classes have been created, let's instantiate the Author
# object and store it to a variable called `author`.
author = Author.new


# The code below will do the following. There should be no need to edit it:
#  1. Welcome the user to the command line program.
#  2. Ask for their first name, and store it in the newly instantiated author
#     object.
#  3. Ask for their last name, and store it in the newly instantiated author
#     object.
#  4. Greet them by their full name, by calling the `full_name` method on
#     author.
#  5. Ask for their email and store it in the newly instantiated author object.
puts 'Hi there, welcome to the wordpress command line program'
puts
puts 'To start, please enter your first name:'
author.first_name = gets.strip
puts 'Thanks. Please enter your last name:'
author.last_name = gets.strip
puts "Nice to meet you #{author.full_name}! One last thing, please enter your email:"
author.email = gets.strip
puts "Great, thanks for that info. Let's add some posts"
puts

# Below, we create an empty array called `posts` so that we can store all of
# the posts in one place. There should be no need to edit this line.
posts = []

# The below line declares a variable called `ask_for_posts` which we will use
# to determine whether or not we should continue to loop. There should be no
# need to edit this line or the `while` loop.
ask_for_posts = true
while ask_for_posts == true

  # Inside of this loop, we're going to ask the user to input the various
  # attributes of their blog post. Let's start by instantiating a new Post and
  # storing it in a variable called `post`.

  post = Posts.new

  # The below line simply displays on the screen a request for the user to
  # input the title of their post. There should be no need to edit this line.
  puts 'Please enter the title of your post:'

  # Next, let's use `gets.strip` and store the contents in the title attribute
  # of the newly instantiated `post` object that you created above.
  post.title = gets.strip

  # The below line simply displays on the screen a request for the user to
  # input the body of their post. There should be no need to edit this line.
  puts 'Please enter the body of your post:'

  # Next, let's use `gets.strip` and store the contents in the body attribute
  # of the newly instantiated `post` object that you created above.
  @post.body = gets.strip

  # Lastly, before we finalize this post, let's be sure to populate the
  # `author` attribute of the newly instantiated `post` object that you created
  # above. Since we have a variable called `author` which we populated in the
  # welcome message of the application, we already know who the user is. Let's
  # store the _entire_ author variable inside of the author attribute of Post.
  post.author = author

  # This line will add the current `post` to the `posts` array. There should be
  # no need to edit this line.
  posts << post

  # Finally, we ask the user if they would like to continue asking for posts.
  # There should be no need to edit the below two lines
  puts 'Would you like to add another post? Type `exit` if you would like to quit'
  ask_for_posts = false if gets.strip == 'exit'
end

# Finally, let's check our work to make sure that all of the user entered is
# being shown. There should be no need to edit below this line. Be sure to
# check that all of the attributes are being populated when this program is
# run.
puts
puts "Here are your posts:"
posts.each do |post|
  puts "Title: #{post.title}"
  puts "By: #{post.author.full_name}"
  puts post.body
  puts "Contact the author at: #{post.author.email}"
  puts
end