# frozen_string_literal: true

class ApplicationController < ActionController::Base
  I18n::Backend::Simple.include(I18n::Backend::Pluralization)

  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&)
    I18n.with_locale(locale, &)
  end

  def locale
    @locale = params[:locale] || I18n.default_locale
  end
end
