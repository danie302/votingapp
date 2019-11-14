class ApplicationController < ActionController::Base
    before_action :set_page

    def set_page
        @candidates = Candidate.all
        if @candidates
            puts ""
        else 
            @candidate = [{cc: ""}]
        end
    end
end
