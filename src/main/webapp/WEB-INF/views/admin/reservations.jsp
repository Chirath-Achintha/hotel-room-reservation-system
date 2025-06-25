<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        background: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
        font-family: 'Segoe UI', Arial, sans-serif;
        animation: fadeInBg 1.2s ease;
    }
    @keyframes fadeInBg {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    .container {
        animation: slideIn 1s cubic-bezier(.68,-0.55,.27,1.55);
    }
    @keyframes slideIn {
        from { transform: translateY(40px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }
    table {
        background: #fff;
        border-radius: 14px;
        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        overflow: hidden;
        animation: tableFadeIn 1s;
    }
    @keyframes tableFadeIn {
        from { opacity: 0; transform: scale(0.97); }
        to { opacity: 1; transform: scale(1); }
    }
    th, td {
        padding: 14px 18px;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background: linear-gradient(90deg, #f6d365 0%, #fda085 100%);
        color: #fff;
        font-weight: 600;
        letter-spacing: 0.5px;
        border: none;
    }
    tr {
        transition: background 0.3s, transform 0.2s;
    }
    tr:hover {
        background: #fceabb;
        transform: scale(1.01);
    }
    .btn {
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        border-radius: 8px;
        font-weight: 500;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }
    .btn:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    h2 {
        color: #b3541e;
        letter-spacing: 0.5px;
    }
</style>

<div class="container mt-5">
    <h2 class="mb-4">All Bookings (Sorted by Check-in Date)</h2>
    <c:if test="${empty bookings}">
        <div class="alert alert-info">No bookings found.</div>
    </c:if>
    <c:if test="${not empty bookings}">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Username</th>
                    <th>Room ID</th>
                    <th>Check-in Date</th>
                    <th>Check-out Date</th>
                    <th>Status</th>
                    <th>Total Price</th>
                    <th>Special Requests</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookings}">
                    <tr>
                        <td>${booking.bookingId}</td>
                        <td>${booking.username}</td>
                        <td>${booking.roomId}</td>
                        <td>${booking.checkInDate}</td>
                        <td>${booking.checkOutDate}</td>
                        <td>${booking.status}</td>
                        <td>$${booking.totalPrice}</td>
                        <td>${booking.specialRequests}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<jsp:include page="../fragments/footer.jsp"/> 