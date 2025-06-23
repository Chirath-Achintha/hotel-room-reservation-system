<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .btn { padding: 5px 10px; text-decoration: none; color: white; border-radius: 3px; }
        .btn-edit { background: #2196F3; }
        .btn-cancel { background: #f44336; }
        .status-confirmed { color: green; }
        .status-cancelled { color: red; }
        .status-pending { color: orange; }
    </style>
</head>
<body>
    <h1>Manage Bookings</h1>

    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Room</th>
                <th>User</th>
                <th>Check-in</th>
                <th>Check-out</th>
                <th>Price</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="booking" items="${bookings}">
                <tr>
                    <td>${booking.bookingId}</td>
                    <td>Room ${booking.roomId}</td>
                    <td>User ${booking.username}</td>
                    <td>${booking.checkInDate}</td>
                    <td>${booking.checkOutDate}</td>
                    <td>$${booking.totalPrice}</td>
                    <td class="status-${booking.status.toLowerCase()}">${booking.status}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/booking/cancel/${booking.bookingId}" 
                              method="post" style="display:inline;">
                            <button type="submit" class="btn btn-cancel" 
                                    onclick="return confirm('Are you sure you want to cancel this booking?')">
                                Cancel
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
