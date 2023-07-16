require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do
  let(:valid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }
  let(:invalid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials("user", "pass") }

  describe "GET #index" do
    subject { get :index }

    it { is_expected.to be_ok }
  end

  describe "GET #show" do
    let(:article) { create(:article) }
    subject { get :show, params: {
      id: article.id
    } }

    it { is_expected.to be_ok }
  end

  describe "POST #create" do
    subject {
      post :create, params: {
        article: {
          title: "article title",
          body: "some example body",
          status: "public"
        }
      }
    }

    context "with valid credentials" do
      before do
        request.headers['Authorization'] = valid_credentials
      end
      it { is_expected.to have_http_status(302) }
    end

    context "with invalid credentials" do
      before do
        request.headers['Authorization'] = invalid_credentials
      end
      it { is_expected.to have_http_status(401) }
    end
  end

  describe "PUT #update" do
    let(:article) { create(:article) }
    subject {
      put :update,
          params: {
            id: article.id,
            article: {
              title: "article title",
              body: "some example body",
              status: "public"
            }
          }
    }

    context "with valid credentials" do
      before do
        request.headers['Authorization'] = valid_credentials
      end
      it { is_expected.to have_http_status(302) }
    end

    context "with invalid credentials" do
      before do
        request.headers['Authorization'] = invalid_credentials
      end
      it { is_expected.to have_http_status(401) }
    end
  end

  describe "DELETE #destroy" do
    let(:article) { create(:article) }
    subject {
      put :destroy, params: {
        id: article.id
      }
    }

    context "with valid credentials" do
      before do
        request.headers['Authorization'] = valid_credentials
      end
      it { is_expected.to have_http_status(303) }
    end

    context "with invalid credentials" do
      before do
        request.headers['Authorization'] = invalid_credentials
      end
      it { is_expected.to have_http_status(401) }
    end
  end

end
