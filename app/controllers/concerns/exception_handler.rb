# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_exception
  end

  private

  def handle_not_found_exception
    I18n.locale = params[:locale]
    redirect_to articles_path, alert: I18n.t('controllers.articles.destroy.flash'), status: :see_other
  end
end
