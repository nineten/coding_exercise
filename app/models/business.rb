# == Schema Information
#
# Table name: businesses
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  fb_url          :string(255)
#  description     :string(255)
#  submitter_name  :string(255)
#  submitter_email :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  fb_likes        :integer
#
require 'open-uri'
require 'json'

class BusinessValidator < ActiveModel::Validator
	def validate(record)
		unless Business.find_by_fb_url(record.fb_url).nil?
			record.errors[:fb_url] << "already exists."
		end
	end
end

class Business < ActiveRecord::Base
	email_regex = /\A([0-9a-zA-Z]([-+\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-+\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$\z/i
	facebook_regex = /(http[s]?:\/\/)?(www.)?facebook.com/i

	validates_with BusinessValidator
  validates :name,						:presence => true
  validates :fb_url,					:presence => true,
  														:format => { :with => facebook_regex }
  validates :description,			:presence => true
  validates :submitter_name,	:presence => true
	validates :submitter_email, :presence => true,
															:format	=> { :with => email_regex }
	validates :fb_likes,				:numericality => { :greater_than => 0 }

  def fb_url
    self[:fb_url]
  end

  def fb_url=(url)
    self[:fb_url] = url.gsub(/(http[s]?:\/\/)?(www.)?facebook.com/,'https://www.facebook.com')
    self[:fb_likes] = get_likes
  end

	def update_likes
  	self.update_attribute(:fb_likes,get_likes)
  end

  private
	  def get_likes
	  	begin
				JSON.parse(open("https://graph.facebook.com/#{self[:fb_url].gsub(/(http[s]?:\/\/)?(www.)?facebook.com\/(pages\/[\w|\-|\.]+\/)?/,'')}").read)["likes"].to_i
			rescue Exception
				logger.error("#{Time.now} - HttpError")
			end	
	  end
end
