class AdminsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user?, only: [:index]

  def index
  end
end
