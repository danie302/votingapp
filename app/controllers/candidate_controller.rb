class CandidateController < ApplicationController
    def index 
        @state = session["candState"]
    end

    def register
        @politic_party = PoliticParty.find_by(name: candidate_params[:party])
        if @politic_party
            @candidate = Candidate.find_by(cc: candidate_params[:cc])
            if @candidate
                session["candState"] = "exist"
                redirect_to :action => "index"
            else
                session["candState"] = "Success"
                @politic_party.candidates.create(name: candidate_params[:name], last_name: candidate_params[:last_name], cc: candidate_params[:cc], cv: candidate_params[:cv], city: candidate_params[:city], department: candidate_params[:department], position: candidate_params[:position], picture: candidate_params[:picture], gov_plan: candidate_params[:gov_plan])
                redirect_to :controller => "home", :action => "index"
            end
        else
            session["candState"] = "PoliticPartyDontExist"
            redirect_to :action => "index"
        end
    end

    private def candidate_params
        params.require(:candidate).permit(:name, :last_name, :cc, :cv, :city, :department, :position, :party, :picture, :gov_plan)
    end
end
