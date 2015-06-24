class SuspensionsController < ApplicationController

  before_action :logged_in_user

  def index
    @suspensions = Suspension.active
  end
end
