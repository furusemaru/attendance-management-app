class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.time :start_time
      t.time :end_time
      t.text :comment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :works, [:user_id, :created_at]
  end
end
