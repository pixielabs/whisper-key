class AddEncryptedKeyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :encrypted_key, :text
  end
end
