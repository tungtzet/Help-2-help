class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  # rescue_from ActionController::RoutingError, :with => :render_404
  # def render_404
  #   render :file => "#{Rails.root}/public/404.html",  :status => 404
  # end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  rescue
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  # def after_sign_up_path_for(resource)
  #   new_profile_path
  # end

  # def after_sign_in_path_for(resource)
  #   posts_path
  # end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  # def content_not_found
  #   render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
