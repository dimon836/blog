# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::Create do
  subject(:article_create) { described_class.call(article_params) }

  let(:article_params) { { title:, body:, status: } }

  let(:title) { 'title' }
  let(:body) { 'some article body' }
  let(:status) { Article.statuses.keys.first }

  describe '#call' do
    context 'when success' do
      let(:article_attributes) do
        article_create.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it { expect(article_attributes).to eq(article_params) }

      it_behaves_like 'creates a new object' do
        let(:model) { Article }
        let(:service_method) { article_create }
      end
    end

    context 'when errors' do
      context 'when validation errors' do
        context 'when body is too short' do
          let(:body) { 'some body' }
          let(:errors) { { body: ['is too short, minimum 10'] } }

          it 'expects error when body short' do
            expect(article_create.errors.any?).to be true
          end

          it 'expects to have correct errors' do
            expect(article_create.errors.messages).to eq(errors)
          end

          it_behaves_like 'do not change model' do
            let(:model) { Article }
            let(:service_method) { article_create }
          end
        end

        it_behaves_like 'do not presence fields' do
          let(:model) { Article }
          let(:service_method) { article_create }

          let(:title) { '' }
          let(:body) { '' }
          let(:status) { nil }
          let(:errors) do
            {
              title: ["can't be blank"],
              body: ["can't be blank", 'is too short, minimum 10'],
              status: ["can't be blank", 'is not included in the list']
            }
          end
        end
      end

      context 'when raises errors' do
        let(:status) { -1 }

        it 'expects to raise an ArgumentError error' do
          expect { article_create }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
