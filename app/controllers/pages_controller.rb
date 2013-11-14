class PagesController < ApplicationController
  def home
  	@title = "Fb Score"
  	@businesses = Business.order('fb_likes DESC').limit(30)
  end
end
