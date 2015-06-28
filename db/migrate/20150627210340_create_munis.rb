class CreateMunis < ActiveRecord::Migration
  def change
    create_table :munis do |t|

      t.timestamps null: false
    end
  end
end
