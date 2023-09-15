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

      before { post :create, params: }

      shared_examples 'article assigner' do
        it 'assigns article' do
          expect(article_attributes).to eq(params[:article])
        end
      end

      context 'when success' do
        it 'returns http found' do
          expect(response).to have_http_status(:found)
        end

        it 'redirects to booking requests' do
          expect(response).to redirect_to(article_path(id: assigns(:article).id))
        end

        it_behaves_like 'article assigner'
      end

      context 'when errors' do
        let(:title) { '' }

        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders new template' do
          expect(response).to render_template(:new)
        end

        it_behaves_like 'article assigner'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { post :create, params: }
      end
    end
  end

  describe 'PUT #update' do
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

      before { put :update, params: }

      shared_examples 'article updater' do
        it 'assigns article' do
          expect(assigns(:article)).to eq(article.reload)
        end

        it 'has valid data' do
          expect(assigns(:article).attributes.deep_symbolize_keys.except(:id, :created_at,
                                                                         :updated_at)).to eq(params[:article])
        end
      end

      context 'when success' do
        it 'returns http success' do
          expect(response).to have_http_status(:found)
        end

        it 'redirects to booking requests' do
          expect(response).to redirect_to(article_path(id: article.id))
        end

        it_behaves_like 'article updater'
      end

      context 'when errors' do
        let(:title) { '' }

        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders update template' do
          expect(response).to render_template(:edit)
        end

        it_behaves_like 'article updater'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { put :update, params: }
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) { { id: article.id } }
    let!(:article) { create(:article) }

    context 'with valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'redirects articles' do
        it 'redirects to the articles' do
          expect(response).to redirect_to(articles_path)
        end
      end

      context 'when success' do
        context 'when deletes in test' do
          it 'deletes an article' do
            expect { delete :destroy, params: }.to change(Article, :count).by(-1)
          end
        end

        context 'when deletes in before' do
          before { delete :destroy, params: }

          it 'returns http found' do
            expect(response).to have_http_status(:found)
          end

          it_behaves_like 'redirects articles'
        end
      end

      context 'when errors' do
        let(:params) { { id: 0 } }

        context 'when deletes in test' do
          it 'not deletes an article' do
            expect { delete :destroy, params: }.not_to change(Article, :count)
          end
        end

        context 'when deletes in before' do
          before { delete :destroy, params: }

          it 'returns http see_other' do
            expect(response).to have_http_status(:see_other)
          end

          it_behaves_like 'redirects articles'
        end
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete :destroy, params: }
      end
    end
  end
end
