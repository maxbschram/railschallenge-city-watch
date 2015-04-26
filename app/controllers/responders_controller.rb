class RespondersController < ApplicationController
  def create
    @responder = Responder.new(create_params)

    if @responder.save
      render 'responders/show', status: 201
    else
      render json: { message: @responder.errors.messages }, status: 422
    end
  end

  def index
    @responders = Responder.all
    render 'responders/capacity' if params[:show] == 'capacity'
  end

  def show
    @responder = Responder.find_by(name: params[:id])
    render file: 'public/404.json', status: :not_found if @responder.nil?
  end

  def update
    @responder = Responder.find_by(name: params[:id])
    @responder.update_attributes(update_params)
    render 'responders/show'
  end

  def edit
    render file: 'public/404.json', status: :not_found
  end

  def new
    render file: 'public/404.json', status: :not_found
  end

  def destroy
    render file: 'public/404.json', status: :not_found
  end

  private

  def create_params
    params.require(:responder).permit(:name, :type, :capacity)
  end

  def update_params
    params.require(:responder).permit(:on_duty)
  end
end
