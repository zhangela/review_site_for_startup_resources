class ApplicationController < ActionController::Base
  protect_from_forgery

  include PublicActivity::StoreController
  before_filter :notifications

  private
	def notifications
	  @activities = PublicActivity::Activity.order("created_at desc")
	end
end
