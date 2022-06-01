class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show]

  def new
    @shipment = Shipment.new
    authorize @shipment
  end

  def create
    @shipment = Shipment.new(shipment_params)
    authorize @shipment
    if @shipment.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
  end

  def show
    # @scans = @shipment.authentic_network? ? helpers.authentic_scans(@shipment.authentic_id) : @shipment.scans
    authorize @shipment
  end

  private

  def shipment_params
    params.require(:shipment).permit(:project_id, :user_id, :start_date, :expected_arrival_date, :transport_type,
                                     :starting_location, :destination_location, :qr_code_type)
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end