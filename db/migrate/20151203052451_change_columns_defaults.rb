class ChangeColumnsDefaults < ActiveRecord::Migration
  def up
    change_column :munis, :avg_smell_rating, :integer, default: 1
    change_column :munis, :avg_clean_rating, :integer, default: 1
    change_column :munis, :avg_driver_rating, :integer, default: 1
  end

  def down
    change_column :munis, :avg_smell_rating, :integer, default: 0
    change_column :munis, :avg_clean_rating, :integer, default: 0
    change_column :munis, :avg_driver_rating, :integer, default: 0
  end
end
