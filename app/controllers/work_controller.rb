class WorkController < ApplicationController
  def index
    @offers = Current.user.offers
  end
end
