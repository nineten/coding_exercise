require 'test_helper'

class BusinessTest < ActiveSupport::TestCase
	fixtures :businesses

  test "should be valid if all fields are correct" do
  	business = new_business(businesses(:success))
  	assert business.valid?
  end

  test "should be invalid if there are empty fields" do
  	business = new_business(businesses(:failure_empty))
  	assert business.invalid?
  end

  test "should be invalid if email is bad" do
  	business = new_business(businesses(:failure_invalid_email))
  	assert business.invalid?
  end

  test "should not save if fb address have no likes" do
  	business = new_business(businesses(:failure_invalid_facebook))
  	assert !business.save
  end

  private
  	def new_business(sample_business)
  		Business.new :name => sample_business.name,
	 			:fb_url => sample_business.fb_url,
	 			:description => sample_business.description,
	 			:submitter_name => sample_business.submitter_name,
	 			:submitter_email => sample_business.submitter_email
  	end
end
