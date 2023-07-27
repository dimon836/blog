require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:article) { create(:article) }

  describe 'POST #create' do
    let(:params) do
      {
        comment: {
          commenter: "Dima",
          body: body,
          status: "public"
        },
        article_id: article.id
      }
    end

    let(:body) { "some comment body" }

    context 'when valid credentials' do
      include_context 'valid credentials'

      let(:comment_attributes) do
        assigns(:comment).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      before { post :create, params: params }

      shared_examples 'comment assigner' do
        it 'assigns comment' do
          expect(comment_attributes).to eq(params[:comment].merge(article_id: params[:article_id]))
        end
      end

      context 'when success' do
        it 'returns http see_other' do
          expect(response).to have_http_status(:see_other)
        end

        it 'redirects to article' do
          expect(response).to redirect_to(article_path(id: assigns(:article)))
        end

        it_behaves_like 'comment assigner'
      end

      context 'when errors' do
        let(:body) { "" }

        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'renders show template' do
          expect(response).to render_template(:show)
        end

        it_behaves_like 'comment assigner'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { post :create, params: params }
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:params) do
      {
        id: comment.id,
        article_id: article.id
      }
    end

    let!(:comment) { create(:comment, article: article) }

    context 'with valid credentials' do
      include_context 'valid credentials'

      shared_examples 'redirects article' do
        it 'redirects to the article' do
          expect(response).to redirect_to(article_path(id: params[:article_id]))
        end
      end

      context 'when success' do
        context 'when deletes in test' do
          it 'deletes a comment' do
            expect { delete :destroy, params: params }.to change(Comment, :count).by(-1)
          end
        end

        context 'when deletes in before' do
          before { delete :destroy, params: params }

          it 'returns http see_other' do
            expect(response).to have_http_status(:see_other)
          end

          it_behaves_like 'redirects article'
        end
      end

      context 'when errors' do
        let(:params) do
          {
            id: 0,
            article_id: article.id
          }
        end

        context 'when deletes in test' do
          it 'not deletes a comment' do
            expect { delete :destroy, params: params }.not_to change(Comment, :count)
          end
        end

        context 'when deletes in before' do
          before { delete :destroy, params: params }

          it 'returns http see_other' do
            expect(response).to have_http_status(:see_other)
          end

          it_behaves_like 'redirects article'
        end
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete :destroy, params: params }
      end
    end
  end
end
