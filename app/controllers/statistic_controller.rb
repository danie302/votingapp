class StatisticController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index 
        @candidatesA = Candidate.find_by_sql("Select c.* from candidates as c join votes as v on c.id = v.alcaldia")
        @orderA = Hash.new(0)
        @candidatesA.each { | v | @orderA.store(v, @orderA[v]+1) }
        @countA = 0
        @orderA.each { |o| @countA = @countA + o[1] }
        @candidatesG = Candidate.find_by_sql("Select c.* from candidates as c join votes as v on c.id = v.gobernacion")
        @orderG = Hash.new(0)
        @candidatesG.each { | v | @orderG.store(v, @orderG[v]+1) }
        @countG = 0
        @orderG.each { |o| @countG = @countG + o[1] }
        @voting_points = VotingPoint.all
        @voting_points_names = ["Escoge un punto de votación"]
        @voting_points.each { |v|
            @voting_points_names.push(v[:name])
        }
    end

    def start_filt
        flash["filtValue"] = params[:value]
        redirect_to :action => "voting_point"
    end
    
    def voting_point
        @candidatesA = Candidate.find_by_sql("Select c.* from candidates as c join votes as v on c.id = v.alcaldia join voting_points as vp on v.voting_point_id = vp.id where v.voting_point_id = #{VotingPoint.find_by(name: flash["filtValue"])[:id]}")
        @orderA = Hash.new(0)
        @candidatesA.each { | v | @orderA.store(v, @orderA[v]+1) }
        @countA = 0
        @orderA.each { |o| @countA = @countA + o[1] }
        @candidatesG = Candidate.find_by_sql("Select c.* from candidates as c join votes as v on c.id = v.gobernacion join voting_points as vp on v.voting_point_id = vp.id where v.voting_point_id = #{VotingPoint.find_by(name: flash["filtValue"])[:id]}")
        @orderG = Hash.new(0)
        @candidatesG.each { | v | @orderG.store(v, @orderG[v]+1) }
        @countG = 0
        @orderG.each { |o| @countG = @countG + o[1] }
        @voting_points = VotingPoint.all
        @voting_points_names = ["Escoge un punto de votación"]
        @voting_points.each { |v|
            @voting_points_names.push(v[:name])
        }
    end

end
