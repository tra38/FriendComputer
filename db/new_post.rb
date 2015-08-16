require_relative 'alchemyapi'
require 'twitter'
require 'pp'
require ::File.expand_path('../../config/environment', __FILE__)
require_relative 'get_tweet_information'
require_relative 'write_blog_posts'

tweetscraper = Tweet_Scraper.new

#ARGV[0] refers to a command line argument that you pass.
#The program will use this command line argument to determine
#what Twitter Handle to access.
twitter_handle = ARGV[0]

tweetscraper.get_tweet_information(twitter_handle)

Post.create(title: Word.title(twitter_handle),
  full_text: PostConstructor.write_blog_post(TwitterHandle.find_by(twitter_id: twitter_handle))
)
