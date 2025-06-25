<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section class="testimonials py-5 bg-light">
    <div class="container">
        <div class="row text-center">
            <div class="col-12">
                <h2 class="display-4 mb-2">What Our Guests Say</h2>
                <p class="lead text-muted mb-5">Don't just take our word for it</p>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <!-- Reviews Carousel -->
                <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000">
                    <div class="carousel-inner">
                        <c:choose>
                            <c:when test="${empty featuredReviews}">
                                <div class="carousel-item active">
                                    <div class="row justify-content-center">
                                        <div class="col-lg-8">
                                            <div class="card border-0 shadow-sm">
                                                <div class="card-body text-center p-5">
                                                    <p class="lead mb-4">Be the first to share your experience with us!</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${featuredReviews}" var="review" varStatus="status">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                        <div class="row justify-content-center">
                                            <div class="col-lg-8">
                                                <div class="card border-0 shadow-sm">
                                                    <div class="card-body text-center p-5">
                                                        <div class="mb-4">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <i class="bi bi-star${star <= review.rating ? '-fill' : ''} text-warning"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <p class="lead mb-4">"${review.comment}"</p>
                                                        <div class="d-flex justify-content-center align-items-center">
                                                            <div class="text-center">
                                                                <h5 class="mb-0">${review.userName}</h5>
                                                                <small class="text-muted">
                                                                    <fmt:formatDate value="${review.reviewDate}" pattern="MMMM yyyy" />
                                                                </small>
                                                                <p class="text-muted mt-2">
                                                                    <small>${review.type} Review</small>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${not empty featuredReviews}">
                        <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon bg-dark rounded-circle" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                            <span class="carousel-control-next-icon bg-dark rounded-circle" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Add Review Button -->
        <div class="row mt-5">
            <div class="col-12 text-center">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary btn-lg">
                            Login to Share Your Experience
                        </a>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#addReviewModal">
                            Share Your Experience
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- Add Review Modal -->
<div class="modal fade" id="addReviewModal" tabindex="-1" aria-labelledby="addReviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addReviewModalLabel">Share Your Experience</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reviewForm" action="${pageContext.request.contextPath}/review/quick-submit" method="post" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Overall Rating</label>
                        <div class="star-rating">
                            <c:forEach begin="1" end="5" var="star">
                                <input type="radio" id="star${star}" name="rating" value="${star}" required>
                                <label for="star${star}"><i class="bi bi-star-fill"></i></label>
                            </c:forEach>
                        </div>
                        <div class="invalid-feedback">Please select a rating.</div>
                    </div>

                    <div class="mb-3">
                        <label for="comment" class="form-label">Your Review</label>
                        <textarea class="form-control" id="comment" name="comment" rows="4" required
                            placeholder="Share your experience with our hotel..."></textarea>
                        <div class="invalid-feedback">Please share your experience.</div>
                    </div>

                    <div class="mb-3">
                        <label for="reviewType" class="form-label">What would you like to review?</label>
                        <select class="form-select" id="reviewType" name="type" required>
                            <option value="">Choose...</option>
                            <option value="ROOM">Room Experience</option>
                            <option value="SERVICE">Hotel Services</option>
                        </select>
                        <div class="invalid-feedback">Please select what you'd like to review.</div>
                    </div>

                    <div id="roomFields" class="d-none">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="cleanliness" class="form-label">Cleanliness</label>
                                    <select class="form-select" id="cleanliness" name="cleanliness">
                                        <option value="Excellent">Excellent</option>
                                        <option value="Good">Good</option>
                                        <option value="Fair">Fair</option>
                                        <option value="Poor">Poor</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="comfort" class="form-label">Comfort</label>
                                    <select class="form-select" id="comfort" name="comfort">
                                        <option value="Excellent">Excellent</option>
                                        <option value="Good">Good</option>
                                        <option value="Fair">Fair</option>
                                        <option value="Poor">Poor</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="mb-3">
                                    <label for="location" class="form-label">Location</label>
                                    <select class="form-select" id="location" name="location">
                                        <option value="Excellent">Excellent</option>
                                        <option value="Good">Good</option>
                                        <option value="Fair">Fair</option>
                                        <option value="Poor">Poor</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="reviewForm" class="btn btn-primary">Submit Review</button>
            </div>
        </div>
    </div>
</div>

<style>
    .testimonials {
        background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
        border-radius: 24px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        animation: fadeInBg 1.2s;
    }
    @keyframes fadeInBg {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    .testimonials .card {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    .testimonials .card:hover {
        transform: scale(1.04) translateY(-8px);
        box-shadow: 0 16px 32px rgba(0,0,0,0.13);
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .carousel-control-prev-icon, .carousel-control-next-icon {
        background-color: #2c3e50;
        border-radius: 50%;
        transition: background 0.3s, transform 0.2s;
    }
    .carousel-control-prev-icon:hover, .carousel-control-next-icon:hover {
        background-color: #fbc2eb;
        transform: scale(1.15);
    }
    .modal-content {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.13);
        background: rgba(255,255,255,0.98);
        animation: modalFadeIn 0.7s;
    }
    @keyframes modalFadeIn {
        from { opacity: 0; transform: scale(0.97); }
        to { opacity: 1; transform: scale(1); }
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
    .star-rating label {
        color: #fbc2eb;
        transition: color 0.2s, transform 0.2s;
    }
    .star-rating label:hover, .star-rating input:checked ~ label {
        color: #ffd700;
        transform: scale(1.2);
    }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Form validation
    const form = document.getElementById('reviewForm');
    form.addEventListener('submit', function(event) {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        form.classList.add('was-validated');
    });

    // Show/hide fields based on review type
    const reviewType = document.getElementById('reviewType');
    const roomFields = document.getElementById('roomFields');
    const serviceFields = document.getElementById('serviceFields');

    reviewType.addEventListener('change', function() {
        if (this.value === 'ROOM') {
            roomFields.classList.remove('d-none');
            serviceFields.classList.add('d-none');
            enableFields(roomFields);
            disableFields(serviceFields);
        } else if (this.value === 'SERVICE') {
            serviceFields.classList.remove('d-none');
            roomFields.classList.add('d-none');
            enableFields(serviceFields);
            disableFields(roomFields);
        } else {
            roomFields.classList.add('d-none');
            serviceFields.classList.add('d-none');
            disableFields(roomFields);
            disableFields(serviceFields);
        }
    });

    function enableFields(container) {
        container.querySelectorAll('select').forEach(select => {
            select.required = true;
            select.disabled = false;
        });
    }

    function disableFields(container) {
        container.querySelectorAll('select').forEach(select => {
            select.required = false;
            select.disabled = true;
        });
    }
});
</script> 