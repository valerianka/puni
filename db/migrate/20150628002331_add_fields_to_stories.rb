class AddFieldsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :content, :text
    add_column :stories, :img_url, :string
    add_reference :stories, :report, index: true, foreign_key: true
  end
end
