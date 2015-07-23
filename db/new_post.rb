require './alchemyapi'
require 'twitter'
require 'pp'
require_relative 'get_tweet_information'

#Set up the Twitter API, to allow us to grab Tweets.
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

#ARGV[0] refers to a command line argument that you pass.
#The program will use this command line argument to determine
#what Twitter Handle to access.
twitter_handle = ARGV[0]

get_tweet_information(twitter_handle)
