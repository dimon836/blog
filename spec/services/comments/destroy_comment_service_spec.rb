# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Destroy do
  subject(:comment_destroy) { described_class.call(params[:article_id], params[:id]) }

  let(:article) { create(:article) }

  let(:params) { { id:, article_id: article.id } }

  let(:id) { comment.id }

  let!(:comment) { create(:comment, article:) }

  describe '#call' do
    context 'when success' do
      it 'has not any error' do
        expect(comment_destroy.errors).to be_empty
      end

      it_behaves_like 'destroys an object' do
        let(:model) { Comment }
        let(:service_method) { comment_destroy }
      end
    end

    context 'when errors' do
      let(:id) { 0 }

      let(:errors) { { not_found: I18n.t('controllers.comments.destroy.flash') } }

      it 'expects to have correct errors' do
        expect(comment_destroy.errors).to eq(errors)
      end

      it_behaves_like 'do not change model' do
        let(:model) { Comment }
        let(:service_method) { comment_destroy }
      end
    end
  end
end
