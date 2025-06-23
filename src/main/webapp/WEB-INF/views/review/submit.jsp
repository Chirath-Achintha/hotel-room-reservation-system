<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/templates/fragments/header.jsp"/>

<div class="container mt-5">
    <h2 class="mb-4">Submit Your Review</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/review/submit" method="post">
        <!-- Hidden room ID field -->
        <input type="hidden" name="roomId" value="${roomId}" />

        <!-- Rating -->
        <div class="mb-3">
            <label for="rating" class="form-label">Rating (1 to 5)</label>
            <select name="rating" id="rating" class="form-select" required>
                <c:forEach var="i" begin="1" end="5">
                    <option value="${i}">${i}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Comment -->
        <div class="mb-3">
            <label for="comment" class="form-label">Your Comments</label>
            <textarea name="comment" id="comment" class="form-control" rows="4" placeholder="Write your feedback..." required></textarea>
        </div>

        <!-- Type -->
        <div class="mb-3">
            <label for="type" class="form-label">Review Type</label>
            <select name="type" id="type" class="form-select" required>
                <option value="ROOM">Room</option>
                <option value="SERVICE">Service</option>
            </select>
        </div>

        <!-- Submit button -->
        <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
</div>

<jsp:include page="/templates/fragments/footer.jsp"/>
