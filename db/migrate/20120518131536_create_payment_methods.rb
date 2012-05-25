class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
			t.string :method
			t.string :bank
			t.string :addit_info

      t.timestamps
    end
  end
end
