package org.avishek.aashayein.dao;

import org.avishek.aashayein.dto.EmployeeRoleAccessTO;

public interface EmployeeRoleAccessDao {

	Boolean addModulePermissions(Integer employeeRoleId, EmployeeRoleAccessTO employeeRoleAccessTO);

}
