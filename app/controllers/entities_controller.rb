class EntitiesController < ApplicationController
  before_action :set_group
  before_action :set_entity, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /entities or /entities.json
  def index
    # @entities = Entity.all
    # @entities = @group.entities
    @entities = @group&.entities || []
  end

  # GET /entities/1 or /entities/1.json
  def show
  end

  # GET /entities/new
  def new
    @entity = Entity.new
  end

  # GET /entities/1/edit
  def edit
  end

  # POST /entities or /entities.json
  def create
    @entity = Entity.new(entity_params)
    @entity.author_id = current_user.id
    @entity.user_id = current_user.id
  
    @entity.groups << @group

    puts "Group ID: #{@group&.id}"
    puts "Entity Group ID: #{@entity&.group_ids}"
  
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

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url, notice: "Entity was successfully destroyed." }
      format.json { head :no_content }
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
