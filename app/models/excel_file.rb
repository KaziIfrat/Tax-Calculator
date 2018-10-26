class ExcelFile < ApplicationRecord
  require 'roo'
  has_one_attached :file
  has_many :employees

  def no_of_employees
    path=create_path
    xlsx = Roo::Spreadsheet.open(path, extension: :xlsx)
    name=xlsx.column('A')[14..18].count
  end


  def employee_basics(i)
    xlsx = Roo::Spreadsheet.open(create_path, extension: :xlsx)
    name=xlsx.column('A')[14..18][i-1]
    fest_bonus=xlsx.column('BP')[14..18][i-1]
    pf=xlsx.column('BS')[14..18][i-1]
    total_income= xlsx.column('BT')[14..18][i-1]
    transport= 3000
    emp= Employee.new
    emp.name=name
    emp.pf=pf
    emp.fest_bonus=fest_bonus
    emp.transport=transport
    emp.total_income=total_income
    c=  emp.pf + emp.transport + emp.fest_bonus
    n= emp.total_income
    return emp.name, emp.pf, emp.fest_bonus,emp.transport, emp.total_income, binary_search(n,c)
  end


    def binary_search(n,c)
    low=0
    high=n
    basic=0
    while low <= high
      basic= (low + high) / 2
      g=basic + [300000,basic/2].min + [120000,basic/10].min + c
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

  def create_path
    path
  end

  private

  def path
    ActiveStorage::Blob.service.send(:path_for, file.key)
  end
end
