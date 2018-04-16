module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        render json: Cocktail.all
      end

      def show
        cocktail = Cocktail.find(params[:id])

        cocktail_json = {
          id: cocktail.id,
          name: cocktail.name,
          description: cocktail.description,
          instructions: cocktail.instructions,
          source: cocktail.source,
          proportions: cocktail.proportions.map do |prop|
            {
              id: prop.id,
              ingredient_name: prop.ingredient.name,
              amount: prop.amount
            }
          end
        }

        render json: cocktail_json
      end

      def create
        @cocktail = Cocktail.create(cocktail_params)
        # byebug
        # @ingredient = Ingredient.find_or_create_by(name: params[:proportions][0][:ingredient_name])
        params[:proportions].each do |proportion|
           ingredient = Ingredient.find_or_create_by(name: proportion[:ingredient_name])
           @proportion = Proportion.create(amount: proportion[:amount], cocktail_id: @cocktail.id, ingredient_id: ingredient.id)
        end
        # @proportion = Proportion.create(amount: params[:proportions][0][:amount], cocktail_id: @cocktail.id, ingredient_id: @ingredient.id)
        render json: Cocktail.all
      end

      def edit

      end

      def update

      end

      def destroy

      end

      private

      def cocktail_params
        params.permit(:name, :description, :instructions, :proportions)
      end


    end
  end
end
