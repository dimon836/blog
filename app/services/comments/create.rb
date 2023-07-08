module Comments
  class Create

    def self.call(params)
      new(params).call
    end

    def call
      Comment.create(params)
    end

    attr_reader :params

    private

    def initialize(params)
      @params = params
    end

    def article
      @article ||= Article.find(params[:article_id])
    end
  end
end
