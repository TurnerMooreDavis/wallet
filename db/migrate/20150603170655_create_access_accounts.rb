class CreateAccessAccounts < ActiveRecord::Migration
  def change
    create_table :access_accounts do |t|
      t.string :name
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
