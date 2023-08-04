class EntitiesController < ApplicationController
  before_action :set_group
  before_action :set_entity, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /entities or /entities.json
  def index
    # @entities = Entity.all
    # @entities = @group.entities
    @entities = @group&.entities || []
    @total_amount = @group&.entities&.sum(:amount) || 0
  end

  # GET /entities/new
  def new
    @entity = Entity.new
  end

  # POST /entities or /entities.json
  def create
    @entity = Entity.new(entity_params)
    @entity.author_id = current_user.id
    @entity.user_id = current_user.id
  
    @entity.groups << @group
  
    respond_to do |format|
      if @entity.save
        format.html { redirect_to group_entities_path(group_id: @group.id), notice: "Entity was successfully created." }
        format.json { render :show, status: :created, location: @entity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity
      @entity = Entity.find(params[:id])
    end

    def set_group
      @group = Group.find_by(id: params[:group_id])
    end

    # Only allow a list of trusted parameters through.
    def entity_params
      params.require(:entity).permit(:name, :amount)
    end
end
