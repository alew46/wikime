class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Wikime Premium Plan",
     amount: 15_00
   }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Wikime Premium Plan - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Congrats - you have upgraded to a Wikime Premium Plan! You can now create private Wikis and invite collaborators."
    current_user.premium!
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def downgrade

    # downgrade the user
    current_user.standard!
    flash[:notice] = "Your account has been downgraded to standard. Any private Wikis you owned are now public."

    # set all of their wikis to not be private

    # redirect somewhere
    redirect_to user_path(current_user)
  end

end
