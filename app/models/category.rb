class Category < ActiveRecord::Base
  attr_accessible :name, :description

	validates_presence_of :name, :message => "must be given!"
end
