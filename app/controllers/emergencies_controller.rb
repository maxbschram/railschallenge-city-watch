class EmergenciesController < ApplicationController
  def create
    @emergency = Emergency.new(create_params)

    if @emergency.save
      @responders = @emergency.responders
      render status: 201
    else
      render json: { message: @emergency.errors.messages }, status: 422
    end
  end

  def show
    emergency = Emergency.find_by(code: params[:id])
    if emergency.nil?
      render file: 'public/404.json', status: :not_found
    else
      render json: { emergency: emergency.as_json }
    end
  end

  def update
    emergency = Emergency.find_by(code: params[:id])
    emergency.update_attributes(update_params)
    render json: { emergency: emergency.as_json }
  end

  def index
    @emergencies = Emergency.all
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
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def update_params
    params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
  end
end
