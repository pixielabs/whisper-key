class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :magic_words
      t.text :public_key

      t.timestamps
    end

    add_index :users, :magic_words, unique: true
  end
end
