class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  def change
    # 変更内容
  def up
    change_column :users, :email, :string, null: false, default: nil
  end

  # 変更前の状態
  def down
    change_column :users, :email, :string, null: false, default: ""
  end
  end
end
