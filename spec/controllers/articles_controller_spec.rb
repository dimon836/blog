# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController do
  describe 'GET #index' do
    let!(:articles) { create_list(:article, 3) }

    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns articles' do
      expect(assigns(:articles)).to eq(articles)
    end

    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:article) { create(:article) }

    before { get :show, params: { id: article.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns article' do
      expect(assigns(:article)).to eq(article)
    end

    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    subject(:create_article_request) { post :create, params: }

    let(:params) do
      {
        article: {
          title:,
          body: 'some example body',
          status: Article.statuses.keys.first
        }
      }
    end

    let(:title) { 'article title' }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let(:article_attributes) do
        assigns(:article).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      shared_examples 'article assigner' do
        before { create_article_request }

        it 'assigns article' do
          expect(article_attributes).to eq(params[:article])
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:found) }

        it { is_expected.to redirect_to(article_path(id: assigns(:article).id)) }

        it_behaves_like 'article assigner'
      end

      context 'when errors' do
        let(:title) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }

        it { is_expected.to render_template(:new) }

        it_behaves_like 'article assigner'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { create_article_request }
      end
    end
  end

  describe 'PUT #update' do
    subject(:update_article_request) { put :update, params: }

    let(:params) do
      {
        id: article.id,
        article: {
          title:,
          body: 'some example body',
          status: Article.statuses.keys.first
        }
      }
    end

    let(:title) { 'article title' }
    let(:article) { create(:article) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'article updater' do
        before { update_article_request }

        it 'assigns article' do
          expect(assigns(:article)).to eq(article.reload)
        end

        it 'has valid data' do
          expect(assigns(:article).attributes.deep_symbolize_keys.except(:id, :created_at,
                                                                         :updated_at)).to eq(params[:article])
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:found) }

        it { is_expected.to redirect_to(article_path(id: article.id)) }

        it_behaves_like 'article updater'
      end

      context 'when errors' do
        let(:title) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }

        it { is_expected.to render_template(:show, layout: 'layouts/application') }

        it_behaves_like 'article updater'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { update_article_request }
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_article_request) { delete :destroy, params: }

    let(:params) { { id: article.id } }
    let!(:article) { create(:article) }

    context 'with valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'redirects articles' do
        it { is_expected.to redirect_to(articles_path) }
      end

      context 'when success' do
        it { is_expected.to have_http_status(:found) }

        it_behaves_like 'redirects articles'
      end

      context 'when errors' do
        let(:params) { { id: 0 } }

        it { is_expected.to have_http_status(:see_other) }

        it_behaves_like 'redirects articles'
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete_article_request }
      end
    end
  end
end
