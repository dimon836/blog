module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_exception
  end

  private

  def handle_not_found_exception(error)
    redirect_to root_path, alert: error.message, status: :see_other
  end
end
