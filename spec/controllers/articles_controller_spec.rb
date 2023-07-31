require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do
  let(:valid_credentials) do
    ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret")
  end

  shared_examples 'credentials checker' do
    let(:invalid_credentials) do
      ActionController::HttpAuthentication::Basic.encode_credentials("user", "pass")
    end

    before { request.headers['Authorization'] = invalid_credentials }

    it 'returns 401 Unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end

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

  describe "GET #show" do
    let(:article) { create(:article) }

    before { get :show, params: { id: article.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:params) do
      {
        article: {
          title: title,
          body: "some example body",
          status: "public"
        }
      }
    end

    let(:title) { "article title" }

    context 'when valid credentials' do
      let(:article_attributes) do
        assigns(:article).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      before do
        request.headers['Authorization'] = valid_credentials
        post :create, params: params
      end

      shared_examples 'article assigner' do
        it 'assigns article' do
          expect(article_attributes).to eq(params[:article])
        end
      end

      context 'when success' do
        it 'returns http success' do
          expect(response).to have_http_status(:found)
        end

        it 'redirects to booking requests' do
          expect(response).to redirect_to(article_path(id: assigns(:article).id))
        end

        it_behaves_like 'article assigner'
      end

      context 'when errors' do
        let(:title) { '' }

        it 'returns http success' do
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
        before { post :create, params: params }
      end
    end
  end

  describe "PUT #update" do
    let(:params) do
      {
        id: article.id,
        article: {
          title: "article title",
          body: "some example body",
          status: "public"
        }
      }
    end

    let(:article) { create(:article) }

    before { put :update, params: params }

    context 'when valid credentials' do

    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { put :update, params: params }
      end
    end
  end

  describe "DELETE #destroy" do
    let(:params) { { id: article.id } }
    let(:article) { create(:article) }

    before { delete :destroy, params: params }

    context 'when valid credentials' do

    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete :destroy, params: params }
      end
    end
  end
end
