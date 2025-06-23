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

    .edit-profile-container {
        animation: fadeInUp 0.6s ease-out;
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .profile-edit-card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(5px);
    }

    .profile-edit-card:hover {
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

    .form-control {
        border-radius: 8px;
        padding: 12px 15px;
        border: 1px solid #ced4da;
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.9);
    }

    .form-control:focus {
        border-color: var(--secondary-color);
        box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        transform: translateY(-2px);
    }

    .form-label {
        font-weight: 500;
        margin-bottom: 0.5rem;
        transition: all 0.3s ease;
    }

    .form-group:hover .form-label {
        color: var(--secondary-color);
    }

    .alert-danger {
        background-color: rgba(231, 76, 60, 0.1);
        border-color: rgba(231, 76, 60, 0.3);
        color: var(--accent-color);
        border-radius: 8px;
        animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both;
        transform: translate3d(0, 0, 0);
        backface-visibility: hidden;
        perspective: 1000px;
    }

    @keyframes shake {
        10%, 90% { transform: translate3d(-1px, 0, 0); }
        20%, 80% { transform: translate3d(2px, 0, 0); }
        30%, 50%, 70% { transform: translate3d(-4px, 0, 0); }
        40%, 60% { transform: translate3d(4px, 0, 0); }
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

    .btn-secondary {
        background: linear-gradient(135deg, #95a5a6, #7f8c8d);
        box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
    }

    .btn-secondary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(149, 165, 166, 0.4);
    }

    .form-check-input {
        width: 1.2em;
        height: 1.2em;
        margin-top: 0.2em;
        transition: all 0.3s ease;
    }

    .form-check-input:checked {
        background-color: var(--premium-color);
        border-color: var(--premium-color);
    }

    .form-check-input:focus {
        box-shadow: 0 0 0 0.25rem rgba(243, 156, 18, 0.25);
    }

    .form-check-label {
        margin-left: 0.5rem;
        transition: all 0.3s ease;
    }

    .form-check:hover .form-check-label {
        color: var(--premium-color);
    }

    .admin-level-field {
        background: rgba(155, 89, 182, 0.1);
        border-left: 3px solid var(--admin-color);
        padding: 1rem;
        border-radius: 0 8px 8px 0;
        margin-top: 1rem;
    }

    .premium-field {
        background: rgba(243, 156, 18, 0.1);
        border-left: 3px solid var(--premium-color);
        padding: 1rem;
        border-radius: 0 8px 8px 0;
        margin-top: 1rem;
    }
</style>

<div class="container mt-5 edit-profile-container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card profile-edit-card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0"><i class="fas fa-user-edit me-2"></i>Edit Profile</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/update" method="post">
                        <!-- Hidden fields to preserve user data -->
                        <input type="hidden" name="id" value="${user.id}"/>
                        <input type="hidden" name="className" value="${user['class'].name}"/>

                        <div class="mb-4 form-group">
                            <label for="username" class="form-label"><i class="fas fa-user me-2"></i>Username</label>
                            <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                        </div>

                        <div class="mb-4 form-group">
                            <label for="email" class="form-label"><i class="fas fa-envelope me-2"></i>Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                        </div>

                        <div class="mb-4 form-group">
                            <label for="newPassword" class="form-label"><i class="fas fa-lock me-2"></i>New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword">
                            <small class="text-muted">Minimum 8 characters with mix of letters and numbers</small>
                        </div>

                        <c:if test="${user['class'].simpleName == 'AdminUser'}">
                            <div class="mb-4 admin-level-field">
                                <label for="adminLevel" class="form-label"><i class="fas fa-shield-alt me-2"></i>Admin Level</label>
                                <input type="text" class="form-control" id="adminLevel" name="adminLevel" value="${user.adminLevel}">
                                <input type="hidden" name="premium" value="false"/>
                            </div>
                        </c:if>

                        <c:if test="${user['class'].simpleName == 'RegularUser'}">
                            <div class="mb-4 premium-field">
                                <label class="form-label"><i class="fas fa-crown me-2"></i>Premium Status</label>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="premium" name="premium" value="true" ${user.premium ? 'checked' : ''}>
                                    <input type="hidden" name="premium" value="false"/>
                                    <input type="hidden" name="adminLevel" value=""/>
                                    <label class="form-check-label" for="premium">Upgrade to Premium Account</label>
                                </div>
                                <small class="text-muted">Enjoy exclusive benefits with premium membership</small>
                            </div>
                        </c:if>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Form input animations
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach((input, index) => {
            input.style.opacity = '0';
            input.style.transform = 'translateY(10px)';
            input.style.transition = `all 0.5s ease ${index * 0.1}s`;

            setTimeout(() => {
                input.style.opacity = '1';
                input.style.transform = 'translateY(0)';
            }, 100);
        });

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

        // Password strength indicator
        const passwordField = document.getElementById('newPassword');
        if (passwordField) {
            passwordField.addEventListener('input', function() {
                // Add password strength logic if needed
            });
        }
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>