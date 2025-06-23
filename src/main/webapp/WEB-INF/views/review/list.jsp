<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../fragments/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">
                        <c:choose>
                            <c:when test="${type == 'ROOM'}">Room Reviews</c:when>
                            <c:otherwise>Service Reviews</c:otherwise>
                        </c:choose>
                    </h3>
                    <c:if test="${not empty user}">
                        <c:choose>
                            <c:when test="${type == 'ROOM' && (not empty param.roomId || not empty roomId)}">
                                <a href="${pageContext.request.contextPath}/review/room/${not empty param.roomId ? param.roomId : roomId}" class="btn btn-light">Write Review</a>
                            </c:when>
                            <c:when test="${type == 'SERVICE' && not empty param.serviceId}">
                                <a href="${pageContext.request.contextPath}/review/service/${param.serviceId}" class="btn btn-light">Write Review</a>
                            </c:when>
                        </c:choose>
                    </c:if>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty reviews}">
                            <div class="alert alert-info">
                                No reviews available yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="row row-cols-1 row-cols-md-2 g-4">
                                <c:forEach items="${reviews}" var="review">
                                    <div class="col">
                                        <div class="card h-100">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <div>
                                                        <h5 class="card-title mb-0">Rating: ${review.rating}/5</h5>
                                                        <small class="text-muted">
                                                            ${review.reviewDate}
                                                        </small>
                                                    </div>
                                                    <span class="badge bg-${review.status == 'APPROVED' ? 'success' : 'warning'}">
                                                        ${review.status}
                                                    </span>
                                                </div>

                                                <p class="card-text">${review.comment}</p>

                                                <c:choose>
                                                    <c:when test="${review.type == 'ROOM'}">
                                                        <div class="mt-3">
                                                            <p class="mb-1"><strong>Cleanliness:</strong> ${review.cleanliness}</p>
                                                            <p class="mb-1"><strong>Comfort:</strong> ${review.comfort}</p>
                                                            <p class="mb-1"><strong>Location:</strong> ${review.location}</p>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="mt-3">
                                                            <p class="mb-1"><strong>Service Quality:</strong> ${review.serviceQualityRating}</p>
                                                            <p class="mb-1"><strong>Staff Courtesy:</strong> ${review.staffCourtesyRating}</p>
                                                            <p class="mb-1"><strong>Value for Money:</strong> ${review.valueForMoneyRating}</p>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <c:if test="${user.id == review.userId || user['class'].simpleName == 'AdminUser'}">
                                                <div class="card-footer bg-transparent">
                                                    <div class="d-flex justify-content-end gap-2">
                                                        <form action="${pageContext.request.contextPath}/review/delete/${review.reviewId}?roomId=${review.roomId}" method="post" style="display: inline;">
                                                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this review?')">Delete</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
