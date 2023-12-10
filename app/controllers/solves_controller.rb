class SolvesController < ApplicationController
  before_action :set_solve, only: %i[show edit update destroy]

  # GET /solves or /solves.json
  def index
    @solves = Solve.all
  end

  # GET /solves/1 or /solves/1.json
  def show
  end

  # GET /solves/new
  def new
    @solve = Solve.new
  end

  # GET /solves/1/edit
  def edit
  end

  # POST /solves or /solves.json
  def create
    @solve = Solve.new(solve_params)

    solve_ids = session[:solve_ids] ||= []
    problem = Problem.find(solve_params[:problem_id])
    unless signed_in? && !solve_ids.nil?
      unless problem.solves.where(id: solve_ids).empty?
        head :unprocessable_entity
        return
      end
    end

    respond_to do |format|
      if @solve.save
        unless signed_in?
          solve_ids << @solve.id
        end

        format.html { redirect_to problem_url(@solve.problem), notice: "Solve was successfully created." }
        format.json { render :show, status: :created, location: @solve }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @solve.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solves/1 or /solves/1.json
  def update
    respond_to do |format|
      if @solve.update(solve_params)
        format.html { redirect_to solve_url(@solve), notice: "Solve was successfully updated." }
        format.json { render :show, status: :ok, location: @solve }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @solve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solves/1 or /solves/1.json
  def destroy
    @solve.destroy!

    respond_to do |format|
      format.html { redirect_to solves_url, notice: "Solve was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_solve
    @solve = Solve.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def solve_params
    params.require(:solve).permit(:tile, :problem_id, :user_id)
  end
end
