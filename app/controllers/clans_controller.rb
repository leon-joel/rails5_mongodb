class ClansController < ApplicationController
  before_action :set_clan, only: [:show, :edit, :update, :destroy ]

  # GET /clans
  def index
    @clans = Clan.all
  end

  # GET /clans/1
  def show
  end

  # GET /clans/new
  def new
    @clan = Clan.new
  end

  # GET /clans/1/edit
  def edit
  end

  # POST /clans
  def create
    @clan = Clan.new(clan_params)

    if @clan.save
      redirect_to @clan, notice: 'Clan was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clans/1
  def update
    if @clan.update(clan_params)
      redirect_to @clan, notice: 'Clan was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clans/1
  def destroy
    @clan.destroy
    redirect_to clans_url, notice: 'Clan was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clan
      @clan = Clan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def clan_params
      params.require(:clan).permit(:code, :name)
    end
end
