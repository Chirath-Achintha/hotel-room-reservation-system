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
        }

        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('${pageContext.request.contextPath}/static/images/hotel-hero.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(44, 62, 80, 0.3) 0%, rgba(52, 152, 219, 0.3) 100%);
            z-index: 0;
            animation: gradientShift 12s ease infinite;
            background-size: 200% 200%;
        }

        @keyframes gradientShift {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }

        .hero-section .container {
            padding-top: 100px;
            padding-bottom: 100px;
            position: relative;
            z-index: 1;
        }

        .feature-card {
            transition: all 0.5s cubic-bezier(0.25, 0.8, 0.25, 1);
            border: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            height: 100%;
            transform: translateY(0);
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(5px);
        }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 14px 28px rgba(0,0,0,0.15), 0 10px 10px rgba(0,0,0,0.12);
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--secondary-color);
            transition: all 0.3s ease;
        }

        .feature-card:hover .feature-icon {
            transform: rotate(15deg) scale(1.2);
        }

        .btn-primary {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            z-index: 1;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: all 0.6s ease;
            z-index: -1;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .navbar {
            background-color: var(--primary-color) !important;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar.scrolled {
            padding-top: 5px;
            padding-bottom: 5px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .footer {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
            position: relative;
            overflow: hidden;
        }

        .footer::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            animation: footerUnderline 8s linear infinite;
        }

        @keyframes footerUnderline {
            0% {background-position: 0% 50%;}
            100% {background-position: 100% 50%;}
        }

        .features .bi {
            font-size: 2.5rem;
        }

        .toast {
            background-color: white;
        }

        /* Text animation */
        .animate-text {
            display: inline-block;
            position: relative;
        }

        .animate-text::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 2px;
            bottom: -5px;
            left: 0;
            background-color: var(--secondary-color);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.5s ease;
        }

        .animate-text:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }

        /* Floating animation */
        @keyframes floating {
            0% {transform: translateY(0px);}
            50% {transform: translateY(-10px);}
            100% {transform: translateY(0px);}
        }

        .floating {
            animation: floating 3s ease-in-out infinite;
        }

        /* Pulse animation */
        @keyframes pulse {
            0% {transform: scale(1);}
            50% {transform: scale(1.05);}
            100% {transform: scale(1);}
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        /* Room card hover effect */
        .room-card {
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            overflow: hidden;
        }

        .room-card img {
            transition: transform 0.5s ease;
        }

        .room-card:hover img {
            transform: scale(1.1);
        }

        .room-card .card-body {
            position: relative;
            z-index: 1;
            background: rgba(255,255,255,0.9);
            transition: all 0.3s ease;
        }

        .room-card:hover .card-body {
            background: white;
            box-shadow: 0 -10px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/" style="transition: all 0.3s ease;">
            <i class="fas fa-hotel me-2 animate-text" style="display: inline-block;"></i>PG64 Hotels
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                style="transition: all 0.3s ease;" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/"
                       style="position: relative; transition: all 0.3s ease;">
                        <span class="animate-text">Home</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/room/catalog"
                       style="position: relative; transition: all 0.3s ease;">
                        <span class="animate-text">Rooms</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/service/catalog"
                       style="position: relative; transition: all 0.3s ease;">
                        <span class="animate-text">Services</span>
                    </a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/user/profile"
                               style="position: relative; transition: all 0.3s ease;">
                                <i class="fas fa-user-circle me-1 animate-text" style="display: inline-block;"></i>
                                <span class="animate-text">My Account</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout"
                               style="position: relative; transition: all 0.3s ease;">
                                <i class="fas fa-sign-out-alt me-1 animate-text" style="display: inline-block;"></i>
                                <span class="animate-text">Logout</span>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/login"
                               style="position: relative; transition: all 0.3s ease;">
                                <i class="fas fa-sign-in-alt me-1 animate-text" style="display: inline-block;"></i>
                                <span class="animate-text">Login</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/auth/register"
                               style="position: relative; transition: all 0.3s ease;">
                                <i class="fas fa-user-plus me-1 animate-text" style="display: inline-block;"></i>
                                <span class="animate-text">Register</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<div class="hero-section position-relative">
    <div class="container">
        <div class="row min-vh-100 align-items-center">
            <div class="col-lg-6">
                <h1 class="display-3 fw-bold mb-4" style="text-shadow: 2px 2px 8px rgba(0,0,0,0.3); animation: fadeInUp 1s ease;">
                    Welcome to PG64 Hotel
                </h1>
                <p class="lead mb-4" style="text-shadow: 1px 1px 4px rgba(0,0,0,0.3); animation: fadeInUp 1.2s ease;">
                    Experience luxury and comfort in the heart of the city.
                </p>
                <a href="${pageContext.request.contextPath}/room/catalog"
                   class="btn btn-primary btn-lg pulse"
                   style="animation-delay: 1.4s;">
                    Book Now
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Feedback Button Section -->
<div class="container my-5 text-center">
    <a href="${pageContext.request.contextPath}/feedback"
       class="btn btn-lg btn-primary floating"
       style="box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);">
        <i class="fas fa-comment-dots me-2"></i>Give Feedback
    </a>
</div>

<!-- Room Search Section -->
<section class="room-search py-5 bg-white" style="background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card shadow-lg" style="border: none; border-radius: 15px; overflow: hidden;">
                    <div class="card-body p-4" style="background: rgba(255,255,255,0.95); backdrop-filter: blur(10px);">
                        <h3 class="text-center mb-4" style="position: relative; display: inline-block;">
                            <span style="position: relative; z-index: 1;">Find Your Perfect Room</span>
                            <span style="position: absolute; bottom: -5px; left: 0; width: 100%; height: 3px;
                                  background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
                                  border-radius: 3px; transform: scaleX(0.8);"></span>
                        </h3>
                        <form action="${pageContext.request.contextPath}/room/search" method="get">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="checkIn" name="checkIn" required
                                               min="${LocalDate.now()}" value="${LocalDate.now()}"
                                               style="transition: all 0.3s ease; border: 1px solid #ced4da;">
                                        <label for="checkIn">Check In</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="checkOut" name="checkOut" required
                                               min="${LocalDate.now().plusDays(1)}" value="${LocalDate.now().plusDays(1)}"
                                               style="transition: all 0.3s ease; border: 1px solid #ced4da;">
                                        <label for="checkOut">Check Out</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select class="form-select" id="roomType" name="roomType"
                                                style="transition: all 0.3s ease; border: 1px solid #ced4da;">
                                            <option value="">Any Type</option>
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
                                        <select class="form-select" id="guests" name="guests"
                                                style="transition: all 0.3s ease; border: 1px solid #ced4da;">
                                            <option value="1">1 Guest</option>
                                            <option value="2" selected>2 Guests</option>
                                            <option value="3">3 Guests</option>
                                            <option value="4">4 Guests</option>
                                            <option value="5">5+ Guests</option>
                                        </select>
                                        <label for="guests">Guests</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary w-100 btn-lg"
                                            style="position: relative; overflow: hidden;">
                                        <i class="fas fa-search me-2"></i>Search Available Rooms
                                        <span style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                                              background: linear-gradient(45deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.3) 50%, rgba(255,255,255,0.1) 100%);
                                              transform: translateX(-100%); transition: all 0.6s ease;"></span>
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
<section class="features py-5" style="background-color: #f9f9f9;">
    <div class="container">
        <div class="row text-center">
            <div class="col-12">
                <h2 class="display-4 mb-5" style="position: relative;">
                    <span style="position: relative; z-index: 1;">Why Choose Us</span>
                    <span style="position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%);
                          width: 80px; height: 4px; background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
                          border-radius: 2px;"></span>
                </h2>
            </div>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card"
                     style="border-radius: 12px; overflow: hidden;">
                    <div class="card-body text-center p-4">
                        <i class="bi bi-star-fill text-primary display-4 mb-3 feature-icon"></i>
                        <h3 class="h4 mb-3">Luxury Rooms</h3>
                        <p class="text-muted">Experience comfort in our well-appointed rooms with modern amenities.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card"
                     style="border-radius: 12px; overflow: hidden;">
                    <div class="card-body text-center p-4">
                        <i class="bi bi-geo-alt-fill text-primary display-4 mb-3 feature-icon"></i>
                        <h3 class="h4 mb-3">Prime Location</h3>
                        <p class="text-muted">Situated in the heart of the city with easy access to attractions.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm feature-card"
                     style="border-radius: 12px; overflow: hidden;">
                    <div class="card-body text-center p-4">
                        <i class="bi bi-person-check-fill text-primary display-4 mb-3 feature-icon"></i>
                        <h3 class="h4 mb-3">Exceptional Service</h3>
                        <p class="text-muted">Our dedicated staff ensures your stay is comfortable and memorable.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Room Showcase -->
<section class="bg-light py-5" style="background: linear-gradient(to bottom, #ffffff 0%, #f8f9fa 100%);">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold" style="position: relative; display: inline-block;">
                <span style="position: relative; z-index: 1;">Our Rooms</span>
                <span style="position: absolute; bottom: -5px; left: 0; width: 100%; height: 3px;
                      background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
                      border-radius: 3px;"></span>
            </h2>
            <p class="lead text-muted" style="animation: fadeIn 1.5s ease;">Experience comfort in our carefully designed rooms</p>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="card h-100 room-card" style="border-radius: 12px; overflow: hidden; border: none;">
                    <img src="https://source.unsplash.com/600x400/?hotel,standard" class="card-img-top" alt="Standard Room"
                         style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Standard Room</h5>
                        <p class="card-text">Comfortable and affordable accommodation with all basic amenities.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-primary">From $99/night</span>
                            <a href="${pageContext.request.contextPath}/room/search?roomType=STANDARD"
                               class="btn btn-sm btn-outline-primary"
                               style="transition: all 0.3s ease; border-width: 2px;">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 room-card" style="border-radius: 12px; overflow: hidden; border: none;">
                    <img src="https://source.unsplash.com/600x400/?hotel,deluxe" class="card-img-top" alt="Deluxe Room"
                         style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Deluxe Room</h5>
                        <p class="card-text">Spacious rooms with premium amenities and stunning views.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-primary">From $199/night</span>
                            <a href="${pageContext.request.contextPath}/room/search?roomType=DELUXE"
                               class="btn btn-sm btn-outline-primary"
                               style="transition: all 0.3s ease; border-width: 2px;">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 room-card" style="border-radius: 12px; overflow: hidden; border: none;">
                    <img src="https://source.unsplash.com/600x400/?hotel,suite" class="card-img-top" alt="Suite"
                         style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Executive Suite</h5>
                        <p class="card-text">Luxurious living space with separate bedroom and living area.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-primary">From $299/night</span>
                            <a href="${pageContext.request.contextPath}/room/search"
                               class="btn btn-sm btn-outline-primary"
                               style="transition: all 0.3s ease; border-width: 2px;">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-3">
                <div class="card h-100 room-card" style="border-radius: 12px; overflow: hidden; border: none;">
                    <img src="https://source.unsplash.com/600x400/?hotel,presidential" class="card-img-top" alt="Presidential Suite"
                         style="height: 200px; object-fit: cover;">
                    <div class="card-body">
                        <h5 class="card-title">Presidential Suite</h5>
                        <p class="card-text">Ultimate luxury with premium services and exclusive amenities.</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="fw-bold text-primary">From $499/night</span>
                            <a href="${pageContext.request.contextPath}/room/search"
                               class="btn btn-sm btn-outline-primary"
                               style="transition: all 0.3s ease; border-width: 2px;">
                                View
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/room/catalog"
               class="btn btn-primary btn-lg pulse"
               style="box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);">
                View All Rooms <i class="fas fa-arrow-right ms-2"></i>
            </a>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="bg-primary text-white py-5" style="position: relative; overflow: hidden;">
    <div class="container text-center" style="position: relative; z-index: 1;">
        <h2 class="fw-bold mb-4" style="text-shadow: 2px 2px 8px rgba(0,0,0,0.2);">Ready for an unforgettable experience?</h2>
        <p class="lead mb-4" style="text-shadow: 1px 1px 4px rgba(0,0,0,0.2);">Book your stay now and enjoy our exclusive member benefits</p>
        <a href="${pageContext.request.contextPath}/auth/register"
           class="btn btn-light btn-lg px-4 me-2"
           style="transition: all 0.4s ease; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
            <i class="fas fa-user-plus me-2"></i>Join Now
        </a>
        <a href="${pageContext.request.contextPath}/room/catalog"
           class="btn btn-outline-light btn-lg px-4"
           style="transition: all 0.4s ease; border-width: 2px;">
            <i class="fas fa-calendar-alt me-2"></i>Check Availability
        </a>
    </div>
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
         background: url('data:image/svg+xml;utf8,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 100 100\" preserveAspectRatio=\"none\"><path fill=\"rgba(255,255,255,0.05)\" d=\"M0,0 L100,0 L100,100 L0,100 Z\" /></svg>');
    background-size: cover; z-index: 0;"></div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5><i class="fas fa-hotel me-2"></i>PG64 Hotels</h5>
                <p style="transition: all 0.3s ease;">Providing exceptional hospitality services since 2023. Our mission is to make every stay memorable.</p>
            </div>
            <div class="col-md-2 mb-4 mb-md-0">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-white" style="transition: all 0.3s ease; display: inline-block;">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/room/catalog" class="text-white" style="transition: all 0.3s ease; display: inline-block;">Rooms</a></li>
                    <li><a href="${pageContext.request.contextPath}/service/catalog" class="text-white" style="transition: all 0.3s ease; display: inline-block;">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/booking/list" class="text-white" style="transition: all 0.3s ease; display: inline-block;">My Bookings</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-4 mb-md-0">
                <h5>Contact Us</h5>
                <ul class="list-unstyled">
                    <li style="transition: all 0.3s ease;"><i class="fas fa-map-marker-alt me-2"></i> 123 Hotel St, City</li>
                    <li style="transition: all 0.3s ease;"><i class="fas fa-phone me-2"></i> (123) 456-7890</li>
                    <li style="transition: all 0.3s ease;"><i class="fas fa-envelope me-2"></i> info@pg64hotels.com</li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5>Follow Us</h5>
                <div class="social-links">
                    <a href="#" class="text-white me-3" style="display: inline-block; transition: all 0.3s ease; transform: scale(1);">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="text-white me-3" style="display: inline-block; transition: all 0.3s ease; transform: scale(1);">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="text-white me-3" style="display: inline-block; transition: all 0.3s ease; transform: scale(1);">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="text-white" style="display: inline-block; transition: all 0.3s ease; transform: scale(1);">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
            </div>
        </div>
        <hr class="mt-4 mb-3" style="border-color: rgba(255,255,255,0.1);">
        <div class="text-center">
            <p class="mb-0" style="transition: all 0.3s ease;">&copy; 2023 PG64 Hotel Reservation System. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-hide toast after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const toast = document.querySelector('.toast');
        if (toast) {
            setTimeout(function() {
                const bsToast = new bootstrap.Toast(toast);
                bsToast.hide();
            }, 5000);
        }

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('scrolled');
            } else {
                document.querySelector('.navbar').classList.remove('scrolled');
            }
        });

        // Social icon hover effects
        const socialIcons = document.querySelectorAll('.social-links a');
        socialIcons.forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.2) translateY(-3px)';
            });
            icon.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });

        // Animate elements when they come into view
        const animateOnScroll = function() {
            const elements = document.querySelectorAll('.feature-card, .room-card, .btn-primary');
            elements.forEach(element => {
                const elementPosition = element.getBoundingClientRect().top;
                const screenPosition = window.innerHeight / 1.2;

                if (elementPosition < screenPosition) {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }
            });
        };

        // Set initial state for animation
        document.querySelectorAll('.feature-card, .room-card').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'all 0.6s ease';
        });

        window.addEventListener('scroll', animateOnScroll);
        animateOnScroll(); // Run once on load
    });

    // Keyframe animations
    const style = document.createElement('style');
    style.textContent = `
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
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    `;
    document.head.appendChild(style);
</script>
</body>
</html>