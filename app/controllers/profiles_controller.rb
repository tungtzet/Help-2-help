class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @profiles = policy_scope(Profile)
  end
end
