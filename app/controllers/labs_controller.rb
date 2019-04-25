class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
  # GET /labs
  # GET /labs.json
  def index
    @labs = Lab.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
    @lab = Lab.find(params[:id])
  end

  # GET /labs/new
  def new
    @lab = Lab.new
    # @lab = current_user.labs.build
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
  def create
    @lab = Lab.new(lab_params)
    # @lab = current_user.labs.build(lab_params)
    @lab.chart_id = params[:lab][:chart_id].upcase

    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render :show, status: :created, location: @lab }
      else
        format.html { render :new }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { render :show, status: :ok, location: @lab }
      else
        format.html { render :edit }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to labs_url, notice: 'Lab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import_from_excel
    file = params[:file]
    begin
      # Retreive the extension of the file
      file_ext = File.extname(file.original_filename)
      raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx"].include?(file_ext)
      spreadsheet = (file_ext == ".xls") ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        Lab.create(chart_id: spreadsheet.row(i)[0],
            cholest_SerPI_mCnc: spreadsheet.row(i)[1],
            HDLc_SerPI_mCnc: spreadsheet.row(i)[2],
            Trigl_SerPI_mCnc: spreadsheet.row(i)[3],
            LDLc_SerPI_Calc_mCnc: spreadsheet.row(i)[4],
            Glucose_SerPI_mCnc: spreadsheet.row(i)[5],
            Hgb_A1c_MFr_Bld: spreadsheet.row(i)[6],
            VLDL: spreadsheet.row(i)[7],
            HSCRP: spreadsheet.row(i)[8],
            received_date: spreadsheet.row(i)[9],
            source: spreadsheet.row(i)[10],
            reported_date: spreadsheet.row(i)[11],
            notes: spreadsheet.row(i)[12])
      end
      flash[:notice] = "Records Imported Succesfully. All duplicated entries have been ommited from import"
      redirect_to labs_path
    rescue => e
      flash[:notice] = "Issues with file"
      redirect_to labs_path
    end
  end

  private

  def sort_column
    Lab.column_names.include?(params[:sort]) ? params[:sort] : "chart_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:chart_id, :cholest_SerPI_mCnc, :HDLc_SerPI_mCnc, :Trigl_SerPI_mCnc, :LDLc_SerPI_Calc_mCnc, :Glucose_SerPI_mCnc, :Hgb_A1c_MFr_Bld, :VLDL, :HSCRP, :received_date, :source, :reported_date, :notes)
    end
end
