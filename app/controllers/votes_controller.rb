class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]


  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @writable_duties = current_user.writable_duties
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    @writable_duties = current_user.writable_duties
    @writable_duties << @vote.duty
    @writable_duties = @writable_duties.uniq
  end

  # POST /votes or /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.user_id = current_user.id
    @vote.pictures.attach(params[:pictures]) unless params[:pictures].nil?
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: "Vote was successfully created." }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      @vote.pictures.purge if params[:pictures_changed] == "Yes"
      @vote.pictures.attach(params[:pictures]) if (!params[:pictures].nil? and  params[:pictures_changed] == "Yes")
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params['vote']['vote_type'] = params['vote']['vote_type'].to_i unless params['vote']['vote_type'].nil?
      params.require(:vote).permit( :vote_type, :vote_status, :body, :title, :active_to, :iter_array, :current_iter, :duty_id)
    end

end
