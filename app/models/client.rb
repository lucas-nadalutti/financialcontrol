class Client < ActiveRecord::Base
  attr_accessible :email, :name, :password

	validates_presence_of :name, :message => "must be given!"
	validate :email_must_be_valid
	validates_uniqueness_of :email, :message => "already registered!"
	validates_length_of :password, :minimum => 4, :message => "must have at least 4 characters!"

	private
	def email_must_be_valid
		errors.add("email", "e-mail must be in a valid format!") unless email =~ /\w+@(((gmail|hotmail|quantumtecnologia)\.com)|yahoo.com.br)\z/
	end

	has_many :transactions

end
