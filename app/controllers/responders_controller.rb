class RespondersController < ApplicationController
  def create
    responder = Responder.new(create_params)
    
    if responder.save
      render json: {responder: responder.as_json}
    else
      render json: {message: responder.errors.messages}, status: 422
    end
    
  rescue ActionController::UnpermittedParameters => e
      render json: {message: e.message}, status: 422
  end
  
  private
  
  def create_params
    params.require(:responder).permit(:name, :type, :capacity)
  end  
end
