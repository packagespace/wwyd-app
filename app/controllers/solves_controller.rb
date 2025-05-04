class SolvesController < ApplicationController
  allow_unauthenticated_access
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

    if authenticated?
      return head :conflict if Solve.exists?(user: Current.user, problem: @solve.problem)
      @solve.user = Current.user
    else
      return head :conflict if Solve.exists?(id: session[:solve_ids], problem: @solve.problem)
     end

    respond_to do |format|
      if @solve.save
        associate_solve_with_user
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
    params.expect(solve: [:tile, :problem_id])
  end

  def associate_solve_with_user
    if authenticated?
      @solve.user_id = Current.user.id
      @solve.save!
    else
      solve_ids = session[:solve_ids] ||= []
      solve_ids << @solve.id
    end
  end
end
