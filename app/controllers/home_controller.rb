class HomeController < ApplicationController
  def index
    if user_signed_in?
      @forms = current_user.provider? ? Form.all : current_user.forms
    else
      @forms = []
    end
  end
end 