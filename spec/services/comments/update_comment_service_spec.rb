# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Update do
  subject(:comment_update) { described_class.call(comment, comment_params) }

  let(:article) { create(:article) }

  let(:comment_params) { { commenter:, body:, status: Comment.statuses.keys.second, article_id: article.id } }

  let(:commenter) { 'Peter' }
  let(:body) { 'some comment body' }

  let!(:comment) { create(:comment, article:) }

  describe '#call' do
    context 'when success' do
      let(:comment_attributes) do
        comment_update.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it 'has valid data' do
        expect(comment_attributes).to eq(comment_params)
      end

      it { is_expected.to eq(comment.reload) }

      it_behaves_like 'do not change model' do
        let(:model) { Comment }
        let(:service_method) { comment_update }
      end
    end

    context 'when validation errors' do
      it_behaves_like 'do not presence fields' do
        let(:model) { Comment }
        let(:service_method) { comment_update }

        let(:commenter) { '' }
        let(:body) { '' }
        let(:errors) do
          {
            commenter: ["can't be blank"],
            body: ["can't be blank"]
          }
        end
      end
    end
  end
end
