<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register New Staff</title>
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
        form {
            max-width: 500px;
            margin: 40px auto;
            background: rgba(255,255,255,0.95);
            padding: 32px 28px 24px 28px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.13);
            animation: slideIn 1s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes slideIn {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        h2 {
            text-align: center;
            color: #ffa000;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        label {
            color: #4a5568;
            font-weight: 500;
            display: block;
            margin-top: 10px;
        }
        input, select {
            border-radius: 8px;
            border: 1px solid #b3c6e0;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 14px;
            width: 100%;
            transition: border 0.3s, box-shadow 0.3s;
        }
        input:focus, select:focus {
            border-color: #ffa000;
            box-shadow: 0 0 0 2px #ffa00055;
        }
        button {
            background: linear-gradient(90deg, #ffa000 0%, #ffd200 100%);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
            margin-top: 15px;
        }
        button:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .error {
            color: #e74c3c;
            margin-top: 10px;
            text-align: center;
            animation: fadeInAlert 0.7s;
        }
        @keyframes fadeInAlert {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
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
