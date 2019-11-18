class PoliticPartyController < ApplicationController

    def index
        @state = flash["politicState"]
    end

    def register
        @politic_party = PoliticParty.find_by(politic_params)
        if @politic_party
            flash["politicState"] = "exist"
            redirect_to :action => "index"
        else
            @politic_party = PoliticParty.new(politic_params)
            if @politic_party.save
                flash["politicState"] = "save"
                redirect_to :action => "index"
            else
                flash["politicState"] = "error"
                redirect_to :action => "index"
            end
        end
    end

    private def politic_params
        params.require(:politic_party).permit(:name)
    end
end
