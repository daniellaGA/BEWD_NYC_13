class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :body
      t.string :author_name

      t.timestamps
    end
  end
end
