class PaymentMethod < ActiveRecord::Base
  attr_accessible :method, :bank, :addit_info

	validate_presence_of :method, :message => "must be informed!"
	validate :inform_bank
	validate :inform_addit_info

	private
	def inform_bank
		if @payment_method.method != "money"
			validate_presence_of :bank, :message => "must be informed!"
		end
	end

end
