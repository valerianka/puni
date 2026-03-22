class AddNullConstrainToMunis < ActiveRecord::Migration
  def change
    change_column_null :munis, :route_name, false
  end
end
