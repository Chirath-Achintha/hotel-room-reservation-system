<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    h2 {
        color: #764ba2;
        font-weight: 700;
        letter-spacing: 1px;
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
    .alert-info {
        animation: fadeInAlert 0.7s;
    }
    @keyframes fadeInAlert {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
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
</style>

<div class="container mt-5">
    <h2 class="mb-4">Search Rooms</h2>

    <form action="${pageContext.request.contextPath}/room/search" method="get" class="row g-3 mb-4">
        <div class="col-md-4">
            <label class="form-label">Room Type</label>
            <select name="roomType" class="form-select">
                <option value="">Any</option>
                <option value="STANDARD">Standard</option>
                <option value="DELUXE">Deluxe</option>
            </select>
        </div>

        <div class="col-md-4">
            <label class="form-label">Max Price (Rs.)</label>
            <input type="number" name="maxPrice" class="form-control" step="0.01" />
        </div>

        <div class="col-md-4 d-flex align-items-end">
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>

    <c:if test="${empty results}">
        <div class="alert alert-info">No rooms found matching your criteria.</div>
    </c:if>

    <div class="row">
        <c:forEach var="room" items="${results}">
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">Room ${room.roomNumber} (${room.roomType})</h5>
                        <p class="card-text">
                            Price: Rs. ${room.price} <br/>
                            Status:
                            <span class="${room.available ? 'text-success' : 'text-danger'}">
                                    ${room.available ? 'Available' : 'Not Available'}
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
