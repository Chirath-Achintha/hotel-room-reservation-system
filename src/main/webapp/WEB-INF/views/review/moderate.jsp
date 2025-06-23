<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../fragments/header.jsp"/>

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
