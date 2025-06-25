<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
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
    .card {
        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        border-radius: 18px;
        transition: transform 0.3s, box-shadow 0.3s;
        background: #fff;
        margin-bottom: 24px;
        opacity: 0;
        animation: cardFadeIn 0.8s forwards;
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.2rem;
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%) !important;
        color: #fff !important;
    }
    .card-footer {
        background: #f7f7fa;
        border-radius: 0 0 18px 18px;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .btn {
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        border-radius: 8px;
        font-weight: 500;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }
    .btn-primary {
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        border: none;
    }
    .btn-primary:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    .btn-danger {
        background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
        color: #fff;
        border: none;
    }
    .btn-danger:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    h3, strong {
        color: #333;
        letter-spacing: 0.5px;
    }
    .badge {
        font-size: 1em;
        padding: 0.5em 1em;
        border-radius: 8px;
        animation: badgePop 0.7s;
    }
    @keyframes badgePop {
        from { transform: scale(0.7); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
</style>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">User Profile</h3>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-sm-3">
                            <strong>Username:</strong>
                        </div>
                        <div class="col-sm-9">
                            ${user.username}
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-3">
                            <strong>Email:</strong>
                        </div>
                        <div class="col-sm-9">
                            ${user.email}
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-3">
                            <strong>Account Type:</strong>
                        </div>
                        <div class="col-sm-9">
                            <c:choose>
                                <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                    Administrator
                                    <div class="mt-2">
                                        <strong>Admin Level:</strong> ${user.adminLevel}
                                    </div>
                                </c:when>
                                <c:when test="${user['class'].simpleName == 'PremiumUser'}">
                                    Premium User
                                    <div class="mt-2">
                                        <strong>Premium Since:</strong> ${user.premiumStartDate}<br/>
                                        <strong>Benefits:</strong> ${user.premiumBenefits}
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
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/user/edit/${user.id}" class="btn btn-primary">Edit Profile</a>
                        <c:if test="${user['class'].simpleName != 'AdminUser'}">
                            <form action="${pageContext.request.contextPath}/user/delete/${user.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
                                <button type="submit" class="btn btn-danger">Delete Account</button>
                            </form>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger">Logout</a>
                    </div>
                </div>
            </div>
            <div style="margin: 20px 0;">
                <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-primary" style="padding: 10px 20px; background: #2196F3; color: white; text-decoration: none; border-radius: 4px;">My Bookings</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
