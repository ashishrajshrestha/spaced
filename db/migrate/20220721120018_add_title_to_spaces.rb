class AddTitleToSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :spaces, :title, :string
  end
end
