# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Articles::Update do
  subject(:article_update) { described_class.call(article, article_params) }

  let(:article_params) { { title:, body:, status: Article.statuses.keys.second } }

  let(:title) { 'title' }
  let(:body) { 'some article body' }

  let!(:article) { create(:article) }

  describe '#call' do
    context 'when success' do
      let(:article_attributes) do
        article_update.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it 'has valid data' do
        expect(article_attributes).to eq(article_params)
      end

      it { is_expected.to eq(article.reload) }

      it_behaves_like 'do not change model' do
        let(:model) { Article }
        let(:service_method) { article_update }
      end
    end

    context 'when validation errors' do
      it_behaves_like 'do not presence fields' do
        let(:model) { Article }
        let(:service_method) { article_update }

        let(:title) { '' }
        let(:body) { '' }
        let(:errors) do
          {
            title: ["can't be blank"],
            body: ["can't be blank", 'is too short, minimum 10']
          }
        end
      end
    end
  end
end
