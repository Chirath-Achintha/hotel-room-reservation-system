<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../fragments/header.jsp"/>

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