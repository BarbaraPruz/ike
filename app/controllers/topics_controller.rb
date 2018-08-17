require 'pry'
class TopicsController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:admin_index, :edit, :update, :destroy]

    def index
        @topics = Topic.all
    end

    def edit
        @topic = Topic.find_by(:id => params[:id])
    end

    def update
        @topic = Topic.find_by(:id => params[:id])
        if !@topic
            flash[:alert] ="Error. Topic not found."
        else
            @topic.update(topic_params)
        end
        redirect_to topics_path
    end

    def destroy
        topic = Topic.find_by(:id => params[:id])
        article = Article.find_by(:topic_id => params[:id]) if topic
        if topic && !article
            topic.destroy
        else
            flash[:alert] ="Error. Verify Topic does not have any Articles."
        end
        redirect_to topics_path
    end

    private

    def topic_params
        params.require(:topic).permit(:name)
    end
end
