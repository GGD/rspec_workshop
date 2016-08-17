module API
  module V1
    class PostsController < ApplicationController
      def index
        posts = Post.all
        render status: 200, json: posts
      end

      def show
        post = Post.find(params[:id])
        render status: 200, json: post
      end

      def create
        post = Post.new(post_params)

        if post.save
          render status: 201, json: post
        else
          render status: 422, json: post.errors
        end
      end

      def update
        post = Post.find(params[:id])

        if post.update(post_params)
          render status: 200, json: post
        else
          render status: 422, json: post.errors
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy

        head :no_content
      end

      private

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
