class VillasController < ApplicationController
  before_action :set_battle, only: [:edit, :update]
  before_action :set_villa, only: [:edit, :update]

  # /battles/:battle_id/villas/:id/edit
  def edit
  end

  # /battles/:battle_id/villas/:id
  def update
    @villa.update(villa_params)
    redirect_to battle_path(@battle.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      # TODO: Not Found 時処理
      @battle = Battle.find(params[:battle_id])
    end

    def set_villa
      # TODO: Not Found 時処理
      @villa = @battle.villas.find(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def villa_params
      params.require(:villa).permit(:name, :comment)
    end
end
