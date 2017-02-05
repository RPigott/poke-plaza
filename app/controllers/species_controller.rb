class SpeciesController < ApplicationController
    def abilities
        @species = Species.find(params[:id])
        respond_to do |format|
           format.js {render 'abilities', layout: false}
        end
    end
end
