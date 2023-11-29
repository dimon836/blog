# frozen_string_literal: true

module ApplicationHelper
  def model_action(model, action, language_case = 'accusative_case')
    i18n_action = "actions.#{action}.present"
    i18n_model = "#{model}.#{language_case}"

    "#{t(i18n_action)} #{t(i18n_model).downcase}"
  end
end
