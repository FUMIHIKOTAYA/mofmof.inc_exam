class LeasesController < ApplicationController

  def index
    @leases = Lease.all
  end

  def new
    @lease = Lease.new
    2.times { @lease.closest_stations.build }
  end

  def create
    @lease = Lease.new(lease_params)
    if @lease.save
      redirect_to leases_path, notice: %q(物件を登録しました。)
    else
      render :new
    end
  end

  def show
    @lease = Lease.find(params[:id])
    @closest_stations = @lease.closest_stations
  end

  private

  def lease_params
    params.require(:lease).permit(
      :lease_name,
      :rent,
      :address,
      :age,
      :note,
      closest_stations_attributes: %i(route_name station_name minute_walk),
    )
  end
end
