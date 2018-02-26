class CustomersController < ApplicationController
  def index

  end

  def show
    @team = Team.find(params[:id])
    @users = Account.find_by_sql("SELECT full_name,profile,name,id,mobile,created,email,team_id,role FROM users Where team_id = #{params[:id]} && role = 0;")
    @user = @users[0]
    get_or_create_customer(params[:id])
    @customer = @team.customer

    @feedbacks = @customer.feedbacks.order("created_at DESC")

    @description = @customer.description
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create

  end

  def update

  end

  def destroy

  end

  def allot
    @user = User.all
    @team = Team.find(params[:id])

    #@user.customers << @customer
  end

  def allocation
    #@team = Team.find(params[:id])
    #@customer = @team.customer
    @customer = get_or_create_customer(params[:id])
    @tempuser = User.new(allot_params)
    @user = User.find_by(name: @tempuser.name)
    if @customer.users.exists?
      redirect_to customer_path
    else
      @user.customers << @customer
      @customer.alloted = true
      @customer.alloted_time = Time.new
      @customer.allocator_name = @user.name
      @customer.save
      redirect_to customer_path
    end
  end

  def get_or_create_customer(a_number)
    @team = Team.find(a_number)
    Customer.find_or_create_by(team_id: @team.id)
  end

  private
  def allot_params
    params.require(:user).permit(:name)
  end
end
