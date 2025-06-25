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
    h1 {
        color: #764ba2;
        font-weight: 700;
        letter-spacing: 1px;
    }
    .card {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    .card:hover {
        transform: scale(1.04) translateY(-8px);
        box-shadow: 0 16px 32px rgba(0,0,0,0.13);
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.1rem;
    }
    .btn, .btn-primary, .btn-info, .btn-warning, .btn-danger {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-primary {
        background: linear-gradient(90deg, #a6c1ee 0%, #fbc2eb 100%);
        border: none;
    }
    .btn-info {
        background: linear-gradient(90deg, #66a6ff 0%, #89f7fe 100%);
        color: #fff;
        border: none;
    }
    .btn-warning {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
        color: #fff;
        border: none;
    }
    .btn-danger {
        background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
        color: #fff;
        border: none;
    }
    .btn:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
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
    .executive-header {
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%) !important;
    }
    .presidential-header {
        background: linear-gradient(90deg, #b8cbb8 0%, #b8cbb8 0%, #b465da 0%, #cf6cc9 33%, #ee609c 66%, #ee609c 100%) !important;
    }
    .feature-icon {
        margin-right: 8px;
        color: #4CAF50;
    }
    .price-tag {
        font-size: 1.5em;
        font-weight: bold;
        color: #764ba2;
    }
</style>

<div class="container mt-5">
    <h1 class="mb-4">Room Catalog</h1>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach var="room" items="${rooms}">
            <div class="col">
                <div class="card h-100">
                    <div class="card-header text-white
                        ${room['class'].simpleName == 'DeluxeRoom' ? 'bg-warning' : 
                          room['class'].simpleName == 'ExecutiveSuite' ? 'executive-header' :
                          room['class'].simpleName == 'PresidentialSuite' ? 'presidential-header' : 'bg-info'}">
                        <h5 class="card-title mb-0">
                            Room ${room.roomNumber} 
                            (${room['class'].simpleName == 'DeluxeRoom' ? 'DELUXE' : 
                               room['class'].simpleName == 'ExecutiveSuite' ? 'EXECUTIVE SUITE' :
                               room['class'].simpleName == 'PresidentialSuite' ? 'PRESIDENTIAL SUITE' : 'STANDARD'})
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">
                            <span class="price-tag">$${room.price}</span> per night<br>
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
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.hasJacuzzi() ? 'Jacuzzi Available' : 'No Jacuzzi'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.hasMinibar() ? 'Minibar Available' : 'No Minibar'}
                                        </li>
                                    </ul>
                                </c:when>
                                <c:when test="${room['class'].simpleName == 'ExecutiveSuite'}">
                                    <ul class="list-unstyled">
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasSeparateLivingRoom() ? 'Separate Living Room' : 'Open Plan Layout'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasWorkspace() ? 'Dedicated Workspace' : 'No Workspace'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasKitchenette() ? 'Kitchenette Available' : 'No Kitchenette'}
                                        </li>
                                    </ul>
                                </c:when>
                                <c:when test="${room['class'].simpleName == 'PresidentialSuite'}">
                                    <ul class="list-unstyled">
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasPrivatePool() ? 'Private Pool' : 'Shared Pool Access'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasButlerService() ? '24/7 Butler Service' : 'Room Service Available'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasPanoramicView() ? 'Panoramic City View' : 'City View'}
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.isHasPrivateDining() ? 'Private Dining Room' : 'In-Room Dining Available'}
                                        </li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <ul class="list-unstyled">
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
                                            ${room.numberOfBeds} Beds
                                        </li>
                                        <li><i class="bi bi-check-circle-fill feature-icon"></i> 
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
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/room/manage" class="btn btn-primary">
                <i class="bi bi-gear-fill"></i> Manage Rooms
            </a>
        </div>
    </c:if>
</div>

<jsp:include page="../fragments/footer.jsp"/>
