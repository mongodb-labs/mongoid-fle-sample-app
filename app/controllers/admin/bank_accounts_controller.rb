module Admin
  class BankAccountsController < ApplicationController
    def index
      @bank_accounts = Admin::BankAccount.all
    end

  end
end
