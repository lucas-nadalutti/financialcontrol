class ChangeTypeOfTransactionsDatetime < ActiveRecord::Migration
  def up
		change_table :transactions do |t|
			t.change :datetime, :datetime
		end
  end

  def down
		change_table :transactions do |t|
			t.change :datetime, :datetime
		end
  end
end
