class ExcelFilesController < ApplicationController

  def index
   @files= ExcelFile.all
  end
  def new
   @file= ExcelFile.new
  end
  def create
    @file= ExcelFile.new(file_params)
    if @file.save && @file.create_path
      redirect_to excel_files_path, notice: "Done"
    end
  end
  def file_params
    params.require(:excel_file).permit(:file)
  end
end
