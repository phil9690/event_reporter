class SuspensionsController < ApplicationController
  def index
    @suspensions = Suspension.all
  end
end
