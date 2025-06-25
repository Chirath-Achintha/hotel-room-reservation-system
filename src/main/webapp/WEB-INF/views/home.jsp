<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>PG64 Hotel Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --hero-gradient: linear-gradient(135deg, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.2) 100%);
            --feature-gradient: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(120deg, #fbc2eb 0%, #a6c1ee 100%);
            animation: fadeIn 1.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Hero Section with lighter overlay */
        .hero-section {
            background: var(--hero-gradient), url('${pageContext.request.contextPath}/static/images/hotel-hero.jpg');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            position: relative;
            overflow: hidden;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            animation: heroContentEntrance 1.5s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
        }

        @keyframes heroContentEntrance {
            0% {
                opacity: 0;
                transform: translateY(40px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero-section h1 {
            font-size: 4rem;
            font-weight: 800;
            text-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }

        /* Navigation */
        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: all 0.4s ease;
        }

        .navbar.scrolled {
            background-color: rgba(44, 62, 80, 0.95) !important;
            backdrop-filter: blur(10px);
            padding-top: 0.5rem;
            padding-bottom: 0.5rem;
        }

        .nav-link {
            position: relative;
            padding: 0.5rem 1rem;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: white;
            transition: width 0.3s ease;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Cards with 3D effect */
        .feature-card, .room-card {
            transition: all 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 16px;
            overflow: hidden;
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(4px);
            opacity: 0;
            animation: fadeInUp 0.8s forwards;
            animation-delay: calc(var(--animation-order) * 0.1s);
        }

        .feature-card:hover, .room-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 14px 28px rgba(0,0,0,0.15), 0 10px 10px rgba(0,0,0,0.1);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #66a6ff 0%, #89f7fe 100%);
            border: none;
            border-radius: 50px;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 12px 30px;
            box-shadow: 0 4px 15px rgba(102, 166, 255, 0.4);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 166, 255, 0.6);
        }

        /* Floating animation for featured icons */
        .feature-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* Section entrance animations */
        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 2rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            width: 60%;
            height: 4px;
            bottom: -10px;
            left: 20%;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
            transform: scaleX(0);
            transform-origin: center;
            animation: expandLine 1.5s ease forwards;
        }

        @keyframes expandLine {
            from { transform: scaleX(0); }
            to { transform: scaleX(1); }
        }

        /* Footer styling */
        .footer {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 3rem 0;
            position: relative;
            overflow: hidden;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('${pageContext.request.contextPath}/static/images/footer-pattern.png');
            opacity: 0.05;
            z-index: 0;
        }

        .footer-content {
            position: relative;
            z-index: 1;
        }

        /* Social media icons */
        .social-icon {
            display: inline-flex;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: var(--accent-color);
            transform: translateY(-5px);
        }

        /* Room search form */
        .search-card {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .search-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .form-floating label {
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            border-color: var(--secondary-color);
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-hotel me-2"></i>PG64 Hotels
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/room/catalog">Rooms</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/service/catalog">Services</a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/profile">
                                <i class="fas fa-user-circle me-1"></i>My Account
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">
                                <i class="fas fa-sign-out-alt me-1"></i>Logout
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/register">
                                <i class="fas fa-user-plus me-1"></i>Register
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <div class="row">
                <div class="col-lg-7">
                    <h1 class="display-3 fw-bold mb-4">Experience Luxury Redefined</h1>
                    <p class="lead mb-4" style="font-size: 1.5rem; text-shadow: 0 1px 3px rgba(0,0,0,0.3);">Discover unparalleled comfort in the heart of the city at PG64 Hotels, where every detail is crafted for your pleasure.</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/room/catalog" class="btn btn-primary btn-lg px-4 py-3">
                            <i class="fas fa-calendar-check me-2"></i>Book Now
                        </a>
                        <a href="#rooms" class="btn btn-outline-light btn-lg px-4 py-3">
                            <i class="fas fa-eye me-2"></i>Explore Rooms
                        </a>
                        <c:if test="${sessionScope.user['class'].simpleName == 'AdminUser'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-warning btn-lg px-4 py-3">
                                <i class="fas fa-tools me-2"></i>Admin Panel
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Feedback Button Section -->
<div class="container my-5 text-center" style="animation: fadeIn 1s ease 0.5s both;">
    <a href="${pageContext.request.contextPath}/feedback" class="btn btn-primary btn-lg px-4 py-3">
        <i class="fas fa-comment-dots me-2"></i>Share Your Experience
    </a>
</div>

<!-- Room Search Section -->
<section class="py-5 bg-white" style="position: relative; z-index: 2;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="search-card">
                    <div class="card-body p-4" style="background: rgba(255,255,255,0.95);">
                        <h3 class="text-center mb-4" style="color: var(--primary-color);">Find Your Perfect Stay</h3>
                        <form action="${pageContext.request.contextPath}/room/search" method="get">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="checkIn" name="checkIn" required
                                               min="${LocalDate.now()}" value="${LocalDate.now()}">
                                        <label for="checkIn">Check In Date</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="checkOut" name="checkOut" required
                                               min="${LocalDate.now().plusDays(1)}" value="${LocalDate.now().plusDays(1)}">
                                        <label for="checkOut">Check Out Date</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select class="form-select" id="roomType" name="roomType">
                                            <option value="">Any Room Type</option>
                                            <option value="STANDARD">Standard Room</option>
                                            <option value="DELUXE">Deluxe Room</option>
                                            <option value="SUITE">Executive Suite</option>
                                            <option value="PRESIDENTIAL">Presidential Suite</option>
                                        </select>
                                        <label for="roomType">Room Type</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select class="form-select" id="guests" name="guests">
                                            <option value="1">1 Guest</option>
                                            <option value="2" selected>2 Guests</option>
                                            <option value="3">3 Guests</option>
                                            <option value="4">4 Guests</option>
                                            <option value="5">5+ Guests</option>
                                        </select>
                                        <label for="guests">Number of Guests</label>
                                    </div>
                                </div>
                                <div class="col-12 mt-2">
                                    <button type="submit" class="btn btn-primary w-100 btn-lg py-3">
                                        <i class="fas fa-search me-2"></i>Search Available Rooms
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5" style="background: var(--feature-gradient);">
    <div class="container">
        <div class="row text-center mb-5">
            <div class="col-12">
                <h2 class="section-title display-4">Why Choose PG64 Hotels</h2>
                <p class="lead" style="color: var(--primary-color);">Exceptional experiences crafted just for you</p>
            </div>
        </div>
        <div class="row g-4">
            <div class="col-md-4" style="--animation-order: 1;">
                <div class="feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-star feature-icon mb-3"></i>
                        <h3 class="h4 mb-3">Luxury Accommodations</h3>
                        <p class="text-muted">Our rooms are designed with your comfort in mind, featuring premium amenities and elegant decor.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4" style="--animation-order: 2;">
                <div class="feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-utensils feature-icon mb-3"></i>
                        <h3 class="h4 mb-3">Gourmet Dining</h3>
                        <p class="text-muted">Experience culinary excellence with our award-winning restaurants and room service.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4" style="--animation-order: 3;">
                <div class="feature-card">
                    <div class="card-body text-center p-4">
                        <i class="fas fa-spa feature-icon mb-3"></i>
                        <h3 class="h4 mb-3">Wellness & Spa</h3>
                        <p class="text-muted">Rejuvenate your mind and body with our world-class spa facilities and wellness programs.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Room Showcase -->
<section id="rooms" class="py-5" style="background: linear-gradient(120deg, #f6d365 0%, #fda085 100%);">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title">Our Accommodations</h2>
            <p class="lead" style="color: var(--primary-color);">Discover our carefully curated selection of rooms</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3" style="--animation-order: 1;">
                <div class="room-card">
                    <div class="card h-100 border-0">
                        <img src="https://source.unsplash.com/600x400/?hotel,standard" class="card-img-top" alt="Standard Room" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Standard Room</h5>
                            <p class="card-text">Comfortable and affordable accommodation with all essential amenities for a pleasant stay.</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary">From $99/night</span>
                                <a href="${pageContext.request.contextPath}/room/search?roomType=STANDARD" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3" style="--animation-order: 2;">
                <div class="room-card">
                    <div class="card h-100 border-0">
                        <img src="https://source.unsplash.com/600x400/?hotel,deluxe" class="card-img-top" alt="Deluxe Room" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Deluxe Room</h5>
                            <p class="card-text">Spacious rooms with premium amenities, stunning views, and enhanced comfort features.</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary">From $199/night</span>
                                <a href="${pageContext.request.contextPath}/room/search?roomType=DELUXE" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3" style="--animation-order: 3;">
                <div class="room-card">
                    <div class="card h-100 border-0">
                        <img src="https://source.unsplash.com/600x400/?hotel,suite" class="card-img-top" alt="Suite" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Executive Suite</h5>
                            <p class="card-text">Luxurious living space with separate bedroom and living area, perfect for extended stays.</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary">From $299/night</span>
                                <a href="${pageContext.request.contextPath}/room/search" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3" style="--animation-order: 4;">
                <div class="room-card">
                    <div class="card h-100 border-0">
                        <img src="https://source.unsplash.com/600x400/?hotel,presidential" class="card-img-top" alt="Presidential Suite" style="height: 200px; object-fit: cover;">
                        <div class="card-body">
                            <h5 class="card-title">Presidential Suite</h5>
                            <p class="card-text">The epitome of luxury with premium services, exclusive amenities, and breathtaking views.</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="fw-bold text-primary">From $499/night</span>
                                <a href="${pageContext.request.contextPath}/room/search" class="btn btn-sm btn-outline-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-5" style="animation: fadeIn 1s ease 0.8s both;">
            <a href="${pageContext.request.contextPath}/room/catalog" class="btn btn-primary btn-lg px-4 py-3">
                <i class="fas fa-arrow-right me-2"></i>Explore All Room Options
            </a>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="py-5" style="background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%); color: white;">
    <div class="container text-center">
        <h2 class="display-5 fw-bold mb-4">Ready for an Unforgettable Experience?</h2>
        <p class="lead mb-5" style="max-width: 700px; margin: 0 auto;">Join our loyalty program today and enjoy exclusive benefits, special rates, and personalized services.</p>
        <div class="d-flex justify-content-center gap-3">
            <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-light btn-lg px-4 py-3">
                <i class="fas fa-user-plus me-2"></i>Become a Member
            </a>
            <a href="${pageContext.request.contextPath}/room/catalog" class="btn btn-outline-light btn-lg px-4 py-3">
                <i class="fas fa-calendar-alt me-2"></i>Check Availability
            </a>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="mb-4"><i class="fas fa-hotel me-2"></i>PG64 Hotels</h4>
                    <p>Providing exceptional hospitality services since 2023. Our mission is to create memorable experiences for every guest.</p>
                    <div class="mt-4">
                        <a href="#" class="social-icon me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon me-2"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-icon me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5 class="mb-4">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/room/catalog">Rooms</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/service/catalog">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="mb-4">Contact Us</h5>
                    <ul class="list-unstyled">
                        <li class="mb-3"><i class="fas fa-map-marker-alt me-2"></i> 123 Luxury Avenue, City Center</li>
                        <li class="mb-3"><i class="fas fa-phone me-2"></i> +1 (555) 123-4567</li>
                        <li><i class="fas fa-envelope me-2"></i> info@pg64hotels.com</li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="mb-4">Newsletter</h5>
                    <p>Subscribe to our newsletter for special offers and updates.</p>
                    <form class="mt-3">
                        <div class="input-group mb-3">
                            <input type="email" class="form-control" placeholder="Your Email" aria-label="Your Email">
                            <button class="btn btn-primary" type="button">Subscribe</button>
                        </div>
                    </form>
                </div>
            </div>
            <hr class="mt-4 mb-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="text-center">
                <p class="mb-0">&copy; 2023 PG64 Hotel Reservation System. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Initialize animations
    document.addEventListener('DOMContentLoaded', function() {
        // Animate elements when they come into view
        const animateOnScroll = function() {
            const elements = document.querySelectorAll('.feature-card, .room-card');
            elements.forEach(element => {
                const elementPosition = element.getBoundingClientRect().top;
                const windowHeight = window.innerHeight;

                if (elementPosition < windowHeight - 100) {
                    element.style.animation = 'fadeInUp 0.8s forwards';
                }
            });
        };

        // Run once on load and then on scroll
        animateOnScroll();
        window.addEventListener('scroll', animateOnScroll);

        // Auto-hide toast after 5 seconds
        const toast = document.querySelector('.toast');
        if (toast) {
            setTimeout(function() {
                const bsToast = new bootstrap.Toast(toast);
                bsToast.hide();
            }, 5000);
        }
    });

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>
</body>
</html>