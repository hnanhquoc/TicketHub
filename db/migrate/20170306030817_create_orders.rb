class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.integer :quantity
      t.belongs_to :ticket_type, foreign_key: true

      t.timestamps
    end
  end
end
