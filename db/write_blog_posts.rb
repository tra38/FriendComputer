require ::File.expand_path('../../config/environment', __FILE__)
class Word
  def self.educate
    ["educate","teach","inform"].sample
  end

  def self.wonderful
    ["wonderful","exciting","mind-blowing","amazing"].sample
  end

  def self.essay(args)
    "#{Word.introduction(args[:twitter_id])} #{Word.important_statement(args[:most_important_keyword], args[:twitter_id], args[:most_important_keyword_value])} #{Word.happiest_statement(args[:happiest_keyword], args[:twitter_id], args[:happiest_keyword_value])} #{Word.saddest_statement(args[:saddest_keyword], args[:twitter_id], args[:saddest_keyword_value])} #{Word.conclusion(args[:twitter_id])}"
  end

  def self.introduction(twitter_id)
    ["I am a great fan of #{twitter_id}, and I wanted to #{educate} people about this person's #{wonderful} beliefs.","Recently, I have been browsing the web and stumbled upon #{twitter_id}'s Twitter Account. I want to #{educate} people about this #{wonderful} account.","If I ever wanted to learn more about the world, I would head straight to the twitter account of #{twitter_id} and read the #{wonderful} tweets that are contained there.", "#{twitter_id} is an expert in content curation, and would frequently post #{wonderful} content to #{educate} the audience. Today, I will #{educate} you about #{twitter_id}.","#{twitter_id}'s #{wonderful} tweets will help to #{educate} our future generations. To help guide you on the path to understanding, I have decided to give an overview of #{twitter_id}'s personal beliefs.","#{twitter_id} has developed a #{wonderful} social media presence that should not be underestimed. I studied #{twitter_id}'s twitter account deeply and want to convey my insights to you."].sample
  end

  def self.explaining
    ["the concept of", "the idea behind", "the system underpinning the", "explaining", "understanding", "discovering", "conveying information about"].sample
  end

  def self.fears
    ["fears", "dreads", "hates", "loathes", "opposes", "dislikes"].sample
  end

  def self.helpful
    ["accommodating", "helpful", "nice", "steadying", "reformative", "excellent", "brilliant"].sample
  end

  def self.reading
    ["reading", "studying","examining","understanding","interpreting","translating","discovering"].sample
  end

  def self.title(twitter_id)
    ["Learning about #{twitter_id}", "Discovering #{twitter_id}", "Examining #{twitter_id}","Explaining #{twitter_id}","An Introduction To #{twitter_id}"].sample
  end

  def self.importance(most_important_keyword_value)
    case
    when most_important_keyword_value < 0.25
      "slightly"
    when most_important_keyword_value < 0.5
      "reasonably"
    when most_important_keyword_value < 0.75
      "intensely"
    else
      "fanatically"
    end
  end

  def self.important_statement(most_important_keyword, twitter_id, most_important_keyword_value)
    "#{twitter_id} #{importance(most_important_keyword_value)} cares about #{explaining} #{most_important_keyword}."
  end

  def self.happiest_statement(happiest_keyword, twitter_id, happiest_keyword_value )
    "#{twitter_id} #{importance(happiest_keyword_value)} enjoys #{explaining} #{happiest_keyword}."
  end

  def self.saddest_statement(saddest_keyword, twitter_id, saddest_keyword_value)
    "#{twitter_id} #{importance(saddest_keyword_value)} #{fears} #{saddest_keyword}."
  end

  def self.conclusion(twitter_id)
    "#{twitter_id} is a very #{helpful} fellow who you should follow. I have learned a lot from #{reading} #{twitter_id}'s insights, and you too can benefit as well."
  end

  def self.title(twitter_id)
    ["Learning about #{twitter_id}", "Discovering #{twitter_id}", "Examining #{twitter_id}","Explaining #{twitter_id}","An Introduction To #{twitter_id}"].sample
  end

end

class PostConstructor
  def self.write_blog_post(twitter_handle_db)
    most_important_keyword = nil
    most_important_keyword_value = 0
    happiest_keyword = nil
    happiest_keyword_value = 0
    saddest_keyword = nil
    saddest_keyword_value = 0
    twitter_handle_db.keywords.each do |keyword|
      sentiment_value = keyword.sentiment_strength.to_f
      relevance_value = keyword.relevance.to_f
      if keyword.sentiment == "positive" && (sentiment_value > happiest_keyword_value)
        happiest_keyword = keyword.text
        happiest_keyword_value = sentiment_value
      elsif keyword.sentiment == "negative" && (sentiment_value < saddest_keyword_value)
        saddest_keyword = keyword.text
        saddest_keyword_value = sentiment_value
      end
      if (relevance_value > most_important_keyword_value)
        most_important_keyword = keyword.text
        most_important_keyword_value = relevance_value
      end
    end
    "#{Word.essay(twitter_id: twitter_handle_db.twitter_id, most_important_keyword: most_important_keyword, happiest_keyword: happiest_keyword, saddest_keyword: saddest_keyword, most_important_keyword_value: most_important_keyword_value, happiest_keyword_value: happiest_keyword_value, saddest_keyword_value: saddest_keyword_value)}"
  end

end
