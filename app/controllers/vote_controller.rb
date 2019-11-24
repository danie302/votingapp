class VoteController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @render = flash["voteRender"]
        votingPoint = VotingPoint.all
        @votingPoint = []
        votingPoint.each { |p|
            @votingPoint.push(p[:name])
        }
        if @render == "vote1"
            @candidates = Candidate.where(position: "Alcaldia")   
        elsif @render == "vote2"
            @candidates = Candidate.where(position: "Gobernación")
        elsif @render == "confirm"
            @candidate1 = Candidate.find_by(name: session["vote1"])
            @candidate2 = Candidate.find_by(name: session["vote2"])
            @pic1 = @candidate1.picture
            @pic2 = @candidate2.picture
            @votantCC = session["votantCC"]
            @vote1 = session["vote1"]
            @vote2 = session["vote2"]
        end
    end

    def init_vote
        flash["voteRender"] = "check_cc"
        redirect_to :action => "index"
        session["votantLocation"] = init_vote_params[:voting_point]
    end

    def check_cc
        @votingPoint = VotingPoint.find_by(name: session["votantLocation"])
        @votant = Voter.find_by(cc: params[:vote][:cc])
        if @votant
            if @votant[:voting_point_id] === @votingPoint[:id]
                flash["voteRender"] = "vote1"
                session["votantCC"] = params[:vote][:cc]
                session["votantID"] = @votant[:id]
                session["votingPointID"] = @votingPoint[:id]
                @candidates = Candidate.where(position: "Alcaldia")
                redirect_to :action => "index"
            else
                puts "-------------------------------------------"
                puts "Voting point incorrect"
                puts "-------------------------------------------"
            end
        else
            puts "No CC found"
        end
        
    end

    def first_vote
        flash["voteRender"] = "vote2"
        session["vote1"] = params[:vote][:vote][:name]
        session["alcaldiaVoteID"] = params[:vote][:vote][:id]
        redirect_to :action => "index"
    end

    def second_vote
        flash["voteRender"] = "confirm"
        session["vote2"] = params[:vote][:vote][:name]
        session["gobernacionVoteID"] = params[:vote][:vote][:id]
        redirect_to :action => "index"
    end

    def confirm_vote
        if params[:accept]
            puts "--------------------------------------------"
            puts session["votantID"]
            puts "--------------------------------------------"
            @vote = Vote.new(voter_id: session["votantID"], voting_point_id: session["votingPointID"], alcaldia: session["alcaldiaVoteID"], gobernacion: session["gobernacionVoteID"])
            if @vote.save
                puts "Done"
                redirect_to :action => "index"
            else
                puts @vote.errors.full_messages
            end
        else
            redirect_to :action => "index"
        end
    end

    private def init_vote_params
        params.require(:vote).permit(:voting_point)
    end
end 
