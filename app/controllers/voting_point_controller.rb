class VotingPointController < ApplicationController
    def index
        @state = flash["votingState"]
    end

    def register
        @point = VotingPoint.find_by(name: voting_point_params[:name])
        if @point
            flash["votingState"] = "exist"
            redirect_to :action => "index"
        else
            @point = VotingPoint.new(voting_point_params)
            if @point.save
                flash["votingState"] = "save"
                redirect_to :controller => "home" ,:action => "index"
            else
                puts "Save error"
                puts @point.errors
            end
        end

    end

    private def voting_point_params
        params.require(:voting_point).permit(:name, :address, :city, :department)
    end

end
