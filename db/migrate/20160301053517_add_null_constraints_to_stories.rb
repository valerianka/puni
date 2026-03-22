class AddNullConstraintsToStories < ActiveRecord::Migration
  def change    
    change_column_null :stories, :content, false
    change_column_null :stories, :report_id, false
  end
end
