class AddRouteNameToMunis < ActiveRecord::Migration
  def change
    add_column :munis, :route_name, :string
  end
end
