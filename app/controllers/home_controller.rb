class HomeController < ApplicationController
  before_action :forbid_login_user
  skip_before_action :login_required

  def top
  end
end
