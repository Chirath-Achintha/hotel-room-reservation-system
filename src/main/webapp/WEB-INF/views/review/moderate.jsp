<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    body {
        min-height: 100vh;
        background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
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
    .card {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.2rem;
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%) !important;
        color: #fff !important;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .table {
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
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
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
    .btn-success {
        background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-success:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    .btn-danger {
        background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-danger:hover {
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
</style>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">Review Moderation</h3>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty reviews}">
                            <div class="alert alert-info">
                                No pending reviews to moderate.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Rating</th>
                                            <th>Details</th>
                                            <th>Comment</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${reviews}" var="review">
                                            <tr>
                                                <td>
                                                    <fmt:parseDate value="${review.reviewDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                                    <fmt:formatDate value="${parsedDate}" type="date" pattern="MMM dd, yyyy" />
                                                </td>
                                                <td>${review.type}</td>
                                                <td>
                                                    <span class="badge bg-info">${review.rating}/5</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${review['class'].simpleName == 'RoomReview'}">
                                                            <small>
                                                                <strong>Room ID:</strong> ${review.roomId}<br>
                                                                <strong>Cleanliness:</strong> ${review.cleanliness}<br>
                                                                <strong>Comfort:</strong> ${review.comfort}<br>
                                                                <strong>Location:</strong> ${review.location}
                                                            </small>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <small>
                                                                <strong>Service ID:</strong> ${review.serviceId}<br>
                                                                <strong>Staff:</strong> ${review.staffBehavior}<br>
                                                                <strong>Quality:</strong> ${review.serviceQuality}<br>
                                                                <strong>Value:</strong> ${review.valueForMoney}
                                                            </small>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div style="max-width: 300px;">
                                                        ${review.comment}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <form action="${pageContext.request.contextPath}/review/moderate/${review.reviewId}" method="post" style="display: inline;">
                                                            <input type="hidden" name="action" value="approve">
                                                            <button type="submit" class="btn btn-sm btn-success me-2">
                                                                <i class="bi bi-check-lg"></i> Approve
                                                            </button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/review/moderate/${review.reviewId}" method="post" style="display: inline;">
                                                            <input type="hidden" name="action" value="reject">
                                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to reject this review?')">
                                                                <i class="bi bi-x-lg"></i> Reject
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
