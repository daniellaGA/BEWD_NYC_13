# Navigating APIs with Teddit & Reddit
#
# Throughout the last few lessons, we have built on the idea of a home-grown
# Reddit application called Teddit. Today we're going to bridge the
# functionality that we have built with Teddit with the actual website Reddit.
#
# Our goal is to get the top posts on reddit via their API, widdle down the
# unneeded metadata, and use our `calculate_upvotes` method to calculate the
# correct number of upvotes for each top story on Reddit right now. To do this,
# we're going to test our skills with iteration, hashes and methods.

# Since we're going to be working with data that is coming from an API, we'll
# need to require the rest-client gem. It may be a good idea to also require
# pry if you plan on debugging. Do so below this line:

# This is the exact same method that we had from lesson 3. What's great about
# well written methods is that they can be easily transported from program to
# program if they're abstract enough. There should be no need to edit this
# method.
def calculate_upvotes(story, category)
  upvotes = 1

  upvotes *= 5 if story.downcase.include? 'cats' or category.downcase.include? 'cats'
  upvotes *= 8 if story.downcase.include? 'bacon' or category.downcase.include? 'bacon'
  upvotes *= 3 if story.downcase.include? 'food' or category.downcase.include? 'food'

  upvotes
end

# Next, let's define a variable called `url` that holds the string of the
# Reddit URL you would like to get data from. Some examples could be:
#   1. http://reddit.com/r/cats.json
#   2. http://reddit.com/r/worldnews.json
#   3. http://reddit.com/.json

require 'rest-client'
require 'json'
require 'pry'

url = 'http://www.reddit.com/r/cats.json'


# Now that we have the address of the website that we want to get, let's use
# `RestClient`'s `.get` method in order to download the url and let's store that
# in a variable called `response`.

response = RestClient.get(url)

# Let's continue by parsing the string that came back from RestClient (which we
# stored in `response`), using `JSON`'s `.parse` method, and store that in a
# variable called `parsed_response`.

parsed_response = JSON.parse(response)

# Once you've reached this point, feel free to put a `binding.pry` in your code
# so that you can inspect if you have any errors.

# Next, create an empty array called `posts`.
posts = []


# Now that we have structured data (arrays and hashes) stored in
# `parsed_response`, we're going to want to iterate over the array of posts,
# and create a new hash for each post with three attributes: title, category
# and upvotes.



#
# To do this, begin iterating over the posts in `parsed_response` (remember you
# can use both `.each`, or `.map`, depending on how it's used. I'd recommend
# starting with `.each` and later changing it to `.map` once it's working.
#
#   NOTE: `parsed_response` is a hash with two keys, you'll want to access the
#   'data' key first, and then the 'children' key in order to get an array of
#   all the posts.
#

  # Once inside the loop, let's stick a `binding.pry` in here so that we can
  # experiment with what sort of data is in each post. Run the file with the
  # ruby command, and if you want to exit out of pry, type `exit-program`.

  # Let's create three variables:
  # 1. title, which will access the 'title' attribute from the hash (you may
  # need to dig down into an attribute before you see the 'title' key.

  #loop_posts = parsed_response['data']['children'].map do |loop_post|
  parsed_response['data']['children'].each do |loop_post|
  title = loop_post['data']['title']
    puts title


  # 2. category, which will access the 'subreddit' attribute from the hash,
  # again, you may need to dig down into an attribute first before you see that
  # key of the hash


  category = loop_post['data']['subreddit']
    puts category

  # 3. Lastly, upvotes - which you will manually have to calculate using the
  # `calculate_upvotes` method at the top of this program. Remember that this
  # method takes two parameters, the title and the category. Execute the method
  # and store it's result in a variable titled upvotes.

  upvotes = calculate_upvotes(title, category)

  # This line create a new hash with three keys: :title, :category, and
  # :upvotes, and store it in a variable called posts. Remember, we're setting
  # the keys equal to the variables that you defined above (`title`, `category`
  # and `upvotes`), so those will need to be defined in order for this line to
  # work
  post = { title: title, category: category, upvotes: upvotes }

  # Lastly, this line will add the new hash into the empty `posts` array that
  # you defined above
  posts << post

# Be sure to end your loop here.
end




# Let's check our work, this line will iterate over each of the posts that you
# extracted the `title`, `category`, and `upvotes` for and display it out to
# the screen.
posts.each do |post|
  puts "Title: #{post[:title]}"
  puts "Category: #{post[:category].capitalize}"
  puts "Current Upvotes: #{post[:upvotes]}"
  puts
end



#FINAL INSTRUCTOR SOLUTION 
require 'rest-client'
require 'json'
require 'pry'

url = 'http://reddit.com/r/cats.json'

response = RestClient.get(url)
parsed_response = JSON.parse(response)

posts = parsed_response['data']['children'].map do |post|
  title = post['data']['title']
  category = post['data']['subreddit']
  raw_upvotes = post['data']['score']
  upvotes = calculate_upvotes(title, category, raw_upvotes)

  { title: title, category: category, upvotes: upvotes }
end

