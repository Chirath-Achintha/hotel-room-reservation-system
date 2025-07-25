<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        min-height: 100vh;
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
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.2rem;
        background: linear-gradient(90deg, #a6c1ee 0%, #fbc2eb 100%) !important;
        color: #fff !important;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .form-label {
        color: #4a5568;
        font-weight: 500;
    }
    .form-control, .form-select {
        border-radius: 8px;
        border: 1px solid #b3c6e0;
        transition: border 0.3s, box-shadow 0.3s;
    }
    .form-control:focus, .form-select:focus {
        border-color: #a6c1ee;
        box-shadow: 0 0 0 2px #fbc2eb55;
    }
    .btn-primary {
        background: linear-gradient(90deg, #a6c1ee 0%, #fbc2eb 100%);
        border: none;
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
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
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-secondary:hover {
        background: #a1c4fd;
        color: #222;
    }
    .alert-danger {
        animation: fadeInAlert 0.7s;
    }
    @keyframes fadeInAlert {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
    }
</style>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">Room Review</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/review/room/submit" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="roomId" value="${roomId}">
                        
                        <div class="mb-3">
                            <label for="rating" class="form-label">Rating</label>
                            <select class="form-select" id="rating" name="rating" required>
                                <option value="">Choose rating...</option>
                                <option value="1">1 - Poor</option>
                                <option value="2">2 - Fair</option>
                                <option value="3">3 - Good</option>
                                <option value="4">4 - Very Good</option>
                                <option value="5">5 - Excellent</option>
                            </select>
                            <div class="invalid-feedback">
                                Please select a rating.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="cleanliness" class="form-label">Cleanliness</label>
                            <select class="form-select" id="cleanliness" name="cleanliness" required>
                                <option value="">Rate cleanliness...</option>
                                <option value="Poor">Poor</option>
                                <option value="Fair">Fair</option>
                                <option value="Good">Good</option>
                                <option value="Excellent">Excellent</option>
                            </select>
                            <div class="invalid-feedback">
                                Please rate the cleanliness.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="comfort" class="form-label">Comfort</label>
                            <select class="form-select" id="comfort" name="comfort" required>
                                <option value="">Rate comfort...</option>
                                <option value="Poor">Poor</option>
                                <option value="Fair">Fair</option>
                                <option value="Good">Good</option>
                                <option value="Excellent">Excellent</option>
                            </select>
                            <div class="invalid-feedback">
                                Please rate the comfort.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <select class="form-select" id="location" name="location" required>
                                <option value="">Rate location...</option>
                                <option value="Poor">Poor</option>
                                <option value="Fair">Fair</option>
                                <option value="Good">Good</option>
                                <option value="Excellent">Excellent</option>
                            </select>
                            <div class="invalid-feedback">
                                Please rate the location.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="comment" class="form-label">Comment</label>
                            <textarea class="form-control" id="comment" name="comment" rows="4" required></textarea>
                            <div class="invalid-feedback">
                                Please provide your comments.
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Submit Review</button>
                            <a href="${pageContext.request.contextPath}/room/details/${roomId}" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Form validation
(function () {
    'use strict'
    var forms = document.querySelectorAll('.needs-validation')
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }
            form.classList.add('was-validated')
        }, false)
    })
})()
</script>

<jsp:include page="../fragments/footer.jsp"/> 