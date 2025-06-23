<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .btn { padding: 5px 10px; text-decoration: none; color: white; border-radius: 3px; }
        .btn-add { background: #4CAF50; margin-bottom: 15px; display: inline-block; padding: 8px 15px; }
        .btn-edit { background: #2196F3; }
        .btn-delete { background: #f44336; }
    </style>
</head>
<body>
<h1>Book List</h1>
<a href="${pageContext.request.contextPath}/room/catalog" class="btn btn-add">Add New Book</a>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Room</th>
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
            <td>${booking.roomId}</td>
            <td>${booking.checkInDate}</td>
            <td>${booking.checkOutDate}</td>
            <td>$${booking.totalPrice}</td>
            <td>${booking.status}</td>
            <td>
                <a href="${pageContext.request.contextPath}/booking/edit/${booking.bookingId}" class="btn btn-edit">Edit</a>
                <form action="${pageContext.request.contextPath}/booking/cancel/${booking.bookingId}" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-cancel" onclick="return confirm('Are you sure you want to cancel this booking?')">Cancel</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>