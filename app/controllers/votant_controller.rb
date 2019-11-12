class VotantController < ApplicationController
    def index
        @state = session["votantState"]
    end

    def register
        puts "--------------------------------"
        puts votant_params
        puts "--------------------------------"
        @voting_point = VotingPoint.find_by(name: votant_params[:voting_point])
        if @voting_point
            @voter = Voter.find_by(cc: votant_params[:cc])
            if @voter
                puts "Voter already register"
                session["votantState"] = "exist"
                redirect_to :action => "index"
            else
                @voting_point.voters.create(name: votant_params[:name], last_name: votant_params[:last_name], cc: votant_params[:cc], city: votant_params[:city], department: votant_params[:department])
                puts "Votant register"
                session["votantState"] = ""
                redirect_to :controller => "home" ,:action => "index"
            end
        else
            puts "That voting point is not register in our system"
            session["votantState"] = "notExist"
            redirect_to :action => "index"
        end
    end

    private def votant_params
        params.require(:votant).permit(:name, :last_name, :cc, :city, :department, :voting_point)
    end
end
