<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
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
        h1 {
            text-align: center;
            color: #764ba2;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        .btn-add {
            background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
            margin-bottom: 15px;
            display: inline-block;
            padding: 8px 15px;
        }
        .btn-add:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.95);
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.10);
            overflow: hidden;
            animation: tableFadeIn 1s;
        }
        @keyframes tableFadeIn {
            from { opacity: 0; transform: scale(0.97); }
            to { opacity: 1; transform: scale(1); }
        }
        th, td {
            border: 1px solid #ddd;
            padding: 14px 18px;
            text-align: left;
        }
        th {
            background: linear-gradient(90deg, #fbc2eb 0%, #a6c1ee 100%);
            color: #fff;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
        }
        tr {
            transition: background 0.3s, transform 0.2s;
        }
        tr:hover {
            background: #e0c3fc;
            transform: scale(1.01);
        }
        .btn-edit {
            background: linear-gradient(90deg, #66a6ff 0%, #89f7fe 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        .btn-edit:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .btn-cancel {
            background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        .btn-cancel:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
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