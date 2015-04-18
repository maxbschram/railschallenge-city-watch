class RespondersController < ApplicationController
  def create
    @responder = Responder.new(user_params)
    if @responder.save
      render json: {responder: @responder.as_json}
    else
      render json: {message: @responder.errors.messages}, status: 422
    end
  end
  
  private
  
  def user_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
  
end
