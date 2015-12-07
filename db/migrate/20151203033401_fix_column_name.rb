class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :munis, :avg_smelling_rating, :avg_smell_rating
  end
end
