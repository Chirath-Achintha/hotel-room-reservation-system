<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --premium-color: #f39c12;
        --admin-color: #9b59b6;
    }

    .profile-container {
        animation: fadeIn 0.8s ease-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .profile-card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(5px);
    }

    .profile-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary-color), #34495e) !important;
        position: relative;
        overflow: hidden;
        border-radius: 12px 12px 0 0 !important;
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

    .card-header h3 {
        position: relative;
        padding-bottom: 10px;
    }

    .card-header h3::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 3px;
        background: rgba(255,255,255,0.5);
        border-radius: 2px;
    }

    .profile-detail-row {
        padding: 1rem 0;
        border-bottom: 1px solid rgba(0,0,0,0.05);
        transition: all 0.3s ease;
    }

    .profile-detail-row:hover {
        background: rgba(52, 152, 219, 0.05);
        transform: translateX(5px);
    }

    .profile-detail-row:last-child {
        border-bottom: none;
    }

    .badge {
        font-weight: 500;
        padding: 0.5em 0.8em;
        border-radius: 50rem;
        transition: all 0.3s ease;
    }

    .badge.bg-success {
        background: linear-gradient(135deg, #2ecc71, #27ae60) !important;
    }

    .badge.bg-secondary {
        background: linear-gradient(135deg, #95a5a6, #7f8c8d) !important;
    }

    .premium-features {
        background: rgba(243, 156, 18, 0.1);
        border-left: 3px solid var(--premium-color);
        padding: 1rem;
        border-radius: 0 8px 8px 0;
        margin-top: 1rem;
    }

    .admin-features {
        background: rgba(155, 89, 182, 0.1);
        border-left: 3px solid var(--admin-color);
        padding: 1rem;
        border-radius: 0 8px 8px 0;
        margin-top: 1rem;
    }

    .btn {
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        border: none;
        font-weight: 500;
        letter-spacing: 0.5px;
        padding: 0.75rem 1.5rem;
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
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    }

    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
    }

    .btn-danger {
        background: linear-gradient(135deg, var(--accent-color), #c0392b);
        box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
    }

    .btn-danger:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(231, 76, 60, 0.4);
    }

    .bookings-btn {
        display: inline-block;
        padding: 1rem 2rem;
        border-radius: 50rem;
        font-weight: 600;
        background: linear-gradient(135deg, #1abc9c, #16a085);
        color: white;
        text-decoration: none;
        box-shadow: 0 4px 15px rgba(26, 188, 156, 0.3);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .bookings-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(26, 188, 156, 0.4);
        color: white;
    }

    .bookings-btn::after {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: all 0.6s ease;
    }

    .bookings-btn:hover::after {
        left: 100%;
    }

    .card-footer {
        background: rgba(0,0,0,0.03);
        border-top: 1px solid rgba(0,0,0,0.05);
    }
</style>

<div class="container mt-5 profile-container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card profile-card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0"><i class="fas fa-user-circle me-2"></i>User Profile</h3>
                </div>
                <div class="card-body">
                    <div class="row profile-detail-row align-items-center">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-user me-2"></i>Username:</strong>
                        </div>
                        <div class="col-sm-8">
                            ${user.username}
                        </div>
                    </div>
                    <div class="row profile-detail-row align-items-center">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-envelope me-2"></i>Email:</strong>
                        </div>
                        <div class="col-sm-8">
                            ${user.email}
                        </div>
                    </div>
                    <div class="row profile-detail-row">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-user-tag me-2"></i>Account Type:</strong>
                        </div>
                        <div class="col-sm-8">
                            <c:choose>
                                <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                    <span class="badge" style="background: linear-gradient(135deg, var(--admin-color), #8e44ad)">Administrator</span>
                                    <div class="admin-features mt-3">
                                        <strong><i class="fas fa-shield-alt me-2"></i>Admin Level:</strong> ${user.adminLevel}
                                    </div>
                                </c:when>
                                <c:when test="${user['class'].simpleName == 'PremiumUser'}">
                                    <span class="badge" style="background: linear-gradient(135deg, var(--premium-color), #e67e22)">Premium User</span>
                                    <div class="premium-features mt-3">
                                        <p><strong><i class="fas fa-calendar-star me-2"></i>Premium Since:</strong> ${user.premiumStartDate}</p>
                                        <p><strong><i class="fas fa-gift me-2"></i>Benefits:</strong> ${user.premiumBenefits}</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    Regular User
                                    <div class="mt-2">
                                        <strong>Premium Status:</strong>
                                        <c:choose>
                                            <c:when test="${user.premium}">
                                                <span class="badge bg-success">Premium</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Standard</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="d-flex justify-content-between flex-wrap">
                        <a href="${pageContext.request.contextPath}/user/edit/${user.id}" class="btn btn-primary mb-2">
                            <i class="fas fa-edit me-2"></i>Edit Profile
                        </a>
                        <c:if test="${user['class'].simpleName != 'AdminUser'}">
                            <form action="${pageContext.request.contextPath}/user/delete/${user.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
                                <button type="submit" class="btn btn-danger mb-2">
                                    <i class="fas fa-trash-alt me-2"></i>Delete Account
                                </button>
                            </form>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger mb-2">
                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                        </a>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/booking/list" class="bookings-btn">
                    <i class="fas fa-calendar-check me-2"></i>My Bookings
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add animation to profile details
        const details = document.querySelectorAll('.profile-detail-row');
        details.forEach((detail, index) => {
            detail.style.opacity = '0';
            detail.style.transform = 'translateX(-20px)';
            detail.style.transition = `all 0.5s ease ${index * 0.1}s`;

            setTimeout(() => {
                detail.style.opacity = '1';
                detail.style.transform = 'translateX(0)';
            }, 100);
        });

        // Button hover effects
        const buttons = document.querySelectorAll('.btn, .bookings-btn');
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
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>