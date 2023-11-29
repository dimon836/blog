# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Create do
  subject(:comment_create) { described_class.call(comment_params) }

  let(:article) { create(:article) }

  let(:comment_params) { { commenter:, body:, status:, article_id: article.id } }

  let(:commenter) { 'Peter' }
  let(:body) { 'some comment body' }
  let(:status) { Comment.statuses.keys.first }

  describe '#call' do
    context 'when success' do
      let(:comment_attributes) do
        comment_create.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it { expect(comment_attributes).to eq(comment_params) }

      it_behaves_like 'creates a new object' do
        let(:model) { Comment }
        let(:service_method) { comment_create }
      end
    end

    context 'when errors' do
      context 'when validation errors' do
        it_behaves_like 'do not presence fields' do
          let(:model) { Comment }
          let(:service_method) { comment_create }

          let(:commenter) { '' }
          let(:body) { '' }
          let(:status) { nil }
          let(:errors) do
            {
              commenter: ["can't be blank"],
              body: ["can't be blank"],
              status: ["can't be blank", 'is not included in the list']
            }
          end
        end
      end

      context 'when raises errors' do
        let(:status) { -1 }

        it 'expects to raise an ArgumentError error' do
          expect { comment_create }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
