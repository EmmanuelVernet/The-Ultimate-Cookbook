class ApplicationController < ActionController::Base
  # Redirect after sign-in
  def after_sign_in_path_for(resource)
    root_path
  end

  # Set default URL options
  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def set_meta_defaults
    @meta_title = t('meta_title')
    @meta_description = t('meta_description')
    @meta_image = asset_path(t('meta_image'))
  end
end
