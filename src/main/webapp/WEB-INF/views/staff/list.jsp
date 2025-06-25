<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Staff List</title>
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
            animation: fadeInBg 1.2s ease;
        }
        @keyframes fadeInBg {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        h2 {
            text-align: center;
            color: #ffa000;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        table {
            width: 90%;
            margin: 40px auto;
            border-collapse: collapse;
            background: rgba(255,255,255,0.95);
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.10);
            overflow: hidden;
            animation: tableFadeIn 1s;
        }
        @keyframes tableFadeIn {
            from { opacity: 0; transform: scale(0.97); }
            to { opacity: 1; transform: scale(1); }
        }
        th, td {
            border: 1px solid #ccc;
            padding: 14px 18px;
            text-align: left;
        }
        th {
            background: linear-gradient(90deg, #ffa000 0%, #ffd200 100%);
            color: #fff;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
        }
        tr {
            transition: background 0.3s, transform 0.2s;
        }
        tr:hover {
            background: #ffe082;
            transform: scale(1.01);
        }
        button {
            background: linear-gradient(90deg, #ffa000 0%, #ffd200 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            padding: 8px 14px;
            margin-right: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        button:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
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
