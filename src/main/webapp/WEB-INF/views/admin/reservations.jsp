<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

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