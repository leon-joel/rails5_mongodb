class AttacksController < ApplicationController
  before_action :set_battle, only: [:new, :create, :edit, :update]
  before_action :set_villa, only: [:new, :create, :edit, :update]
  before_action :set_attack, only: [:edit, :update, :destroy]

  # GET /attacks/new
  def new
    @attack = Attack.new
  end

  # GET /attacks/1/edit
  def edit
  end

  # POST /attacks
  def create
    @villa.attacks << Attack.new(attack_params)

    if @villa.save
      redirect_to battle_path(@battle.id), notice: 'Attack was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /attacks/1
  def update
    if @attack.update(attack_params)
      redirect_to @attack, notice: 'Attack was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /attacks/1
  def destroy
    @attack.destroy
    redirect_to attacks_url, notice: 'Attack was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:battle_id])
    end

    def set_villa
      @villa = @battle.villas.find(id: params[:villa_id])
    end
    def set_attack
      @attack = @villa.find(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attack_params
      params.require(:attack).permit(:name, :comment, :result)
    end
end
