class AddLocationToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :location, :string
  end
end
