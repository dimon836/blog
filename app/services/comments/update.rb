# frozen_string_literal: true

module Comments
  class Update
    def self.call(comment, params)
      new(comment, params).call
    end

    def call
      comment.update(params)
      comment
    end

    attr_reader :comment, :params

    private

    def initialize(comment, params)
      @comment = comment
      @params = params
    end
  end
end
