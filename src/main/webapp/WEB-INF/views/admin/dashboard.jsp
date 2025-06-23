<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --success-color: #2ecc71;
        --info-color: #1abc9c;
        --warning-color: #f39c12;
        --danger-color: #e74c3c;
        --admin-color: #9b59b6;
    }

    .admin-dashboard {
        animation: fadeIn 0.6s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .dashboard-title {
        position: relative;
        padding-bottom: 15px;
        margin-bottom: 2rem;
    }

    .dashboard-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 80px;
        height: 4px;
        background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
        border-radius: 2px;
        animation: titleUnderline 1s ease-out;
    }

    @keyframes titleUnderline {
        from { width: 0; }
        to { width: 80px; }
    }

    .admin-card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
        margin-bottom: 1.5rem;
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(5px);
    }

    .admin-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }

    .stats-card {
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.3s ease;
        position: relative;
        color: white;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .stats-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }

    .stats-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255,255,255,0.1), transparent);
    }

    .stats-card.bg-primary {
        background: linear-gradient(135deg, var(--primary-color), #34495e) !important;
    }

    .stats-card.bg-success {
        background: linear-gradient(135deg, var(--success-color), #27ae60) !important;
    }

    .stats-card.bg-info {
        background: linear-gradient(135deg, var(--info-color), #16a085) !important;
    }

    .stats-card.bg-warning {
        background: linear-gradient(135deg, var(--warning-color), #e67e22) !important;
    }

    .stats-card.bg-danger {
        background: linear-gradient(135deg, var(--danger-color), #c0392b) !important;
    }

    .card-header {
        border-radius: 12px 12px 0 0 !important;
        position: relative;
        overflow: hidden;
    }

    .card-header::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, rgba(255,255,255,0.3), transparent);
        animation: shimmer 2s infinite linear;
    }

    @keyframes shimmer {
        0% { transform: translateX(-100%); }
        100% { transform: translateX(100%); }
    }

    .btn {
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        border: none;
        font-weight: 500;
        letter-spacing: 0.5px;
        padding: 0.75rem 1.5rem;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .btn::after {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: all 0.6s ease;
    }

    .btn:hover::after {
        left: 100%;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--secondary-color), #2980b9);
    }

    .btn-success {
        background: linear-gradient(135deg, var(--success-color), #27ae60);
    }

    .btn-info {
        background: linear-gradient(135deg, var(--info-color), #16a085);
    }

    .btn-warning {
        background: linear-gradient(135deg, var(--warning-color), #e67e22);
    }

    .btn-danger {
        background: linear-gradient(135deg, var(--danger-color), #c0392b);
    }

    .btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }

    .admin-info-card {
        background: linear-gradient(135deg, rgba(155, 89, 182, 0.1), rgba(155, 89, 182, 0.05));
        border-left: 4px solid var(--admin-color);
        border-radius: 8px;
    }

    .stat-number {
        font-size: 2.5rem;
        font-weight: 700;
        text-shadow: 0 2px 5px rgba(0,0,0,0.2);
        transition: all 0.3s ease;
    }

    .stats-card:hover .stat-number {
        transform: scale(1.05);
    }

    .management-card {
        transition: all 0.3s ease;
    }

    .management-card:hover {
        transform: translateY(-5px) scale(1.02);
    }
</style>

<div class="container mt-5 admin-dashboard">
    <div class="row">
        <div class="col-12">
            <h2 class="mb-4 dashboard-title"><i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard</h2>

            <!-- Admin Info -->
            <div class="card mb-4 admin-info-card">
                <div class="card-body">
                    <h5 class="card-title"><i class="fas fa-user-shield me-2"></i>Welcome, ${user.username}</h5>
                    <p class="card-text"><i class="fas fa-star me-2"></i>Admin Level: ${user.adminLevel}</p>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="stats-card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-users me-2"></i>Total Users</h5>
                            <p class="card-text stat-number">${userCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-user-tie me-2"></i>Active Staff</h5>
                            <p class="card-text stat-number">${staffCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card bg-info text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-calendar-check me-2"></i>Active Bookings</h5>
                            <p class="card-text stat-number">${bookingCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Management Links -->
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card admin-card management-card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="fas fa-user-cog me-2"></i>User Management</h5>
                        </div>
                        <div class="card-body">
                            <p><i class="fas fa-info-circle me-2"></i>Manage user accounts and permissions</p>
                            <a href="${pageContext.request.contextPath}/user/list" class="btn btn-primary">
                                <i class="fas fa-users-cog me-2"></i>Manage Users
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card admin-card management-card">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0"><i class="fas fa-user-tie me-2"></i>Staff Management</h5>
                        </div>
                        <div class="card-body">
                            <p><i class="fas fa-info-circle me-2"></i>Manage hotel staff members</p>
                            <a href="${pageContext.request.contextPath}/staff/list" class="btn btn-success">
                                <i class="fas fa-clipboard-list me-2"></i>Manage Staff
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card admin-card management-card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0"><i class="fas fa-bed me-2"></i>Room Management</h5>
                        </div>
                        <div class="card-body">
                            <p><i class="fas fa-info-circle me-2"></i>Manage hotel rooms and availability</p>
                            <a href="${pageContext.request.contextPath}/room/manage" class="btn btn-info">
                                <i class="fas fa-edit me-2"></i>Manage Rooms
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card admin-card management-card">
                        <div class="card-header bg-warning text-white">
                            <h5 class="mb-0"><i class="fas fa-calendar-alt me-2"></i>Booking Management</h5>
                        </div>
                        <div class="card-body">
                            <p><i class="fas fa-info-circle me-2"></i>Manage reservations and bookings</p>
                            <a href="${pageContext.request.contextPath}/booking/manage" class="btn btn-warning">
                                <i class="fas fa-tasks me-2"></i>Manage Bookings
                            </a>
                        </div>
                    </div>
                </div>
                <!-- New card for sorted reservations -->
                <div class="col-md-6 mb-4">
                    <div class="card admin-card management-card">
                        <div class="card-header bg-danger text-white">
                            <h5 class="mb-0"><i class="fas fa-list-ol me-2"></i>All Reservations (Sorted)</h5>
                        </div>
                        <div class="card-body">
                            <p><i class="fas fa-info-circle me-2"></i>View all reservations sorted by check-in date</p>
                            <a href="${pageContext.request.contextPath}/admin/reservations" class="btn btn-danger">
                                <i class="fas fa-sort-amount-down me-2"></i>View Reservations
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate cards on load
        const animateCards = function() {
            const cards = document.querySelectorAll('.admin-card, .stats-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = `all 0.5s ease ${index * 0.1}s`;

                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100);
            });
        };

        animateCards();

        // Button hover effects
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
            });
            button.addEventListener('mouseleave', function() {
                if (!this.classList.contains('active')) {
                    this.style.transform = 'translateY(0)';
                }
            });
        });

        // Stats card hover effects
        const statsCards = document.querySelectorAll('.stats-card');
        statsCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.querySelector('.stat-number').style.transform = 'scale(1.05)';
            });
            card.addEventListener('mouseleave', function() {
                this.querySelector('.stat-number').style.transform = 'scale(1)';
            });
        });
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>