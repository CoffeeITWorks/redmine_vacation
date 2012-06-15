class VacationStatusesController < ApplicationController
  unloadable
  before_filter :require_vacation_manager

  # GET /vacation_statuses/
  def index
    @vacation_status_pages, @vacation_statuses = paginate :vacation_statuses, :per_page => 25, :order => "position"
    render :action => "index", :layout => false if request.xhr?
  end

  # GET /vacation_statuses/new
  def new
    @vacation_status = VacationStatus.new
  end
  
  # POST /vacation_statuses
  def create
    @vacation_status = VacationStatus.new(params[:vacation_status])
    if request.post? && @vacation_status.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  # GET /vacation_statuses/1/edit
  def edit
    @vacation_status = VacationStatus.find(params[:id])
  end
  
  # GET /vacation_statuses/1
  def show
    @vacation_status = VacationStatus.find(params[:id])
  end  
  

  # POST /vacation_statuses
  def create
    @vacation_status = VacationStatus.new(params[:vacation_status])
    if request.post? && @vacation_status.save
      flash[:notice] = l(:notice_successful_create)
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  # PUT /vacation_statuses/1
  def update
    @vacation_status = VacationStatus.find(params[:id])

    respond_to do |format|
      if @vacation_status.update_attributes(params[:vacation_status])
        flash[:notice] = l(:notice_successful_update)
        format.html { redirect_to(vacation_statuses_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /vacation_statuses/1
  def destroy
    VacationStatus.find(params[:id]).destroy
    redirect_to :action => 'index'
  rescue
    flash[:error] = l(:error_unable_delete_vacation_status)
    redirect_to :action => 'index'
  end  
  
  private
    def require_vacation_manager
      (render_403; return false) unless User.current.is_vacation_manager?
    end
end