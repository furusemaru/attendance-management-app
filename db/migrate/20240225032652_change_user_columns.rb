class ChangeUserColumns < ActiveRecord::Migration[7.0]
  def change
    # 既存のカラムを変更
    rename_column :users, :name, :first_name

    # 新しいカラムを追加
    add_column :users, :last_name, :string
    add_column :users, :department, :string
    add_column :users, :employee_id, :string
  end
end
