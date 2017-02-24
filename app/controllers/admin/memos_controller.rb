class Admin::MemosController < ApplicationController
  def index
    @memos = Memo.all
  end
end
