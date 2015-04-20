class RespondersController < ApplicationController  
  def create
    responder = Responder.new(create_params)
    
    if responder.save
      render json: {responder: responder.as_json}, status: 201
    else
      render json: {message: responder.errors.messages}, status: 422
    end  
    
    rescue ActionController::UnpermittedParameters => e
      render json: {message: e.message}, status: 422
  end
  
  def index
    if params[:show] == 'capacity'
      render file: 'responders/capacity.json'
    else
      render json: {responders: Responder.all.as_json}
    end
  end
  
  def update
    responder = Responder.find_by(name: params[:id])
    responder.update_attributes(update_params)
    render json: {responder: responder.as_json}
    
    rescue ActionController::UnpermittedParameters => e
      render json: {message: e.message}, status: 422
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
  
  def show
    responder = Responder.find_by(name: params[:id])
    if responder == nil
      render file: 'public/404.json', status: :not_found
    else    
      render json: {responder: responder.as_json}
    end
  end
  
  private
  
  def create_params
    params.require(:responder).permit(:name, :type, :capacity)
  end
  
  def update_params
    params.require(:responder).permit(:on_duty)
  end
end
