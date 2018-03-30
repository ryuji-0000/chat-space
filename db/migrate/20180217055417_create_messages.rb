class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :image
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.timestamps
    end
    add_index :users, :id
    add_index :groups, :id
  end
end
