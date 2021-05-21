class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]


  # GET /votes or /votes.json
  def index
    @votes = Vote.all_for(current_user).order(created_at: :desc)
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    set_writable_duties false
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit

    (!@vote.can_write current_user) ? redirect_to(:index) : set_writable_duties(true)

  end

  # POST /votes or /votes.json
  def create
    set_writable_duties false
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
    set_writable_duties true
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

    if @vote.can_write current_user
      @vote.destroy
      respond_to do |format|
        format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
        format.json { head :no_content }
      end

    else

      respond_to do |format|
        format.html { redirect_to votes_url, notice: "Vote wasnt successfully destroyed." }
        format.json { head :no_content }
      end

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
      params['vote']['keep_idea_count'] = params['vote']['keep_idea_count'].to_i unless params['vote']['keep_idea_count'].nil?
      params.require(:vote).permit( :vote_type, :vote_status, :body, :title, :active_to, :iter_array, :current_iter, :duty_id, :keep_idea_count)
    end
  private
  def set_writable_duties expanded
    @writable_duties = current_user.writable_duties

    if expanded
      #@writable_duties = [@writable_duties, @vote.duty].flatten.uniq
      @writable_duties << @vote.duty
      @writable_duties.uniq!
    end
  end
end
