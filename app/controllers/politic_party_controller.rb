class PoliticPartyController < ApplicationController

    def index
        @state = session["politicState"]
    end

    def register
        @politic_party = PoliticParty.find_by(politic_params)
        if @politic_party
            session["politicState"] = "exist"
            redirect_to :action => "index"
        else
            @politic_party = PoliticParty.new(politic_params)
            if @politic_party.save
                session["politicState"] = "save"
                redirect_to :action => "index"
            else
                session["politicState"] = "error"
                redirect_to :action => "index"
            end
        end
    end

    private def politic_params
        params.require(:politic_party).permit(:name)
    end
end
