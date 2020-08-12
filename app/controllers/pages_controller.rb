class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @profile = Profile.new
    @diseases = Disease.all
    @disease_select = @diseases.map { |disease| [disease.name, disease.id] }
  end
end
