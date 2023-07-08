module Comments
  class Create

    def self.call(article_id, params)
      new(article_id, params).call
    end

    def call
      article.comments.build(params)
    end

    attr_reader :article_id, :params

    private

    def initialize(article_id, params)
      @article_id = article_id
      @params = params
    end

    def article
      @article ||= Article.find(article_id)
    end
  end
end
