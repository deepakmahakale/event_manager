class UserEventsController < ApplicationController
  before_action :set_user_event, only: [:show, :edit, :update, :destroy]

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @user_event.update(user_event_params)
        format.html { redirect_to my_events_path, notice: 'Response sent successfully' }
        format.json { render :show, status: :ok, location: @user_event }
      else
        format.html { redirect_to my_events_path }
        format.json { render json: @user_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_events
    @user_events = current_user.user_events.joins(:event).order(start_time: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_event
      @user_event = current_user.user_events.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_event_params
      params.require(:user_event).permit(:rsvp_status)
    end
end
