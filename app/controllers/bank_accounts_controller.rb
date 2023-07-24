class BankAccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bank_account, only: %i[ show edit update destroy ]

  def index
    @bank_accounts = current_user.bank_accounts
  end

  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = current_user.bank_accounts.build(bank_account_params)
    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to root_path, notice: "Bank account was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bank_account.destroy
    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: "Bank account was successfully destroyed." }
    end
  end

  private
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    def bank_account_params
      params.require(:bank_account).permit(:name, :account_number, :account_type, :bank_name, :user_id)
    end
end
