<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
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
        h1 {
            text-align: center;
            color: #3498db;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
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
            background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
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
        .status-confirmed { color: #43cea2; font-weight: bold; }
        .status-cancelled { color: #ff5858; font-weight: bold; }
        .status-pending { color: #f09819; font-weight: bold; }
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
