<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
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
    .card:hover {
        transform: scale(1.02) translateY(-2px);
        box-shadow: 0 16px 32px rgba(0,0,0,0.12);
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.2rem;
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%) !important;
        color: #fff !important;
    }
    .form-label {
        color: #4a5568;
        font-weight: 500;
    }
    .form-control {
        border-radius: 8px;
        border: 1px solid #b3c6e0;
        transition: border 0.3s, box-shadow 0.3s;
    }
    .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 2px #a1c4fd55;
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
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">Edit Profile</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/user/update" method="post">
                        <!-- Hidden fields to preserve user data -->
                        <input type="hidden" name="id" value="${user.id}"/>
                        <input type="hidden" name="className" value="${user['class'].name}"/>
                        
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                        </div>
                        
                        <c:if test="${user['class'].simpleName == 'AdminUser'}">
                            <div class="mb-3">
                                <label for="adminLevel" class="form-label">Admin Level</label>
                                <input type="text" class="form-control" id="adminLevel" name="adminLevel" value="${user.adminLevel}">
                                <input type="hidden" name="premium" value="false"/>
                            </div>
                        </c:if>
                        
                        <c:if test="${user['class'].simpleName == 'RegularUser'}">
                            <div class="mb-3">
                                <label class="form-label">Premium Status</label>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="premium" name="premium" value="true" ${user.premium ? 'checked' : ''}>
                                    <input type="hidden" name="premium" value="false"/>
                                    <input type="hidden" name="adminLevel" value=""/>
                                    <label class="form-check-label" for="premium">Premium Account</label>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/> 