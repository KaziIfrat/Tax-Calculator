class ExcelFile < ApplicationRecord
  require 'roo'
  has_one_attached :file
  has_many :employees

  def no_of_employees
    path=create_path
    xlsx = Roo::Spreadsheet.open(path, extension: :xlsx)
    name=xlsx.column('A')[14..18].count
  end




  def show_employee_names
    xlsx = Roo::Spreadsheet.open(create_path, extension: :xlsx)
    no_of_employees = xlsx.column('A')[14..18].count
    name=xlsx.column('A')[14..18]
    fest_bonus=xlsx.column('BP')[14..18]
    pf=xlsx.column('BS')[14..18]
    total_income= xlsx.column('BT')[14..18]
    transport= 3000

    for i in 1..no_of_employees do
    emp= Employee.new
    emp.name=name[i-1]
    emp.pf=pf[i-1]
    emp.fest_bonus=fest_bonus[i-1]
    emp.transport=transport
    emp.total_income=total_income[i-1]
    c=  emp.pf[i-1] + emp.transport + emp.fest_bonus[i-1]
    n= emp.total_income[i-1]
    binary_search(n,c)
    end

    end


    def binary_search(n,c)
    low=0
    high=n
    basic=0
    while low <= high
      basic= (low + high) / 2
      g=basic+ [300000,basic/2].min + [120000,basic/10].min + c
      if g == n
        break
      elsif g > n
        high=basic-1
      else
        low = basic+1
      end
    end
    basic
    end



  def show_employee_festbonus
    xlsx = Roo::Spreadsheet.open(create_path, extension: :xlsx)
    names= xlsx.column('BP')[14..18]
  end
  def show_employee_pfs
    xlsx = Roo::Spreadsheet.open(create_path, extension: :xlsx)
    names= xlsx.column('BS')[14..18]
  end

  def show_employee_total_incomes
    xlsx = Roo::Spreadsheet.open(create_path, extension: :xlsx)
    names= xlsx.column('BT')[14..18]
  end
  def create_path
    path
  end

  private

  def path
    ActiveStorage::Blob.service.send(:path_for, file.key)
  end
end
