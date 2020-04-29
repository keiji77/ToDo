class TasksController < ApplicationController
  before_action :move_to_index, except: :index

  def index
    @tasks = Task.all
  end
    
  def new
    @task = Task.new
  end

  def create
    Task.create(name: task_params[:name], time: task_params[:time], user_id: current_user.id)
    redirect_to action: :index
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update(task_params)
    redirect_to action: :index
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to action: :index
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  private
    def task_params
      params.require(:task).permit(:name, :time)
    end
end