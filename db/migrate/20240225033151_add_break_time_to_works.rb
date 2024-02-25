class AddBreakTimeToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :break_time, :integer
  end
end
