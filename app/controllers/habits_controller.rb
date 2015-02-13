class HabitsController < ApplicationController
  before_action :set_habit, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  # GET /habits
  # GET /habits.json
  def index
#    @habits = Habit.all
    #@habits = Habit.where(user_id: current_user.id, deleted_at: )
    #@habits = Habit.where("user_id = ? AND deleted_at is null", current_user.id).order('start_at DESC')
#    @habits = Habit.with_deleted.where("user_id = ?", current_user.id).order('start_at DESC')
    @habits = Habit.where("user_id = ?", current_user.id).order('start_at DESC')
  end

  # GET /habits/1
  # GET /habits/1.json
  def show
    #@results = Result.where("habit_id = ?", @habit.id)
    #@results = @habit.results.maximum(result_at)
    #@results = @habit.results.select("strftime('%Y-%m-%d','result_at'),result")
#    logger.warn(@results)
#    logger.warn(@results.maximum('result_at'))

    if params[:month].nil? 
      #logger.warn(params[:month][4..5])
      #@month = Date.today
      #if @month.between?(@habit.start_at, @habit.end_at)
        @month = Date.today
      if @habit.start_at > Date.today
        @month = @habit.start_at
      elsif @habit.end_at < Date.today
        @month = @habit.end_at
      end
    else
      if params[:month].length == 6
        @month = Date.new(params[:month][0..3].to_i, params[:month][4..5].to_i, 1)
      elsif params[:month].length == 10
        #@month = Date.new(params[:month][0..3].to_i, params[:month][5..6].to_i, params[:month][8..9].to_i)
        #@resluts = @habit.results.where("result_at like '%" + params[:month] + "%'")
        @month = Date.parse(params[:month])

        @resluts = @habit.results.where("result_at like '%#{params[:month]}%'")
        if @resluts.count > 0
          #@habit.results.update_all("done = '#{params[:done]}'", "result_at like '%#{params[:month]}%'")
          @habit.results.where("result_at like '%#{params[:month]}%'").update_all(:done => params[:done])
        else    
          @result = Result.new
          @result.habit_id = @habit.id
          @result.done = params[:done].to_i
          @result.result_at = @month
          @result.save
        end

=begin
        if @resluts.count > 0
          @resluts.each do |result|
            #result.done = params[:result].to_i
            #if @habit.update( :results_attributes=>{ :id => result.id, :done => params[:result].to_i })
            logger.warn(params[:done])
            if result.update(:done => params[:done].to_i)
              #format.html { redirect_to @habit, notice: 'Habit was successfully updated.' }
              #format.json { head :no_content }
               logger.warn('更新しました。' + params[:month])
            else
              #format.html { render action: 'edit' }
              #format.json { render json: @habit.errors, status: :unprocessable_entity }
               logger.warn('更新に失敗しました。' + params[:month])
            end
            #logger.warn('result:' + result )            
          end
        else
          #@resluts = result.new          
        end
=end
      end
        
    end
    #@month.between?(@habit.start_at, @habit.end_at) unless  @month = @habit.end_at
    #@month = @habit.end_at unless @month.between?(@habit.start_at, @habit.end_at) 
    #@month = @habit.results.max(result_at)
    @boxs = [[" ", "0"], ["◯", "1"], ["×", "2"], ["—", "3"]]
    @cal_class = ["","cal1","cal2","cal3"]
    @select_class = ["select_result0","select_result1","select_result2","select_result3"]
    @youbiFlg = [@habit.monday, @habit.tuesday, @habit.wednesday, @habit.thursday, @habit.friday, @habit.saturday, @habit.sunday]
    #logger.warn(@habit.results.select(result_at))
    @youbi = @month.beginning_of_month.strftime('%w').to_i
    @youbi = 7 if @youbi == 0
    #@ym = @month.strftime('%Y%m')
    #params.merge(month: @month.beginning_of_month.strftime('%Y%m'))
    @end_day = @month.end_of_month.day
    #@aaa=@habit.results.where("result_at = ?", @month.beginning_of_month+1.day).count
    #@aaa=@habit.results.where(result_at: @month.beginning_of_month..@month.end_of_month).count
    #@aaa=@habit.results.where("result_at like '%" + (@month.beginning_of_month+(3).day).strftime('%Y/%m/%d') + "%'")
    #logger.warn(@month.beginning_of_month)
    #logger.warn(@month.end_of_month)
    #logger.warn(@aaa[0].result)

    #logger.warn(@month.end_of_month.strftime('%d'))
    #Time.now.between?(@habit.start_at, @habit.end_at) unless 
    logger.warn("params#{params}")
  end

  # GET /habits/new
  def new
    @habit = Habit.new
    @habit.user_id = current_user.id
    @habit.start_at = Time.now
    @habit.end_at = Time.now.next_month.yesterday
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits
  # POST /habits.json
  def create
    @habit = Habit.new(habit_params)
    set_checkbox
    respond_to do |format|
      if @habit.save
        format.html { redirect_to @habit, notice: 'Habit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @habit }
      else
        format.html { render action: 'new' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habits/1
  # PATCH/PUT /habits/1.json
  def update
    respond_to do |format|
      ##@habit.sunday = habit_params[sunday]
      #@habit.monday = habit_params[monday]
      #if params['sunday'].nil? 
      #  @habit.sunday = false
      #else
      #  @habit.sunday = true
      #end
      set_checkbox
      #logger.warn(params['sunday'])
      #logger.warn(params['monday'])
#      config.debag_logger.debag(params)
      #@habit.target = @habit.target + params['sunday'].to_s
      #logger.warn(params['habit'])
      logger.warn(params['habit'].require(:start_at).length)
      if @habit.update(habit_params)
        format.html { redirect_to @habit, notice: 'Habit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1
  # DELETE /habits/1.json
  def destroy
    @habit.destroy
    respond_to do |format|
      format.html { redirect_to habits_url }
      #format.json { head :no_content }
    end
  end

  # GET /habits/1
  # GET /habits/1.json
  def detail
    logger.warn(params)
    #redirect_to habit_result_path
  end

def update_result
      logger.warn('update_result')  
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit
      @habit = Habit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def habit_params
#      params.require(:habit).permit(:user_id, :target, :start_at, :end_at)
      params.require(:habit).permit(:target, :start_at, :end_at, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :results_attributes)
#      params[:habit].permit(:target, :start_at, :end_at, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
#      params.require(:habit).permit(:user_id, :target, :start_at, :end_at)
      params.require(:result).permit(:done)
#      params[:habit].permit(:target, :start_at, :end_at, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday)
    end

    # Before actions
    def signed_in_user
      #redirect_to signin_url, notice: "Please sign in." unless signed_in?
      unless signed_in?
        store_location
        flash[:warning] = "Please sign in."
        redirect_to signin_url
      end
    end

    def set_checkbox
      logger.warn('set_checkbox')
      if params['sunday'].nil? 
        @habit.sunday = false
      else
        @habit.sunday = true
      end
      if params['monday'].nil? 
        @habit.monday = false
      else
        @habit.monday = true
      end
      if params['tuesday'].nil? 
        @habit.tuesday = false
      else
        @habit.tuesday = true
      end
      if params['wednesday'].nil? 
        @habit.wednesday = false
      else
        @habit.wednesday = true
      end
      if params['thursday'].nil? 
        @habit.thursday = false
      else
        @habit.thursday = true
      end
      if params['friday'].nil? 
        @habit.friday = false
      else
        @habit.friday = true
      end
      if params['saturday'].nil? 
        @habit.saturday = false
      else
        @habit.saturday = true
      end
      #logger.warn(@habit.sunday)
    end
end
