module EmployeesHelper
  def is_trainee(employee)
    if employee.trainee?
      "Yes"
    else
      "No"
    end
  end
end
