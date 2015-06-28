class AddFieldsToReports < ActiveRecord::Migration
  def change
    add_column :reports, :smell_rating, :integer
    add_column :reports, :clean_rating, :integer
    add_column :reports, :driver_rating, :integer
    add_reference :reports, :muni, index: true, foreign_key: true
  end
end
