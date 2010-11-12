class AccountsController < ApplicationController

  def new    
    @account = Account.new
    @account.build_subscription
    @account.build_owner
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = "Successfully registered."
      redirect_to dashboard_url
    else
      render :action => 'new'
    end
  end

end
