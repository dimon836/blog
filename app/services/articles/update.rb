module Articles
  class Update

    def self.call(id, params)
      new(id, params).call
    end

    def call
      article.update(params)
      article
    end

    attr_reader :id, :params

    private

    def initialize(id, params)
      @id = id
      @params = params
    end

    def article
      @article ||= Article.find(id)
    end

  end
end