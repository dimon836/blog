# frozen_string_literal: true

module CommentsHelper
  def comment_date(comment)
    action = comment.created_at == comment.updated_at ? t('actions.create.past') : t('actions.edit.past')
    "- #{action} #{time_ago_in_words(comment.updated_at, include_seconds: true)} #{t('ago')}"
  end
end
