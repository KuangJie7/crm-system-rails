class DescriptionsController < ApplicationController
  def new
    @description = Description.new
  end

  def create
    @customer = Customer.find_by(team_id: params[:customer_id])
    @description = Description.new(description_params)
      @description = @customer.create_description(description_params)
      redirect_to customer_path(@customer.team_id)
  end

  def edit
    @customer = Customer.find_by(team_id: params[:customer_id])
    @description = Description.find_by(customer_id: @customer.id)
  end

  def update
    @customer = Customer.find_by(team_id: params[:customer_id])
    @description = Description.find_by(customer_id: @customer.id)
    @description.update(description_params)
    redirect_to customer_path(@customer.team_id)
  end

  private
  def description_params
    params.require(:description).permit(:field,:scale,:job,:note,:level,:department)
  end
end
