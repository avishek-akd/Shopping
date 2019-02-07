<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@taglib prefix="jstlCore" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="springForm" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="jstlFormat" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@taglib prefix="jstlFn" uri="http://java.sun.com/jsp/jstl/functions"%> 


<jsp:include page="/header.jsp" />


<link rel="stylesheet" type="text/css" href="${contextRoot}/assets/css/jquery/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/assets/css/jqGrid/jqGrid-ui.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/assets/css/pNotify/pnotify-custom.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/assets/css/pNotify/animate.css">


<!-- Div for spinner loader -->
<div class="customSpinner-spinner customSpinner-spin customSpinner"></div>

<!-- Show InnerContent After Window Load -->
<div class="innerContent">

	<!-- Div for showing error -->
	<div class="notification-holder"></div>
	
	<div style="margin-bottom:.8em;">
		<a href='<jstlCore:url value="/EmployeeRegistration/showRegistration.abhi"/>' class="auto-button" data-icon="ui-icon-plusthick">Add Employee</a>
	</div>
	
	<div class="wrapper">
		<table id="tableGrid">
		<thead>
			<tr>
				<th class="alignCenter" data-placeholder="Search Sl.No">Sl No.</th>
				<th class="alignCenter" data-placeholder="Search RoleName">Role Name</th>
				<th class="alignCenter" data-placeholder="Search CreatedDate">CreatedDate</th>
				<th class="alignCenter" data-placeholder="Search UpdatedDate">UpdatedDate</th>
				<th class="alignCenter" data-placeholder="All">Archive</th>
				<th class="alignCenter">Action</th>
			</tr>
		</thead>
		<tbody>
			<jstlCore:choose>
				<jstlCore:when test="${jstlFn:length(employeeRoles) > 0}">
					<jstlCore:forEach items="${employeeRoles}" var="role" varStatus="loopStatus">
						<tr>
							<td class="alignCenter"><jstlCore:out value="${loopStatus.index+1}"/></td>
							<td class="alignCenter"><jstlCore:out value="${role.roleName}"/></td>
							<td class="alignCenter"><jstlFormat:formatDate value="${role.recordCreated}" pattern="MM-dd-yyyy" /></td>
							<jstlFormat:formatDate value="${role.recordUpdated}" pattern="MM-dd-yyyy" var="updatedDate" />
							<td class="alignCenter"><jstlCore:out value="${not empty updatedDate ? updatedDate : ''}"/></td>
							<td class="alignCenter"><jstlCore:out value="${role.archive eq 0 ? 'NO' : 'YES'}"/></td>
							<jstlCore:choose>
								<jstlCore:when test="${role.archive eq 0}">
									<td class="alignCenter">
										<a href='<jstlCore:url value="/EmployeeRole/showEditRole.abhi?roleId=${role.roleId}"/>' class="auto-button" data-icon="ui-icon-custom-edit" title="Edit Role">Edit</a>
										<a href='<jstlCore:url value="/EmployeeRole/deleteRole.abhi?roleId=${role.roleId}"/>' class="auto-button deleteRole" data-icon="ui-icon-custom-delete" title="Delete Role">Delete</a>
									</td>
								</jstlCore:when>
								<jstlCore:otherwise>
									<td class="alignCenter" colspan="2">
										<a href='<jstlCore:url value="/EmployeeRole/activeRole.abhi?roleId=${role.roleId}"/>' class="auto-button" data-icon="ui-icon-custom-tick" title="Active Role">Active</a>
									</td>
								</jstlCore:otherwise>
							</jstlCore:choose>
						</tr>
				  	</jstlCore:forEach>
				</jstlCore:when>
				<jstlCore:otherwise>
					<tr><td colspan="6" class="alignCenter error_message">No Employee Role Found</td></tr>
				</jstlCore:otherwise>
			</jstlCore:choose>
		</tbody>
		</table>
	</div>
	
	<!-- Dialog for delete role -->
	<div id="dialogDelete"></div>
</div>


<script type="text/javascript" src="${contextRoot}/assets/plugins/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="${contextRoot}/assets/plugins/jquery/jquery-ui-notification.js"></script>
<script type="text/javascript" src="${contextRoot}/assets/plugins/jqGrid/jqGrid.js"></script>
<script type="text/javascript" src="${contextRoot}/assets/plugins/pNotify/pnotify-custom.js"></script>
<script type="text/javascript">

var contextRoot = '${contextRoot}';

$(function() {

	// Display Success or Error message
	var message = '${message}';

	if (message != "") {
		new PNotify({
			type : '${jstlFn:toLowerCase(messageType)}', // type : 'Success' not correct so type : 'success'
			styling : "jqueryui",
			title : '${messageType}',
			text : message
		});
	}
})
</script>
<script type="text/javascript" src="${contextRoot}/assets/js/employee.js"></script>


<jsp:include page="/footer.jsp" />