class ChangeAvgDefaults < ActiveRecord::Migration
  def change
    change_column :munis, :avg_smelling_rating, :integer, :default => 0
    change_column :munis, :avg_clean_rating, :integer, :default => 0
    change_column :munis, :avg_driver_rating, :integer, :default => 0

  end
end
