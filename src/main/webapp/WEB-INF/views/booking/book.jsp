<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Room</title>
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            animation: fadeInBg 1.2s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes fadeInBg {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .booking-container {
            width: 100%;
            max-width: 600px;
            margin: 40px auto;
            padding: 48px 40px 36px 40px;
            border-radius: 32px;
            background: rgba(255,255,255,0.97);
            box-shadow: 0 12px 40px 0 rgba(120, 80, 180, 0.18), 0 1.5px 8px 0 rgba(0,0,0,0.07);
            backdrop-filter: blur(8px);
            border: 2.5px solid rgba(255,255,255,0.35);
            animation: slideIn 1.2s cubic-bezier(.68,-0.55,.27,1.55);
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        @keyframes slideIn {
            from { transform: translateY(60px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }
        h1 {
            text-align: center;
            color: #764ba2;
            font-size: 2.8rem;
            font-weight: 800;
            letter-spacing: 1.5px;
            margin-bottom: 36px;
            text-shadow: 0 2px 12px #a6c1ee55;
        }
        .form-group {
            width: 100%;
            margin-bottom: 28px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }
        .form-group label {
            color: #4a5568;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 8px;
        }
        select, input[type="date"], textarea {
            width: 100%;
            font-size: 1.15rem;
            padding: 14px 16px;
            border-radius: 12px;
            border: 1.5px solid #b3c6e0;
            transition: border 0.3s, box-shadow 0.3s;
            margin-bottom: 2px;
            background: #f7f8fa;
        }
        select:focus, input[type="date"]:focus, textarea:focus {
            border-color: #a6c1ee;
            box-shadow: 0 0 0 3px #fbc2eb55;
            outline: none;
        }
        textarea {
            min-height: 70px;
            resize: vertical;
        }
        .btn {
            width: 100%;
            font-size: 1.35rem;
            padding: 16px 0;
            background: linear-gradient(90deg, #a6c1ee 0%, #fbc2eb 100%);
            color: #fff;
            border: none;
            border-radius: 14px;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 4px 18px rgba(120, 80, 180, 0.13);
            transition: background 0.4s, color 0.3s, box-shadow 0.3s, transform 0.2s;
            margin-top: 18px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .btn::after {
            content: '';
            position: absolute;
            left: -75%;
            top: 0;
            width: 50%;
            height: 100%;
            background: linear-gradient(120deg, #fff6 0%, #fff0 100%);
            transform: skewX(-20deg);
            transition: left 0.5s cubic-bezier(.68,-0.55,.27,1.55);
        }
        .btn:hover::after {
            left: 120%;
        }
        .btn:hover {
            filter: brightness(1.08);
            transform: scale(1.04);
            box-shadow: 0 8px 32px rgba(120, 80, 180, 0.18);
        }
        .error {
            color: #e74c3c;
            margin-bottom: 18px;
            font-size: 1.15rem;
            font-weight: 600;
            animation: fadeInAlert 0.7s;
        }
        @keyframes fadeInAlert {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: 1; }
        }
        @media (max-width: 700px) {
            .booking-container {
                padding: 24px 8px 18px 8px;
                max-width: 98vw;
            }
            h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="booking-container">
        <h1>Book a Room</h1>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/booking/create" method="post" style="width:100%;">
            <div class="form-group">
                <label for="roomId">Select Room:</label>
                <select name="roomId" id="roomId" required>
                    <c:forEach var="room" items="${rooms}">
                        <option value="${room.roomId}" ${room.roomId == preselectedRoomId ? 'selected' : ''}>
                            ${room.roomNumber} - ${room.getRoomType()} ($${room.price}/night)
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="checkInDate">Check-in Date:</label>
                <input type="date" name="checkInDate" id="checkInDate" required>
            </div>
            <div class="form-group">
                <label for="checkOutDate">Check-out Date:</label>
                <input type="date" name="checkOutDate" id="checkOutDate" required>
            </div>
            <div class="form-group">
                <label for="specialRequests">Special Requests:</label>
                <textarea name="specialRequests" id="specialRequests" rows="4"></textarea>
            </div>
            <button type="submit" class="btn">Book Now</button>
        </form>
    </div>
    <script>
        // Set minimum date for check-in to today
        document.getElementById('checkInDate').min = new Date().toISOString().split('T')[0];
        // Ensure check-out is after check-in
        document.getElementById('checkInDate').addEventListener('change', function() {
            document.getElementById('checkOutDate').min = this.value;
        });
    </script>
</body>
</html>