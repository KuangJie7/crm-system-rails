class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to sessions_new_path
    else
      render 'new'
    end
  end

  def list
    @q = Team.ransack(params[:q])
    @teams = @q.result.includes(customer: :description).page(params[:page]||1).per_page(params[:perpage]||30)
  end

  def list_potential
    @q = Team.ransack(params[:q])
    @teams = @q.result.joins(:customer).includes(customer: :description).where("customers.potential_level=2").page(params[:page]||1).per_page(params[:perpage]||30)
  end


  def list_deep
    @q = Team.ransack(params[:q])
    @teams = @q.result.joins(:customer).includes(customer: :description).where("customers.potential_level=3").page(params[:page]||1).per_page(params[:perpage]||30)
  end

  def multi_choice_check
    if params[:teams].nil?
      #弹出错误
      redirect_to teams_path(current_user.id)
    else
      @checked_teams = Team.find(params[:teams].keys)
      @c = []
      @checked_teams.each do |i|
        @c << i.id
      end
    end
  end

  def get_multichosen_customers
    a = params[:chosen_teams].slice(1, params[:chosen_teams].length-2)
    b = a.split(",")
    i = 0
    @customers = []
    @checked_teams = Team.find(b)
    while i < b.size do
      @customers << Customer.find_or_create_by(team_id: b[i])
      i += 1
    end
    @customers
  end

  def multi_choice_improve
    @customers = get_multichosen_customers
    @already_added_customers = []
    @new_coming_customers = []
    @customers.each do |t|
      if t.potential_level <= params[:potential_level].to_i
        t.potential_level += 1
        t.save
        @new_coming_customers << t
      else
        @already_added_customers << t
      end
    end
  end

  def multi_choice_degrade
    @customers = get_multichosen_customers
    @customers.each do |t|
      t.potential_level -= 1
      t.save
    end
  end

  def mylist
    @user = current_user
    @q = Customer.where("allocator_name = ?", current_user.name).ransack(params[:q])
    @aimCustomers = @q.result.includes(:team).order(alloted_time: :asc).page(params[:page]||1).per_page(params[:perpage]||30)
  end

  def allfeedback
    @q = Feedback.ransack(params[:q])
    @aimFeedback = @q.result.includes(customer: [:team,:users]).order(user_id: :asc,customer_id: :asc,created_at: :desc).page(params[:page]||1).per_page(params[:perpage]||30)
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :email)
  end

  def query_params
    params.require(:description).permit(:level, :field, :scale, :start_date, :end_date, :state)
  end
end
