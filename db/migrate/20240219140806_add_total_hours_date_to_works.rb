class AddTotalHoursDateToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :total_hours, :float
    add_column :works, :date, :date
  end
end
