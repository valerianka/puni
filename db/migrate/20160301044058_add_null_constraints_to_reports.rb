class AddNullConstraintsToReports < ActiveRecord::Migration
  def change
    change_column_null :reports, :smell_rating, false
    change_column_null :reports, :clean_rating, false
    change_column_null :reports, :driver_rating, false
    change_column_null :reports, :muni_id, false
  end
end
