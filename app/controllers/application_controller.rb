class ApplicationController < ActionController::Base
    before_action :set_page

    def set_page
        @candidates = Candidate.all
    end
end
