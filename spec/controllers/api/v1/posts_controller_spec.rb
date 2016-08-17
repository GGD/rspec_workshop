require 'rails_helper'

module API
  module V1
    describe PostsController do
      describe 'GET #show' do
        it 'returns the post' do
          post = Post.create(title: 'title', content: 'content')

          get :show, params: { id: post.id }

          expect(response).to have_http_status 200
          expect(json_response[:id]).to eq post.id
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'returns the created post' do
            post_params = { title: 'my title', content: 'content' }

            post :create, params: { post: post_params }

            expect(response).to have_http_status 201
            expect(json_response[:title]).to eq 'my title'
          end
        end

        context 'with invalid params' do
          it 'returns errors' do
            post_params = { title: 'my title', content: '' }

            post :create, params: { post: post_params }

            expect(response).to have_http_status 422
            expect(json_response[:content]).to include "can't be blank"
          end
        end
      end
    end
  end
end
