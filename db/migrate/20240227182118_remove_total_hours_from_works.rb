class RemoveTotalHoursFromWorks < ActiveRecord::Migration[7.0]
  def change
    remove_column :works, :total_hours, :float
  end
end
