# frozen_string_literal: true

module Articles
  class Update
    def self.call(article, params)
      new(article, params).call
    end

    def call
      article.update(params)
      article
    end

    attr_reader :article, :params

    private

    def initialize(article, params)
      @article = article
      @params = params
    end
  end
end
