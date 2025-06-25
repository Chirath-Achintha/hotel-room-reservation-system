<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Booking</title>
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
            animation: fadeInBg 1.2s ease;
        }
        @keyframes fadeInBg {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .booking-container {
            max-width: 500px;
            margin: 60px auto;
            padding: 36px 32px 28px 32px;
            border-radius: 18px;
            background: rgba(255,255,255,0.92);
            box-shadow: 0 8px 32px rgba(0,0,0,0.13);
            backdrop-filter: blur(6px);
            border: 1.5px solid rgba(255,255,255,0.25);
            animation: slideIn 1s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes slideIn {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        h1 {
            text-align: center;
            color: #3498db;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        .form-group label {
            color: #4a5568;
            font-weight: 500;
        }
        input, select, textarea {
            border-radius: 8px;
            border: 1px solid #b3c6e0;
            transition: border 0.3s, box-shadow 0.3s;
        }
        input:focus, select:focus, textarea:focus {
            border-color: #a1c4fd;
            box-shadow: 0 0 0 2px #a1c4fd55;
        }
        .btn {
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        .btn-save {
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            border: none;
        }
        .btn-save:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .btn-cancel {
            background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
            color: #fff;
            border: none;
        }
        .btn-cancel:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .error {
            color: #e74c3c;
            margin-bottom: 10px;
            animation: fadeInAlert 0.7s;
        }
        @keyframes fadeInAlert {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>
    <h1>Edit Booking</h1>
    
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/booking/update" method="post">
        <input type="hidden" name="bookingId" value="${booking.bookingId}">
        <input type="hidden" name="roomId" value="${booking.roomId}">
        <input type="hidden" name="status" value="${booking.status}">
        <input type="hidden" name="username" value="${booking.username}">
        <div class="form-group">
            <label>Room:</label>
            <input type="text" value="Room ${booking.roomId}" readonly>
        </div>
        <div class="form-group">
            <label for="checkInDate">Check-in Date:</label>
            <input type="date" name="checkInDate" id="checkInDate" value="${booking.checkInDate}" required>
        </div>
        <div class="form-group">
            <label for="checkOutDate">Check-out Date:</label>
            <input type="date" name="checkOutDate" id="checkOutDate" value="${booking.checkOutDate}" required>
        </div>
        <div class="form-group">
            <label for="specialRequests">Special Requests:</label>
            <textarea name="specialRequests" id="specialRequests" rows="4">${booking.specialRequests}</textarea>
        </div>
        <button type="submit" class="btn btn-save">Save Changes</button>
        <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-cancel">Cancel</a>
    </form>
    <script>
        // Ensure check-out is after check-in
        document.getElementById('checkInDate').addEventListener('change', function() {
            document.getElementById('checkOutDate').min = this.value;
        });
    </script>
</body>
</html> 