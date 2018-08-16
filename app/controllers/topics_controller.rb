require 'pry'
class TopicsController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:admin_index, :destroy]

    def index
        @topics = Topic.all
    end

    def admin_index
        @topics = Topic.all
    end

    def destroy
        topic = Topic.find_by(:id => params[:id])
        article = Article.find_by(:topic_id => params[:id]) if topic
        if topic && !article
            topic.destroy
        else
            flash[:alert] ="Error. Verify Topic does not have any Articles."
        end
        redirect_to :admin_topics_index
    end
end
