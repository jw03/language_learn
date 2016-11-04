class PaymentsController < ApplicationController

  before_action :require_login

  def new
    @client_token = Braintree::ClientToken.generate
    @chat = Chat.find(params[:id])
    @payment = Payment.new
  end

  def create
    amount = params[:payment][:total_price]
    nonce = params[:payment_method_nonce]

    render action: :new and return unless nonce

    @result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: params[:payment_method_nonce]
    )

    if @result.success?
      Payment.create(chat_id: params[:payment][:chat_id], braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)

      @chat = Chat.find(params[:payment][:chat_id])
      	if @chat.payments.count == 0
      	else
      		@chat.update(is_paid:"1")
          @host = User.find(@chat.host_id)
          b = Chat.where(host_id: @chat.host_id, is_paid:1).pluck(:amount)
          @host.update(total_coins: b.inject(:+))
      	end

        redirect_to user_path(id: current_user.id), notice: "Congratulations! Your transaction is successful!"
    else
        Payment.create(chat_id: params[:payment][:chat_id], braintree_transaction_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
        flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
        @client_token = Braintree::ClientToken.generate
        @chat = Chat.find(params[:payment][:chat_id])
        @payment = Payment.new
        render :new
    end


  end
end
