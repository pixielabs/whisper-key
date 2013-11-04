class MakeMagicWordsCaseInsensitive < ActiveRecord::Migration
  def up
    execute "CREATE EXTENSION citext"
    change_column :users, :magic_words, :citext
  end

  def down
    change_column :users, :magic_words, :string
  end
end
