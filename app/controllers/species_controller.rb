class SpeciesController < ApplicationController
    def abilities
        @species = Species.find(params[:id])
        respond_to do |format|
           format.js {render 'abilities', layout: false}
        end
    end
    
    def moves
        @species = Species.find(params[:id])
        respond_to do |format|
            format.js {render 'moves', layout: false}
        end
    end
    
    def genders
       @species = Species.find(params[:id])
       respond_to do |format|
           format.js {render 'genders', layout: false}
       end
    end
end
