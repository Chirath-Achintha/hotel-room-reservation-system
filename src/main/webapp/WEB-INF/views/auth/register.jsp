<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Reservation - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .auth-container {
            max-width: 500px;
            margin: 60px auto;
            padding: 36px 32px 28px 32px;
            border-radius: 18px;
            background: rgba(255,255,255,0.88);
            box-shadow: 0 8px 32px rgba(0,0,0,0.18);
            backdrop-filter: blur(6px);
            border: 1.5px solid rgba(255,255,255,0.25);
            animation: slideIn 1s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes slideIn {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .form-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-header h2 {
            color: #764ba2;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .form-label {
            color: #4a5568;
            font-weight: 500;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #b3c6e0;
            transition: border 0.3s, box-shadow 0.3s;
        }
        .form-control:focus {
            border-color: #a6c1ee;
            box-shadow: 0 0 0 2px #fbc2eb55;
        }
        .btn-primary {
            background: linear-gradient(90deg, #a6c1ee 0%, #fbc2eb 100%);
            border: none;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        .btn-primary:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .alert-danger {
            animation: fadeInAlert 0.7s;
        }
        @keyframes fadeInAlert {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
        .mt-3.text-center a {
            color: #764ba2;
            font-weight: 500;
            transition: color 0.2s;
        }
        .mt-3.text-center a:hover {
            color: #a6c1ee;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="auth-container">
        <div class="form-header">
            <h2>Create Account</h2>
            <p>Join our hotel reservation system</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Account Type</label>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="role" id="regularUser" value="REGULAR" checked>
                    <label class="form-check-label" for="regularUser">
                        Regular User
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="role" id="premiumUser" value="PREMIUM">
                    <label class="form-check-label" for="premiumUser">
                        Premium User
                    </label>
                </div>
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>

        <div class="mt-3 text-center">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login here</a></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>