class TopPagesController < ApplicationController
  def home
    @work = current_user.works.build if logged_in?
  end
end
