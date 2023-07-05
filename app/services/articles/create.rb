module Articles
  class Create

    def self.call(params)
      new(params).call
    end

    def call
      article.save
      article
    end

    attr_reader :params

    private

    def initialize(params)
      @params = params
    end

    def article
      @article ||= Article.new(params)
    end
  end

end