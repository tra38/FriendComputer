require_relative 'get_tweet_information'
require_relative 'write_blog_posts'

tweet_scraper = Tweet_Scraper.new

["Tariq_Ali38", "mark_amobi", "Bastonis_", "j12coder"].each do |tweet_user|
  tweet_scraper.get_tweet_information(tweet_user)
end

TwitterHandle.all.each do |twitter_handle_db|
  Post.create(title: Word.title(twitter_handle_db.twitter_id), full_text: PostConstructor.write_blog_post(twitter_handle_db))
end

