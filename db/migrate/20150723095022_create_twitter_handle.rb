class CreateTwitterHandle < ActiveRecord::Migration
  def change
    create_table :twitter_handles do |t|
      t.string :twitter_id

      t.timestamps null: false
    end
  end

end
