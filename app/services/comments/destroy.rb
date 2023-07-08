module Comments
  class Destroy

    def self.call(article_id, comment_id)
      new(article_id, comment_id).call
    end

    def call
      Comment.find_by(article_id: article_id, id: comment_id).destroy
    end

    attr_reader :article_id, :comment_id

    private

    def initialize(article_id, comment_id)
      @article_id = article_id
      @comment_id = comment_id
    end

  end
end
