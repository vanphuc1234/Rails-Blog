class DropProductTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :products do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
