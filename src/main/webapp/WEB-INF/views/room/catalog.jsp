<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --deluxe-color: #f39c12;
        --standard-color: #3498db;
    }

    .room-card {
        transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
        border: none;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transform: translateY(0);
        position: relative;
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(5px);
    }

    .room-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }

    .room-card .card-header {
        border-radius: 12px 12px 0 0 !important;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .room-card .card-header::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background: linear-gradient(90deg, rgba(255,255,255,0.3), transparent);
        animation: shimmer 2s infinite linear;
    }

    .room-card .bg-warning {
        background: linear-gradient(135deg, var(--deluxe-color), #e67e22) !important;
    }

    .room-card .bg-info {
        background: linear-gradient(135deg, var(--standard-color), #2980b9) !important;
    }

    .room-card .card-body {
        padding: 1.5rem;
    }

    .badge {
        font-weight: 500;
        padding: 0.35em 0.65em;
        border-radius: 50rem;
        transition: all 0.3s ease;
    }

    .badge.bg-success {
        background: linear-gradient(135deg, #2ecc71, #27ae60) !important;
    }

    .badge.bg-danger {
        background: linear-gradient(135deg, #e74c3c, #c0392b) !important;
    }

    .features ul {
        padding-left: 0;
    }

    .features li {
        margin-bottom: 0.5rem;
        position: relative;
        padding-left: 1.75rem;
        transition: all 0.3s ease;
    }

    .features li:hover {
        transform: translateX(5px);
    }

    .features li i {
        position: absolute;
        left: 0;
        top: 0.25rem;
    }

    .btn {
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        border: none;
        font-weight: 500;
        letter-spacing: 0.5px;
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

    .btn-info {
        background: linear-gradient(135deg, #1abc9c, #16a085);
        box-shadow: 0 4px 15px rgba(26, 188, 156, 0.3);
    }

    .btn-info:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(26, 188, 156, 0.4);
    }

    .btn-warning {
        background: linear-gradient(135deg, var(--deluxe-color), #e67e22);
        box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
    }

    .btn-warning:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(243, 156, 18, 0.4);
    }

    .btn-danger {
        background: linear-gradient(135deg, var(--accent-color), #c0392b);
        box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
    }

    .btn-danger:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(231, 76, 60, 0.4);
    }

    .manage-btn {
        transition: all 0.3s ease;
        padding: 0.75rem 1.5rem;
        border-radius: 50rem;
        font-weight: 600;
    }

    .manage-btn:hover {
        transform: translateY(-3px) scale(1.05);
    }

    @keyframes shimmer {
        0% { transform: translateX(-100%); }
        100% { transform: translateX(100%); }
    }

    .page-title {
        position: relative;
        display: inline-block;
        margin-bottom: 2rem;
    }

    .page-title::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
        border-radius: 2px;
        transform: scaleX(0.8);
        transform-origin: left;
        animation: titleUnderline 1s ease-out forwards;
    }

    @keyframes titleUnderline {
        from { transform: scaleX(0); }
        to { transform: scaleX(0.8); }
    }

    .card-title {
        position: relative;
        padding-bottom: 0.5rem;
    }

    .card-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 2px;
        background: rgba(255,255,255,0.5);
        border-radius: 1px;
    }
</style>

<div class="container mt-5">
    <h1 class="mb-4 page-title">Room Catalog</h1>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="room" items="${rooms}">
            <div class="col">
                <div class="card h-100 room-card">
                    <div class="card-header ${room['class'].simpleName == 'DeluxeRoom' ? 'bg-warning' : 'bg-info'} text-white">
                        <h5 class="card-title mb-0">
                            Room ${room.roomNumber} (${room['class'].simpleName == 'DeluxeRoom' ? 'DELUXE' : 'STANDARD'})
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            <strong>Price:</strong> $${room.price}<br>
                            <strong>Status:</strong>
                            <span class="badge ${room.available ? 'bg-success' : 'bg-danger'}">
                                    ${room.available ? 'Available' : 'Occupied'}
                            </span>
                        </p>

                        <div class="features mt-3">
                            <h6>Features:</h6>
                            <c:choose>
                                <c:when test="${room['class'].simpleName == 'DeluxeRoom'}">
                                    <ul class="list-unstyled">
                                        <li><i class="bi bi-check-circle-fill text-success"></i>
                                                ${room.hasJacuzzi() ? 'Jacuzzi Available' : 'No Jacuzzi'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill text-success"></i>
                                                ${room.hasMinibar() ? 'Minibar Available' : 'No Minibar'}
                                        </li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <ul class="list-unstyled">
                                        <li><i class="bi bi-check-circle-fill text-success"></i>
                                                ${room.numberOfBeds} Beds
                                        </li>
                                        <li><i class="bi bi-check-circle-fill text-success"></i>
                                                ${room.hasBalcony() ? 'Balcony Available' : 'No Balcony'}
                                        </li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="mt-3">
                            <c:if test="${room.available}">
                                <a href="${pageContext.request.contextPath}/booking/create/${room.roomId}"
                                   class="btn btn-primary">Book Now</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/review/room/list/${room.roomId}" class="btn btn-info ms-2">View Reviews</a>
                            <c:if test="${sessionScope.user['class'].simpleName == 'AdminUser'}">
                                <a href="${pageContext.request.contextPath}/room/manage"
                                   class="btn btn-warning">Edit</a>
                                <form action="${pageContext.request.contextPath}/room/delete/${room.roomId}"
                                      method="post" style="display: inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this room?');">
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </form>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${sessionScope.user['class'].simpleName == 'AdminUser'}">
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/room/manage" class="btn btn-primary manage-btn">
                <i class="bi bi-gear-fill"></i> Manage Rooms
            </a>
        </div>
    </c:if>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate cards on scroll
        const animateOnScroll = function() {
            const cards = document.querySelectorAll('.room-card');
            cards.forEach((card, index) => {
                const cardPosition = card.getBoundingClientRect().top;
                const screenPosition = window.innerHeight / 1.3;

                if (cardPosition < screenPosition) {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                    card.style.transitionDelay = `${index * 0.1}s`;
                }
            });
        };

        // Set initial state for animation
        document.querySelectorAll('.room-card').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'all 0.6s ease';
        });

        window.addEventListener('scroll', animateOnScroll);
        animateOnScroll(); // Run once on load

        // Button hover effects
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px)';
            });
            button.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>