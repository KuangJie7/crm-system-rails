module CustomersHelper
  def get_or_create_customer(a_number)
    if Customer.find(a_number)
      @customer = Customer.find(a_number)
    else
      @customer = Team.find(a_number)
      @customer.save
    end
  end
end
