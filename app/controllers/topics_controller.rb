# frozen_string_literal: true

# TopicsController - controller for Topics model
class TopicsController < ApplicationController
  before_action :require_logged_in
  before_action :require_admin, only: [:admin_index, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def admin
    @topics = Topic.all
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    if !@topic
      flash[:alert] = 'Error. Topic not found.'
    else
      @topic.update(topic_params)
      if @topic.valid?
        redirect_to topics_path
      else
        render :edit
      end
    end
  end

  def destroy
    topic = Topic.find_by(id: params[:id])
    article = Article.find_by(topic_id: params[:id]) if topic
    if topic && !article
      topic.destroy
    else
      flash[:alert] = 'Error. Verify Topic does not have any Articles.'
    end
    redirect_to topics_path
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    article_ids = @topic.article_ids
    @article = Article.find(article_ids[0])
    render :topic_articles
  end

  def topic_articles
    # to do: not efficient but will fix this with jquery later!
    # to do: move any real logic to model
    @topic = Topic.find_by(id: params[:id])
    article_ids = @topic.article_ids
    last_index = params[:article_id].to_i
    new_index = article_ids.find_index do |id|
      id == last_index
    end
    new_index += 1
    if (new_index.negative?) || (new_index == article_ids.length)
      new_index = 0
    end
    @article = Article.find_by(id: article_ids[new_index])
    # to do: fix url, currently showing last article id
    # to do: share common template with articles show but with other buttons
    #   and note that any links (like add bookmark) should come back to here!
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end
end
