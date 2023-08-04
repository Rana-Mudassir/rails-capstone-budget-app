class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /groups or /groups.json
  def index
    @groups = Group.all

    @group_amounts = {}
    @groups.each do |group|
      total_amount = group.entities.sum(:amount)
      @group_amounts[group.id] = total_amount
    end
  end

  # GET /groups/1 or /groups/1.json
  def show
    redirect_to group_entities_path(@group)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    @group.user = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :icon, :user)
    end
end
