require_relative 'get_tweet_information'

["Tariq_Ali38", "mark_amobi", "Bastonis_", "j12coder"].each do |tweet_user|
  get_tweet_information(tweet_user)
end
