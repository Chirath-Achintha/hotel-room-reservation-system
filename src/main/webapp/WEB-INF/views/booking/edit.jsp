<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Booking</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input, select, textarea { width: 100%; padding: 8px; margin-bottom: 10px; }
        .btn { padding: 10px 20px; color: white; border: none; cursor: pointer; }
        .btn-save { background: #4CAF50; }
        .btn-cancel { background: #f44336; }
        .error { color: red; margin-bottom: 10px; }
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