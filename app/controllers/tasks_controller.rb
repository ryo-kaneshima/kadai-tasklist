class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update,:destroy]
    
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
  end
  
  def show
  end

  def new
    @task = Task.new
  end

  def create
     @task = current_user.tasks.build(task_params)
     
    if @task.save
      flash[:success] = 'taskを投稿しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'taskの投稿に失敗しました。'
      render  :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを編集しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは編集されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = '削除しました'
    redirect_to root_path
  end
  
  
  private
  
    # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
  
end