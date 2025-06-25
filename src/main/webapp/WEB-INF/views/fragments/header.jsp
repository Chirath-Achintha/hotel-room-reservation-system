<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Reservation System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .navbar {
            background: linear-gradient(90deg, #2c3e50 0%, #3498db 100%) !important;
            box-shadow: 0 2px 8px rgba(44,62,80,0.08);
            border-radius: 0 0 18px 18px;
            animation: navFadeIn 1s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes navFadeIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 1px;
            color: #fff !important;
            text-shadow: 0 2px 8px rgba(44,62,80,0.08);
        }
        .nav-link {
            color: #fff !important;
            font-weight: 500;
            margin-right: 8px;
            transition: color 0.2s, transform 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            color: #fbc2eb !important;
            transform: scale(1.08);
            text-decoration: underline;
        }
        main.container {
            margin-top: 2rem;
            animation: fadeInMain 1.2s;
        }
        @keyframes fadeInMain {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">Room Reservation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/room/catalog">Rooms</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/booking/list">Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/review/list">Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/feedback">Feedback</a>
                    </li>
                    <c:if test="${sessionScope.user['class'].simpleName == 'AdminUser'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-4">
        <!-- Your page content will go here -->
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
