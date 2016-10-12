class AttacksController < ApplicationController
  before_action :set_battle, only: [:new, :create, :edit, :update]
  before_action :set_villa, only: [:new, :create, :edit, :update]
  before_action :set_attack, only: [:edit, :update, :destroy]

  # GET /battles/:battle_id/villas/:villa_id/attacks/new
  def new
    @attack = Attack.new
  end

  # GET /battles/:battle_id/villas/:villa_id/attacks/:id/edit
  def edit
  end

  # POST /battles/:battle_id/villas/:villa_id/attacks
  def create
    @villa.attacks << Attack.new(attack_params)

    if @villa.save
      redirect_to battle_path(@battle.id), notice: 'Attack was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /battles/:battle_id/villas/:villa_id/attacks/:id
  def update
    if @attack.update(attack_params)
      redirect_to battle_path(@battle.id), notice: 'Attack was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /battles/:battle_id/villas/:villa_id/attacks/:id
  def destroy
    @attack.destroy
    redirect_to battle_path(@battle.id), notice: 'Attack was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      # TODO: Not Found 時処理
      @battle = Battle.find(params[:battle_id])
    end
    def set_villa
      # TODO: Not Found 時処理
      @villa = @battle.villas.find(id: params[:villa_id])
    end
    def set_attack
      # TODO: Not Found 時処理
      @attack = @villa.attacks.find(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attack_params
      params.require(:attack).permit(:name, :comment, :result)
    end
end
