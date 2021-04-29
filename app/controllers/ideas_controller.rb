class IdeasController < ApplicationController
  before_action :set_idea, only: %i[ show edit update destroy unvote_up unvote_down upvote downvote  ]
  def unvote_up
    @idea.unvote_up current_user
  end
  def unvote_down
    @idea.unvote_down current_user
  end
  def upvote
    @idea.upvote current_user
  end

  def downvote
    @idea.downvote current_user
  end
# GET /votes or /votes.json
  def index
    @idea = Idea.all.order(created_at: :desc)
  end

# GET /votes/1 or /votes/1.json
  def show
  end

# GET /votes/new
  def new
    @idea = Vote.new
  end

# GET /votes/1/edit
  def edit
    #redirect_to :index unless @idea.can_update? current_user
  end

# POST /votes or /votes.json
  def create
    set_writable_duties false
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    #@idea.pictures.attach(params[:pictures]) unless params[:pictures].nil?
    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: "Idea was successfully created." }
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
      #@idea.pictures.purge if params[:pictures_changed] == "Yes"
      #@idea.pictures.attach(params[:pictures]) if (!params[:pictures].nil? and  params[:pictures_changed] == "Yes")
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: "Idea was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /votes/1 or /votes/1.json
  def destroy
      @idea.destroy
      respond_to do |format|
        format.html { redirect_to votes_url, notice: "Idea was successfully destroyed." }
        format.json { head :no_content }
      end

      respond_to do |format|
        format.html { redirect_to votes_url, notice: "Idea wasnt successfully destroyed." }
        format.json { head :no_content }
      end

    end
  private
# Use callbacks to share common setup or constraints between actions.
  def set_idea
    @idea = Idea.find(params[:id])
  end

# Only allow a list of trusted parameters through.
  def idea_params
    #params['vote']['vote_type'] = params['vote']['vote_type'].to_i unless params['vote']['vote_type'].nil?
    #params.require(:vote).permit( :vote_type, :vote_status, :body, :title, :active_to, :iter_array, :current_iter, :duty_id)
  end

end

