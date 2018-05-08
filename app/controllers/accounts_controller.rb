class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  authorize_resource

  # GET /products
  def index
    @accounts = Account.all
  end

  # GET /products/1
  def show
    @accounts = Account.find(params[:id])
    if !current_account.tech? && !(@accounts.id == current_account.id)
      redirect_to "/accounts/#{current_account.id}"
    end
    @audits = @accounts.audits
    @equipment = Equipment.all
  end

  # GET /products/new
  def new
    @accounts = Account.new
  end

  # GET /products/1/edit
  def edit
    @accounts = Account.find(params[:id])
  end

  # POST /products
  def create
    @accounts = Account.new(account_new_params)

    if @accounts.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    t = {}
    case account_update_params[:tier]
    when "User"
      t = {tech: false, admin: false}
    when "Technician"
      t = {tech: true, admin: false}
    when "Admin"
      t = {tech: true, admin: true}
    end
    if @accounts.update(t)
      redirect_to @accounts, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end
accounts = Account
  # DELETE /products/1
  def destroy
    @accounts.destroy
    redirect_to accounts_path, notice: 'Account was successfully destroyed.'
  end

  # POST /equipment/search
  def search
    # {"search" => {"name" => "some entered name"} }
    @accounts = Account.where("lower (givenname) LIKE :query", query: "%#{params[:search][:name].downcase}%").or(Account.where(id: params[:search][:name]))
    @detail = Detail.all
    @searched = true
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @accounts = Account.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def account_new_params
      params.require(:account).permit(:id, :givenname, :tech, :admin, :email)
    end

    def account_update_params
      params.require(:account).permit(:tier)
    end
end
