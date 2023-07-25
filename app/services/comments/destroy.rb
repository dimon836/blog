module Comments
  class Destroy

    def self.call(article_id, comment_id)
      new(article_id, comment_id).call
    end

    def call
      destroy
      errors
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
      @comment ||= Comment.find_by(article_id: article_id, id: comment_id)
    end

    def destroy
      if comment.present?
        comment.destroy
      else
        errors["not_found"] = "Comment not found for DESTROY."
      end
    end

  end
end
