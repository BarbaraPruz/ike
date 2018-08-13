require 'pry'
class TopicsController < ApplicationController

    def index
        redirect_to welcome_path if !logged_in?
        @topics = Topic.all
    end

end
