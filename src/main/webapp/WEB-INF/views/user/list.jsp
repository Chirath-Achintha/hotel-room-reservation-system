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
        background: linear-gradient(90deg, #fbc2eb 0%, #a6c1ee 100%) !important;
        color: #fff !important;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
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
    .btn {
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        border-radius: 8px;
        font-weight: 500;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }
    .btn-warning {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
        color: #fff;
        border: none;
    }
    .btn-warning:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    .btn-success {
        background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
        color: #fff;
        border: none;
    }
    .btn-success:hover {
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
    .btn-secondary {
        background: #b3c6e0;
        color: #333;
        border: none;
    }
    .btn-secondary:hover {
        background: #a1c4fd;
        color: #222;
    }
    h3 {
        color: #333;
        letter-spacing: 0.5px;
    }
</style>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">User Management</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                                Admin (${user.adminLevel})
                                            </c:when>
                                            <c:when test="${user['class'].simpleName == 'PremiumUser'}">
                                                Premium
                                            </c:when>
                                            <c:when test="${user['class'].simpleName == 'RegularUser' && user.premium}">
                                                Regular (Premium)
                                            </c:when>
                                            <c:otherwise>
                                                Regular
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>Active</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <c:choose>
                                                <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                                    <a href="${pageContext.request.contextPath}/user/edit/admin/${user.id}" 
                                                       class="btn btn-sm btn-warning">Edit</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/user/edit/${user.id}" 
                                                       class="btn btn-sm btn-warning">Edit</a>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${user['class'].simpleName == 'RegularUser'}">
                                                <form action="${pageContext.request.contextPath}/user/upgrade/${user.id}" 
                                                      method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-sm btn-success ms-1"
                                                            ${user.premium ? 'disabled' : ''}>
                                                        ${user.premium ? 'Premium' : 'Upgrade to Premium'}
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <c:if test="${user['class'].simpleName != 'AdminUser'}">
                                                <form action="${pageContext.request.contextPath}/user/delete/${user.id}" 
                                                      method="post" style="display: inline;"
                                                      onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                    <button type="submit" class="btn btn-sm btn-danger ms-1">Delete</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Back to Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
