<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/templates/fragments/header.jsp"/>

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
    .alert-danger {
        animation: fadeInAlert 0.7s;
    }
    @keyframes fadeInAlert {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
    }
</style>

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
