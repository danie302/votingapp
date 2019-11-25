class VotantController < ApplicationController
    def index
        @state = flash["votantState"]
        @voting_points = VotingPoint.all
        @voting_points_names = ["Escoge tu punto de votación"]
        @voting_points.each { |v|
            @voting_points_names.push(v[:name])
        }
    end

    def register
        @voting_point = VotingPoint.find_by(name: votant_params[:voting_point])
        if @voting_point
            @voter = Voter.find_by(cc: votant_params[:cc])
            if @voter
                flash["votantState"] = "exist"
                redirect_to :action => "index"
            else
                @voting_point.voters.create(name: votant_params[:name], last_name: votant_params[:last_name], cc: votant_params[:cc], city: votant_params[:city], department: votant_params[:department])
                flash["votantState"] = ""
                redirect_to :controller => "home" ,:action => "index"
            end
        else
            flash["votantState"] = "notExist"
            redirect_to :action => "index"
        end
    end

    private def votant_params
        params.require(:votant).permit(:name, :last_name, :cc, :city, :department, :voting_point)
    end
end
