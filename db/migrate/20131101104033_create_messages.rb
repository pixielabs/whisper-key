class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :encrypted_data
      t.integer :user_id

      t.timestamps
    end

    add_index :messages, :user_id
  end
end
