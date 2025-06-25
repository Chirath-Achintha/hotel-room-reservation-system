<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
        font-family: 'Segoe UI', Arial, sans-serif;
        animation: fadeInBg 1.5s ease;
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
    .card {
        box-shadow: 0 8px 24px rgba(0,0,0,0.08), 0 1.5px 4px rgba(0,0,0,0.06);
        border-radius: 18px;
        transition: transform 0.3s cubic-bezier(.68,-0.55,.27,1.55), box-shadow 0.3s;
        background: #fff;
        margin-bottom: 24px;
        opacity: 0;
        animation: cardFadeIn 0.8s forwards;
    }
    .card:hover {
        transform: scale(1.03) translateY(-4px);
        box-shadow: 0 16px 32px rgba(0,0,0,0.12), 0 3px 8px rgba(0,0,0,0.10);
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.1rem;
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
    h2, h5 {
        color: #2d3a4b;
        letter-spacing: 0.5px;
    }
    .row > [class^='col-'] {
        animation: fadeInUp 0.7s both;
    }
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4">Admin Dashboard</h2>
            
            <!-- Admin Info -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Welcome, ${user.username}</h5>
                    <p class="card-text">Admin Level: ${user.adminLevel}</p>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title">Total Users</h5>
                            <p class="card-text h2">${userCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title">Active Staff</h5>
                            <p class="card-text h2">${staffCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <h5 class="card-title">Active Bookings</h5>
                            <p class="card-text h2">${bookingCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Management Links -->
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">User Management</h5>
                        </div>
                        <div class="card-body">
                            <p>Manage user accounts and permissions</p>
                            <a href="${pageContext.request.contextPath}/user/list" class="btn btn-primary">Manage Users</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">Staff Management</h5>
                        </div>
                        <div class="card-body">
                            <p>Manage hotel staff members</p>
                            <a href="${pageContext.request.contextPath}/staff/list" class="btn btn-success">Manage Staff</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Room Management</h5>
                        </div>
                        <div class="card-body">
                            <p>Manage hotel rooms and availability</p>
                            <a href="${pageContext.request.contextPath}/room/manage" class="btn btn-info">Manage Rooms</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header bg-warning">
                            <h5 class="mb-0">Booking Management</h5>
                        </div>
                        <div class="card-body">
                            <p>Manage reservations and bookings</p>
                            <a href="${pageContext.request.contextPath}/booking/manage" class="btn btn-warning">Manage Bookings</a>
                        </div>
                    </div>
                </div>
                <!-- New card for sorted reservations -->
                <div class="col-md-6 mb-4">
                    <div class="card">
                        <div class="card-header bg-danger text-white">
                            <h5 class="mb-0">All Reservations (Sorted)</h5>
                        </div>
                        <div class="card-body">
                            <p>View all reservations sorted by check-in date</p>
                            <a href="${pageContext.request.contextPath}/admin/reservations" class="btn btn-danger">View Reservations</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/> 