class Event < ActiveRecord::Base
	belongs_to :venue
	belongs_to :category
	has_many :ticket_types

	validates_presence_of :extended_html_description, :venue, :category, :starts_at
	validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

	def self.current
		where("starts_at <= ? and ends_at >= ?", Time.now, Time.now).published
	end

	def self.upcoming
		where("starts_at > ?", Time.now).published
	end

	def publish!
		published_at = Time.now
		save!
	end

	def self.published
		where.not(published_at: nil)
	end

	def self.search(search)
		where("name ILIKE ?", "%#{search}%") 
	end

end
