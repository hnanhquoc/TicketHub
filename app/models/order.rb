class Order < ApplicationRecord
	belongs_to :ticket_type

	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 11 }
end
