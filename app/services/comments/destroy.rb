module Comments
  class Destroy
    def self.call(article_id, comment_id)
      new(article_id, comment_id).call
    end

    def call
      @comment = article.comments.find(comment_id)
      @comment.destroy
      @article
    end

    attr_reader :article_id, :comment_id

    private

    def initialize(article_id, comment_id)
      @article_id = article_id
      @comment_id = comment_id
    end

    def article
      @article ||= Article.find(article_id)
    end

  end
end
