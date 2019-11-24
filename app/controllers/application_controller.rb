class ApplicationController < ActionController::Base
    before_action :set_page

    def set_page
        @candidates_list = Candidate.all
    end
end
