class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy, :create_commnet]
  helper_method :admin?

  # GET /memos
  # GET /memos.json
  def index
    @user = current_user
    @memos = @user ? @user.memos : Memo.all
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
  end

  def admin?
    return false
  end

  def new_comment
    @comment = Comment.new
  end

  def create_comment
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @memo.create!(memo_id: @memo["id"], body: params["comment"]["body"])
        format.html { redirect_to @memo, notice: 'コメントできた' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :show }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
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
