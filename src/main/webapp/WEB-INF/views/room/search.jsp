<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../fragments/header.jsp"/>

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
