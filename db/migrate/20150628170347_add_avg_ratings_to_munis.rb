class AddAvgRatingsToMunis < ActiveRecord::Migration
  def change
    add_column :munis, :avg_smelling_rating, :integer
    add_column :munis, :avg_clean_rating, :integer
    add_column :munis, :avg_driver_rating, :integer
  end
end
