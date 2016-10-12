class BattlesController < ApplicationController
  before_action :set_clan, only: [ :new_clan_battle, :create_clan_battle ]
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
  # GET /clans/:clan_id/battles/new
  def new_clan_battle
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles
  def create
    @battle = create_battle

    if @battle.save
      redirect_to @battle, notice: 'Battle was successfully created.'
    else
      render :new
    end
  end
  # POST /clans/:clan_id/battles
  def create_clan_battle
    @battle = create_battle
    @battle.clan = @clan

    if @battle.save && @clan.save
      redirect_to @battle, notice: 'Battle was successfully created.'
    else
      render :new_clan_battle
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
    redirect_to @battle.clan.nil? ? battles_url : clan_path(@battle.clan.id), notice: 'Battle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clan
      # TODO: Not Found 時処理
      @clan = Clan.find(params[:clan_id])
    end
    def set_battle
      # TODO: Not Found 時処理
      @battle = Battle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:battle).permit(:code, :opponent_name, :base_count)
    end

    def create_battle
      battle = Battle.new(battle_params)
      1.upto battle.base_count do |no|
        battle.villas << Villa.new({no: no, name: "", comment: ""})
      end
      battle
    end
end
