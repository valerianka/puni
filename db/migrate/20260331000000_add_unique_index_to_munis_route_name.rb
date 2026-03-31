class AddUniqueIndexToMunisRouteName < ActiveRecord::Migration[7.2]
  def change
    add_index :munis, :route_name, unique: true
  end
end
