# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController do
  let(:article) { create(:article) }

  describe 'POST #create' do
    subject(:create_comment_request) { post :create, params: }

    let(:params) do
      {
        comment: {
          commenter: 'Dima',
          body:,
          status: Comment.statuses.keys.first
        },
        article_id: article.id
      }
    end

    let(:body) { 'some comment body' }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let(:comment_attributes) do
        assigns(:comment).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      shared_examples 'comment assigner' do
        before { create_comment_request }

        it 'assigns comment' do
          expect(comment_attributes).to eq(params[:comment].merge(article_id: params[:article_id]))
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:see_other) }

        it { is_expected.to redirect_to(article) }

        it_behaves_like 'comment assigner'
      end

      context 'when errors' do
        let(:body) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }

        it { is_expected.to render_template(:show) }

        it_behaves_like 'comment assigner'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { create_comment_request }
      end
    end
  end

  describe 'PUT #update' do
    subject(:update_comment_request) { put :update, params: }

    let(:params) do
      {
        id: comment.id,
        comment: {
          commenter: 'Dima',
          body:,
          status: Comment.statuses.keys.first
        },
        article_id: article.id
      }
    end

    let(:body) { 'some comment body' }

    let!(:comment) { create(:comment, article:) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'comment updater' do
        before { update_comment_request }

        it 'assigns comment' do
          expect(assigns(:comment)).to eq(comment.reload)
        end

        it 'has valid data' do
          expect(assigns(:comment).attributes.deep_symbolize_keys
                                  .except(:id, :created_at, :updated_at, :article_id)).to eq(params[:comment])
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:found) }

        it { is_expected.to redirect_to(article_path(id: article.id)) }

        it_behaves_like 'comment updater'
      end

      context 'when errors' do
        let(:body) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }

        it { is_expected.to render_template(:edit) }

        it_behaves_like 'comment updater'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { update_comment_request }
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_comment_request) { delete :destroy, params: }

    let(:params) do
      {
        id:,
        article_id: article.id
      }
    end

    let(:id) { comment.id }

    let!(:comment) { create(:comment, article:) }

    context 'with valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'redirects article' do
        it { is_expected.to redirect_to(article_path(id: params[:article_id])) }
      end

      context 'when success' do
        it { is_expected.to have_http_status(:see_other) }

        it_behaves_like 'redirects article'
      end

      context 'when errors' do
        let(:id) { 0 }

        context 'when deletes in before' do
          it { is_expected.to have_http_status(:see_other) }

          it_behaves_like 'redirects article'
        end
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete_comment_request }
      end
    end
  end
end
