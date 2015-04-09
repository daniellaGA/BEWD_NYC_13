class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :body
      t.string :author_name

      t.timestamps
    end
  end
end
