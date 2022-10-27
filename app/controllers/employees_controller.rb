class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  before_action :fetch_team, only: %i[assign_team]

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @admin_check = Employee.find_by(is_admin: true)
    @submit = "Create"
  end

  # GET /employees/1/edit
  def edit
    @submit = "Update"
    @admin_check = Employee.find_by(is_admin: true)
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assign_team
    if request.get?
      @employee_team = EmployeeTeam.new 
      @submit = "Assign"
    elsif request.post?
      employee = Employee.find(params[:employee_id])
      @team = params[:team].to_i
      lunch_date = params[:employee_team][:lunch_date]
      @employee_team = EmployeeTeam.new(employee_id: employee.id, team_id: params[:team].to_i, lunch_date: lunch_date)
      if @employee_team.save
        create_blind_dates(employee.id, lunch_date)
        redirect_to employee_url(employee), notice: "Employee was successfully assigned!."
      else
        render :assign_team
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def fetch_team
      @teams = Team.all
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :is_admin)
    end

    def create_blind_dates(emp_id, lunch_date)
      employee = Employee.find emp_id
      blind_date = BlindDate.find_by(employee_id: emp_id) #check for unique record
      BlindDate.create(employee_id: emp_id, selected_date: lunch_date) if employee.is_admin? && blind_date.nil?
    end
end
