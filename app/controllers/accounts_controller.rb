class AccountsController < ApplicationController

  def new
    @account = Account.new
    @account.build_owner
  end
  
end