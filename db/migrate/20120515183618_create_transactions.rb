class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
			t.integer :client_id
			t.integer :category_id
			t.integer :payment_method_id
      t.float :value
      t.date :datetime
      t.boolean :credit
			t.text :obs

      t.timestamps
    end
  end
end
