class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
    
  def index
    if logged_in?
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
    # @tasks = current_user.microposts.order(id: :desc).page(params[:page])
    end
  end
  
  def show
    # @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)

    # if @task.save
    #   flash[:success] = 'task が正常に投稿されました'
    #   redirect_to @task
    # else
    #   flash.now[:danger] = 'task が投稿されません'
    #   render :new
    # end
     @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'taskを投稿しました。'
      redirect_to @task
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'taskの投稿に失敗しました。'
      render  :new
    end
  end

  def edit
    # @task = Task.find(params[:id])
  end

  def update
    # @task = Task.find(params[:id])
  
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
    redirect_to tasks_url
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
    # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end