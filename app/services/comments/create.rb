# frozen_string_literal: true

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
  end
end
