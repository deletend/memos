class Admin::MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  helper_method :admin?

  def index
    @user = current_user
    if @user
      @memos = @user.memos
    else
      redirect_to "/", notice: "ログインして"
    end
  end

  def admin?
    return true
  end

  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to "/admin/memos", notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /memos/new
  def new
    if @user = current_user
      @memo = Memo.new
    else
      redirect_to "/", notice: "ログインして"
    end
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)
    @user = current_user

    respond_to do |format|
      if @user.memos.create!(title: params["memo"]["title"], body: params["memo"]["body"])
        format.html { redirect_to "/admin/memos", notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to "/admin/memos", notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:title, :body)
    end
end
