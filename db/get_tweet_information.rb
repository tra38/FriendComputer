require 'twitter'
require 'pp'
require_relative 'alchemyapi'

class Tweet_Scraper
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    @alchemyapi = AlchemyAPI.new()
  end

  def get_tweet_information(twitter_handle)
    #This sets up the Twitter Handle up in our database.
    twitter_handle_db = TwitterHandle.create(twitter_id: twitter_handle)

    #This is a blank array that is used to store information about
    #the tweet's text.
    tweet_information = []

    #Access the last 20 Tweets by a user and store them in
    #a Tweet_Information array
    @client.user_timeline(twitter_handle).each do |tweet|
      tweet_information << tweet.text
    end

    #Join the Tweet_Information array together into a single string,
    #to give more data for the AlchemyAPI to analyze
    tweet_information = tweet_information.join(" ")
    send_info_to_alchemyapi(tweet_information, twitter_handle, twitter_handle_db)
  end

  def send_info_to_alchemyapi(tweet_information, twitter_handle, twitter_handle_db)
    response = @alchemyapi.keywords('text', tweet_information, { 'sentiment' => 1 })
    if response['status'] == 'OK'
      puts "Uploading #{twitter_handle}'s Tweets:"
      for keyword in response['keywords']
        twitter_handle_db.keywords.create(text: keyword['text'], relevance: keyword['relevance'], sentiment: keyword['sentiment']['type'], sentiment_strength: keyword['sentiment']['score'])
      end
    else
      puts "ERROR, ERROR, ERROR! Error:"
      puts response['statusInfo']
    end
  end

end
