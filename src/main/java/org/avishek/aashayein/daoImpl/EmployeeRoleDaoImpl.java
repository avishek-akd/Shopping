package org.avishek.aashayein.daoImpl;

import java.util.ArrayList;
import java.util.List;

import org.avishek.aashayein.dao.EmployeeRoleDao;
import org.avishek.aashayein.dto.EmployeeRoleTO;
import org.avishek.aashayein.entities.EmployeeRole;
import org.avishek.aashayein.utility.CurrentDateTime;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmployeeRoleDaoImpl implements EmployeeRoleDao {

	@Autowired
	SessionFactory sessionFactory;

	@Autowired
	CurrentDateTime currentDateTime;

	@Override
	public Integer addEmployeeRole(EmployeeRoleTO employeeRoleTO) {

		EmployeeRole employeeRole = new EmployeeRole();
		employeeRole.setRoleName(employeeRoleTO.getRoleName());
		employeeRole.setArchive((byte) 0);
		employeeRole.setRecordCreated(currentDateTime.getCurrentDateTime());

		sessionFactory.getCurrentSession().save(employeeRole);

		return employeeRole.getRoleId();
	}

	@Override
	public List<EmployeeRoleTO> getAllRoles() {

		List<EmployeeRoleTO> employeeRoles = null;

		String hql = "FROM EmployeeRole ORDER BY RoleId DESC";
		Query<EmployeeRole> query = sessionFactory.getCurrentSession().createQuery(hql, EmployeeRole.class);
		List<EmployeeRole> roles = query.list();

		if (!roles.isEmpty()) {
			employeeRoles = new ArrayList<EmployeeRoleTO>();

			for (EmployeeRole role : roles) {
				EmployeeRoleTO employeeRoleTO = new EmployeeRoleTO();

				employeeRoleTO.setRoleId(role.getRoleId());
				employeeRoleTO.setRoleName(role.getRoleName());
				employeeRoleTO.setArchive(role.getArchive());
				employeeRoleTO.setRecordCreated(role.getRecordCreated());
				employeeRoleTO.setRecordUpdated(role.getRecordUpdated());

				employeeRoles.add(employeeRoleTO);

			}

		}

		return employeeRoles;
	}

}
