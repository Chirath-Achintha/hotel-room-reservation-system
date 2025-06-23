<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Reservation - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --premium-color: #f39c12;
        }

        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .auth-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
            transform: translateY(0);
            transition: all 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .auth-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                    45deg,
                    transparent 0%,
                    rgba(52, 152, 219, 0.05) 50%,
                    transparent 100%
            );
            animation: shimmer 8s linear infinite;
            z-index: 0;
        }

        @keyframes shimmer {
            0% { transform: translateX(-50%) translateY(-50%) rotate(0deg); }
            100% { transform: translateX(50%) translateY(50%) rotate(360deg); }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
            z-index: 1;
        }

        .form-header h2 {
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
            position: relative;
            display: inline-block;
        }

        .form-header h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            border-radius: 3px;
        }

        .form-header p {
            color: #6c757d;
            font-size: 0.95rem;
        }

        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
            background: rgba(255,255,255,0.9);
        }

        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }

        .btn-primary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
            overflow: hidden;
            z-index: 1;
            border: none;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);
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

        .input-group-text {
            background-color: rgba(52, 152, 219, 0.1);
            border-color: rgba(52, 152, 219, 0.3);
            color: var(--secondary-color);
        }

        a {
            color: var(--secondary-color);
            text-decoration: none;
            position: relative;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--secondary-color);
            transition: width 0.3s ease;
        }

        a:hover::after {
            width: 100%;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            z-index: 5;
        }

        .form-check-input:checked {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .premium-option {
            position: relative;
            padding-left: 2.5rem;
        }

        .premium-option .form-check-label::before {
            content: '★';
            position: absolute;
            left: 0;
            color: var(--premium-color);
            font-size: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0;
            transition: all 0.3s ease;
        }

        .premium-option:hover .form-check-label::before,
        .premium-option .form-check-input:checked ~ .form-check-label::before {
            opacity: 1;
            left: 0.5rem;
        }

        .premium-option .form-check-label {
            transition: all 0.3s ease;
            position: relative;
        }

        .premium-option:hover .form-check-label {
            color: var(--premium-color);
        }

        .premium-option .form-check-input:checked ~ .form-check-label {
            color: var(--premium-color);
            font-weight: 600;
        }

        .password-strength {
            height: 5px;
            background: #e9ecef;
            border-radius: 3px;
            margin-top: 5px;
            overflow: hidden;
            position: relative;
        }

        .password-strength::after {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 0;
            background: #e74c3c;
            transition: all 0.3s ease;
        }

        .password-strength[data-strength="1"]::after {
            width: 25%;
            background: #e74c3c;
        }

        .password-strength[data-strength="2"]::after {
            width: 50%;
            background: #f39c12;
        }

        .password-strength[data-strength="3"]::after {
            width: 75%;
            background: #f1c40f;
        }

        .password-strength[data-strength="4"]::after {
            width: 100%;
            background: #2ecc71;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="auth-container">
        <div class="form-header">
            <h2><i class="fas fa-user-plus me-2"></i>Create Account</h2>
            <p>Join our hotel reservation system</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <div class="mb-4 position-relative">
                <label for="username" class="form-label fw-semibold">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control ps-3" id="username" name="username" required
                           placeholder="Choose a username" style="border-radius: 0 8px 8px 0 !important;">
                </div>
            </div>

            <div class="mb-4 position-relative">
                <label for="password" class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control ps-3" id="password" name="password" required
                           placeholder="Create a password" style="border-radius: 0 8px 8px 0 !important;"
                           oninput="checkPasswordStrength(this.value)">
                    <span class="password-toggle" id="togglePassword">
                        <i class="far fa-eye"></i>
                    </span>
                </div>
                <div class="password-strength mt-2" id="passwordStrength" data-strength="0"></div>
                <small class="text-muted d-block mt-1">Use 8+ characters with mix of letters, numbers & symbols</small>
            </div>

            <div class="mb-4 position-relative">
                <label for="email" class="form-label fw-semibold">Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" class="form-control ps-3" id="email" name="email" required
                           placeholder="Your email address" style="border-radius: 0 8px 8px 0 !important;">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Account Type</label>
                <div class="form-check mb-2">
                    <input class="form-check-input" type="radio" name="role" id="regularUser" value="REGULAR" checked>
                    <label class="form-check-label" for="regularUser">
                        Regular User
                    </label>
                </div>
                <div class="form-check premium-option">
                    <input class="form-check-input" type="radio" name="role" id="premiumUser" value="PREMIUM">
                    <label class="form-check-label" for="premiumUser">
                        Premium User (Special benefits and discounts)
                    </label>
                </div>
            </div>

            <div class="d-grid gap-2 mb-3">
                <button type="submit" class="btn btn-primary btn-lg py-3">
                    <span class="register-text">Create Account</span>
                    <span class="spinner-border spinner-border-sm ms-2 d-none" role="status" aria-hidden="true"></span>
                </button>
            </div>

            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                <label class="form-check-label small" for="termsCheck">
                    I agree to the <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms of Service</a> and <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Privacy Policy</a>
                </label>
            </div>
        </form>

        <div class="mt-4 text-center pt-3 border-top">
            <p class="mb-0">Already have an account?
                <a href="${pageContext.request.contextPath}/auth/login" class="fw-semibold">Login here</a>
            </p>
        </div>
    </div>
</div>

<!-- Terms Modal -->
<div class="modal fade" id="termsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Terms of Service</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Terms content goes here...</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Privacy Modal -->
<div class="modal fade" id="privacyModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Privacy Policy</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Privacy policy content goes here...</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Password toggle functionality
        const togglePassword = document.querySelector('#togglePassword');
        const password = document.querySelector('#password');

        togglePassword.addEventListener('click', function() {
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
        });

        // Form submission animation
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            if (!document.getElementById('termsCheck').checked) {
                e.preventDefault();
                alert('Please agree to the Terms of Service and Privacy Policy');
                return;
            }

            const btn = this.querySelector('button[type="submit"]');
            const registerText = btn.querySelector('.register-text');
            const spinner = btn.querySelector('.spinner-border');

            registerText.textContent = 'Creating Account...';
            spinner.classList.remove('d-none');
            btn.disabled = true;
        });

        // Input focus effects
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-group-text').style.backgroundColor = 'rgba(52, 152, 219, 0.2)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.querySelector('.input-group-text').style.backgroundColor = 'rgba(52, 152, 219, 0.1)';
            });
        });
    });

    function checkPasswordStrength(password) {
        const strengthBar = document.getElementById('passwordStrength');
        let strength = 0;

        // Check password length
        if (password.length >= 8) strength++;
        if (password.length >= 12) strength++;

        // Check for mixed case
        if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength++;

        // Check for numbers
        if (password.match(/[0-9]/)) strength++;

        // Check for special chars
        if (password.match(/[^a-zA-Z0-9]/)) strength++;

        // Update strength meter
        const strengthLevel = Math.min(Math.floor(strength / 2), 4);
        strengthBar.setAttribute('data-strength', strengthLevel);
    }
</script>
</body>
</html>