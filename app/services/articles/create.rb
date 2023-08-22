module Articles
  class Create
    def self.call(params)
      new(params).call
    end

    def call
      Article.create(params)
    end

    attr_reader :params

    private

    def initialize(params)
      @params = params
    end
  end
end
