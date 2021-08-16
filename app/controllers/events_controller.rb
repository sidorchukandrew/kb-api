class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events, include: :users
  end

  # GET /events/1
  def show
    render json: @event, include: :users
  end

  # POST /events
  def create
    @workers = User.where(username: params[:workers])
    @event = Event.new(event_params)

    @event.workers = @workers

    if @event.save
      @event.users << @workers
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    @workers = User.where(username: params[:workers])

    if @workers.present?
      @event.workers = @workers
    else
      @event.workers = @event.users
    end

    if @event.update(event_params)
      if @workers.present?
        @event.users = @workers
      end
      
      render json: @event, include: :users
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.permit(:delivery_driver, :delivery_fee, :description, :event_cost_flat_fee, :event_cost_percentage, :event_date,
        :revenue, :is_paid_out, :tax_flat_fee)
    end
end
