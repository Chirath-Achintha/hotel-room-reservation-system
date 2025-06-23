<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Staff List</title>
    <style>
        body { font-family: Arial; background: #fffde7; padding: 20px; }
        table { width: 90%; margin: auto; border-collapse: collapse; background: #fff3cd; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #ffe082; }
        button { background-color: #ffa000; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .action-form { display: inline; }
    </style>
</head>
<body>
<h2 style="text-align:center;">Staff Members</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Department</th>
        <th>Contact</th>
        <th>Duties</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="staff" items="${staffMembers}">
        <tr>
            <td>${staff.staffId}</td>
            <td>${staff.name}</td>
            <td>${staff.email}</td>
            <td>${staff.role}</td>
            <td>${staff.department}</td>
            <td>${staff.contactNumber}</td>
            <td>${staff.duties}</td>
            <td>
                <form method="get" action="${pageContext.request.contextPath}/staff/edit/${staff.staffId}" class="action-form">
                    <button>Edit</button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/staff/deactivate/${staff.staffId}" class="action-form">
                    <button onclick="return confirm('Are you sure you want to deactivate this staff?')">Deactivate</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div style="text-align:center; margin-top:20px;">
    <a href="${pageContext.request.contextPath}/staff/register">
        <button>Add New Staff</button>
    </a>
</div>
</body>
</html>
