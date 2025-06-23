<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book a Room</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input, select, textarea { width: 100%; padding: 8px; margin-bottom: 10px; }
        .btn { padding: 10px 20px; background: #4CAF50; color: white; border: none; cursor: pointer; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <h1>Book a Room</h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/booking/create" method="post">
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
            <input type="date" name="checkInDate" id="checkInDate" required
                   min="${pageContext.request.contextPath}/booking/today">
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