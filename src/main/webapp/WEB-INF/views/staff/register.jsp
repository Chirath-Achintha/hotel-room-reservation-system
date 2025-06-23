<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register New Staff</title>
    <style>
        body { font-family: Arial; background: #fffde7; padding: 20px; }
        form { max-width: 500px; margin: auto; background: #fff3cd; padding: 20px; border-radius: 10px; }
        label { display: block; margin-top: 10px; }
        input, select { width: 100%; padding: 8px; margin-top: 5px; }
        button { background-color: #ffa000; color: white; padding: 10px; margin-top: 15px; border: none; cursor: pointer; }
    </style>
</head>
<body>
<h2 style="text-align:center;">Register New Staff</h2>

<form action="${pageContext.request.contextPath}/staff/register" method="post">
    <label>Name:</label>
    <input type="text" name="name" required />

    <label>Email:</label>
    <input type="email" name="email" required />

    <label>Position:</label>
    <select name="position" required>
        <option value="MANAGER">Manager</option>
        <option value="RECEPTIONIST">Receptionist</option>
        <option value="HOUSEKEEPING">Housekeeping</option>
        <option value="MAINTENANCE">Maintenance</option>
    </select>

    <label>Department:</label>
    <input type="text" name="department" required />

    <label>Contact Number:</label>
    <input type="text" name="contactNumber" required />

    <button type="submit">Register Staff</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red; text-align:center;">${error}</p>
</c:if>
</body>
</html>
