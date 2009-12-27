class Computer < ActiveRecord::Base
 belongs_to :owner
 has_many :packages
end
