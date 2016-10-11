class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]

  # GET /battles
  def index
    @battles = Battle.desc(:created_at).all
  end

  # GET /battles/1
  def show
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  def create
    @battle = Battle.new(battle_params)
    1.upto @battle.base_count do |no|
      @battle.villas << Villa.new({no: no, name: "", comment: ""})
    end

    if @battle.save
      redirect_to @battle, notice: 'Battle was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /battles/1
  def update
    if @battle.update(battle_params)
      redirect_to @battle, notice: 'Battle was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /battles/1
  def destroy
    @battle.destroy
    redirect_to battles_url, notice: 'Battle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:battle).permit(:code, :opponent_name, :base_count)
    end
end
