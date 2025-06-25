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
    h2, h4 {
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
    .btn-primary, .btn-success, .btn-secondary, .btn-warning, .btn-danger {
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
    .btn-success {
        background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
        border: none;
    }
    .btn-secondary {
        background: #b3c6e0;
        color: #333;
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
    .alert-info {
        animation: fadeInAlert 0.7s;
    }
    @keyframes fadeInAlert {
        from { opacity: 0; transform: scale(0.95); }
        to { opacity: 1; transform: scale(1); }
    }
    table {
        background: rgba(255,255,255,0.95);
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        overflow: hidden;
        animation: tableFadeIn 1s;
    }
    @keyframes tableFadeIn {
        from { opacity: 0; transform: scale(0.97); }
        to { opacity: 1; transform: scale(1); }
    }
    th, td {
        padding: 14px 18px;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background: linear-gradient(90deg, #fbc2eb 0%, #a6c1ee 100%);
        color: #fff;
        font-weight: 600;
        letter-spacing: 0.5px;
        border: none;
    }
    tr {
        transition: background 0.3s, transform 0.2s;
    }
    tr:hover {
        background: #e0c3fc;
        transform: scale(1.01);
    }
</style>

<div class="container mt-5">
    <h2 class="mb-4">Feedback</h2>
    <c:choose>
        <c:when test="${not empty editFeedback}">
            <!-- Edit Feedback Form -->
            <form action="${pageContext.request.contextPath}/feedback/edit" method="post" class="mb-4">
                <input type="hidden" name="index" value="${editIndex}" />
                <div class="mb-3">
                    <label for="feedback" class="form-label">Edit Your Feedback</label>
                    <textarea name="feedback" id="feedback" class="form-control" rows="3" required>${editFeedback.feedback}</textarea>
                </div>
                <div class="mb-3">
                    <label for="rating" class="form-label">Rating</label>
                    <select name="rating" id="rating" class="form-select" required>
                        <c:forEach var="i" begin="1" end="5">
                            <option value="${i}" <c:if test="${editFeedback.rating == i}">selected</c:if>>${i} Star<c:if test="${i > 1}">s</c:if></option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Update Feedback</button>
                <a href="${pageContext.request.contextPath}/feedback" class="btn btn-secondary ms-2">Cancel</a>
            </form>
        </c:when>
        <c:otherwise>
            <!-- Add Feedback Form -->
            <form action="${pageContext.request.contextPath}/feedback" method="post" class="mb-4">
                <div class="mb-3">
                    <label for="feedback" class="form-label">Your Feedback</label>
                    <textarea name="feedback" id="feedback" class="form-control" rows="3" placeholder="Write your experience here..." required></textarea>
                </div>
                <div class="mb-3">
                    <label for="rating" class="form-label">Rating</label>
                    <select name="rating" id="rating" class="form-select" required>
                        <c:forEach var="i" begin="1" end="5">
                            <option value="${i}">${i} Star<c:if test="${i > 1}">s</c:if></option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add Feedback</button>
            </form>
        </c:otherwise>
    </c:choose>
    <c:if test="${not empty message}">
        <div class="alert alert-info mt-3">${message}</div>
    </c:if>
    <h4 class="mt-5">All Feedback</h4>
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>#</th>
                <th>User</th>
                <th>Rating</th>
                <th>Feedback</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty feedbackList}">
                <tr>
                    <td colspan="5" class="text-center">No feedback yet.</td>
                </tr>
            </c:if>
            <c:forEach var="item" items="${feedbackList}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${item.username}</td>
                    <td>
                        <c:forEach var="i" begin="1" end="${item.rating}">
                            <span style="color:gold;">&#9733;</span>
                        </c:forEach>
                        <c:forEach var="i" begin="1" end="${5 - item.rating}">
                            <span style="color:#ccc;">&#9733;</span>
                        </c:forEach>
                        (${item.rating})
                    </td>
                    <td>${item.feedback}</td>
                    <td>
                        <c:if test="${currentUser == item.username}">
                            <form action="${pageContext.request.contextPath}/feedback" method="get" style="display:inline;">
                                <input type="hidden" name="edit" value="${status.index}" />
                                <button type="submit" class="btn btn-warning btn-sm">Edit</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/feedback/delete" method="post" style="display:inline;">
                                <input type="hidden" name="index" value="${status.index}" />
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete this feedback?');">Delete</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../fragments/footer.jsp"/> 