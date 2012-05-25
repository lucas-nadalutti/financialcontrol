class AddColumnLoggedToClients < ActiveRecord::Migration
  def change
		add_column :clients, :logged, :boolean
  end
end
