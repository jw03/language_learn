class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
    	t.string :user
      t.string :braintree_payment_id
      t.string :status
      t.string :fourdigit
      t.timestamps
    end
  end
end
