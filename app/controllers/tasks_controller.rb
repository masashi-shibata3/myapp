class TasksController < ApplicationController
    
    before_action :set_task, only:[:show, :edit,:update,:destroy]

    
    def index
        if logged_in?
        @task = current_user.tasks.build
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
        counts(@task)

        end
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
        flash[:success] ='投稿できました'
        redirect_to root_url
        else
        flash.now[:danger]='投稿できませんでした'
        render :new
        end
    end
    
    def edit
    end
    
    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
        flash[:success]='タスクを更新しました'
        redirect_to @task
        else
        flash.now[:danger]='タスクは更新されませんでした'
        render :edit
        end
    end
    
    def destroy
        
        @task.destroy
        
        flash[:success]= 'タスクを削除しました'
        redirect_back(fallback_location: root_path)
    end
    
private
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :deadline)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end