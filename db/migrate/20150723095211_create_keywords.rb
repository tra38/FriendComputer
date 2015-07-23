class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :twitter_handle
      t.string :text
      t.string :relevance
      t.string :sentiment
      t.string :sentiment_strength, { default: "0" }

      t.timestamps null: false
    end
  end

end
