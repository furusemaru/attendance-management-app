class ChangeBreakTimeColumnTypeInWorks < ActiveRecord::Migration[7.0]
  def change
    change_column :works, :break_time, :time
  end
end
