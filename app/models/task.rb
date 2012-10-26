class Task < ActiveRecord::Base
  attr_accessible :name, :notes, :status, :order
end
