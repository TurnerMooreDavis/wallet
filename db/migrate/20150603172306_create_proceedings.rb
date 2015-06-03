class CreateProceedings < ActiveRecord::Migration
  def change
    create_table :proceedings do |t|
      t.string :name
      t.decimal :amount
      t.string :action

      t.timestamps null: false
    end
  end
end
