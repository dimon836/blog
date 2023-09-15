# frozen_string_literal: true

module Comments
  class Destroy
    def self.call(article_id, comment_id)
      new(article_id, comment_id).call
    end

    def call
      remove
      self
    end

    attr_reader :article_id, :comment_id
    attr_accessor :errors

    private

    def initialize(article_id, comment_id)
      @article_id = article_id
      @comment_id = comment_id
      @errors = {}
    end

    def comment
      @comment ||= Comment.find_by(article_id:, id: comment_id)
    end

    def remove
      return comment.destroy if comment.present?

      errors[:not_found] = I18n.t('controllers.comments.destroy.flash')
    end
  end
end
