class VoteController < ApplicationController
    def index
        puts @render = flash["voteRender"]
        votingPoint = VotingPoint.all
        @votingPoint = []
        votingPoint.each { |p|
            @votingPoint.push(p[:name])
        }
    end

    def init_vote
        flash["voteRender"] = "vote1"
        puts @render
        redirect_to :action => "index"
    end
end 
