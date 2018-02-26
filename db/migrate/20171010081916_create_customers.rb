class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.belongs_to :team,index: true
      t.boolean :alloted
      t.integer :potential_level
      t.datetime :alloted_time
      t.string :allocator_name
      t.timestamps null:false
    end

    create_table :crm_users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :password_digest
      t.timestamps null:false
    end

    create_join_table :customers, :crm_users do |t|
      t.index [:crm_user_id, :customer_id]
      t.datetime :created_at,null:false
      t.datetime :updated_at,null:false
      t.timestamps null:false
    end

    create_table :feedbacks do |t|
      t.string :feedback_content
      t.string :crm_user_name
      t.belongs_to :customer,index: true
      t.belongs_to :user,index:true
      t.timestamps null:false
    end

    create_table :descriptions do |c|
      c.belongs_to :customer, index: true
      c.string :field
      c.string :scale
      c.string :job
      c.string :department
      c.string :note
      c.string :level
      c.timestamps null:false
    end

    rename_table :crm_users_customers,:customers_crm_users
    rename_column :customers_crm_users,:crm_user_id,:user_id
  end
end
