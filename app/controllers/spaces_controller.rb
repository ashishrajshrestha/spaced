class SpacesController < ApplicationController
  def index
    #@spaces = Space.all
    @spaces = policy_scope(Space)
    if params[:query].present?
      sql_query = "title ILIKE :query OR location ILIKE :query"
      @spaces = Space.where(sql_query, query: "%#{params[:query]}%")
    else
      @spaces = Space.all
    end
    @markers = @spaces.geocoded.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude
      }
    end
  end

  def show
    @space = Space.find(params[:id])
    @booking = Booking.new(user_id: current_user.id, space_id: @space.id)
    authorize @space
  end

  def new
    @space = Space.new
    authorize @space
  end

  def create
    @space = Space.new(space_params)
    @space.user_id = current_user.id
    authorize @space
    if @space.save
      redirect_to root_path, notice: 'New Space was successfully created.'
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:location, :capacity, :fee, :size, :description, :address, photos: [])
  end
end
