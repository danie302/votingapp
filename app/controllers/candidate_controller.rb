class CandidateController < ApplicationController
    def index 
        @state = session["candState"]
        @parties = PoliticParty.all
        @parties_names = ["Choose a party"]
        @parties.each { |p|
            @parties_names.push(p[:name])
        }
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

    def edit
        @candidate = Candidate.find_by_cc(params[:cc])
        @parties = PoliticParty.all
        @parties_names = []
        @parties.each { |p|
            if PoliticParty.find_by_name(p[:name])[:id] == @candidate[:politic_party_id]
                @parties_names.unshift(p[:name])
            else
                @parties_names.push(p[:name])
            end
        }
        @opts = []
        if @candidate[:position] == "Alcaldia"
            @opts = ["Alcaldia", "Gobernación"]
        else
            @opts = ["Gobernación", "Alcaldia"]
        end
    end

    def edit_candidate
        @new_candidate = Candidate.find_by_cc(edit_candidate_params[:cc])
        puts "-------------------------------------------"
        puts edit_candidate_params
        puts "-------------------------------------------"
        if @new_candidate.update(name: edit_candidate_params[:name], last_name: edit_candidate_params[:last_name], cc: edit_candidate_params[:cc], cv: edit_candidate_params[:cv], city: edit_candidate_params[:city], department: edit_candidate_params[:department], position: edit_candidate_params[:position], politic_party_id: PoliticParty.find_by_name(edit_candidate_params[:politic_party_id])[:id])
            puts "update"
            redirect_to :action => "index"
        else
            puts @new_candidate.errors.full_messages
            redirect_to :action => "index"
        end
    end

    private def candidate_params
        params.require(:candidate).permit(:name, :last_name, :cc, :cv, :city, :department, :position, :party, :picture, :gov_plan)
    end
    private def edit_candidate_params
        params.require(:candidate).permit(:name, :last_name, :cc, :cv, :city, :department, :position, :politic_party_id)
    end
end
