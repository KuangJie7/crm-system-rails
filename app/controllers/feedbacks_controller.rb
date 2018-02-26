class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    #@customer.feedbacks.create
    @user = current_user
    @customer = Customer.find_by(team_id: params[:customer_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.crm_user_name = @user.name
    @customer.feedbacks << @feedback
    @user.feedbacks << @feedback
    redirect_to customer_path(params[:customer_id])
  end

  private
  def feedback_params
    params.require(:feedback).permit(:feedback_content,:customer_id,:user_id,:crm_user_name)
  end
end

