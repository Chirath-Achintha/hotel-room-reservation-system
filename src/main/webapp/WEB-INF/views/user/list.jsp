<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

<div class="container mt-5">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3 class="mb-0">User Management</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                                Admin (${user.adminLevel})
                                            </c:when>
                                            <c:when test="${user['class'].simpleName == 'PremiumUser'}">
                                                Premium
                                            </c:when>
                                            <c:when test="${user['class'].simpleName == 'RegularUser' && user.premium}">
                                                Regular (Premium)
                                            </c:when>
                                            <c:otherwise>
                                                Regular
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>Active</td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <c:choose>
                                                <c:when test="${user['class'].simpleName == 'AdminUser'}">
                                                    <a href="${pageContext.request.contextPath}/user/edit/admin/${user.id}" 
                                                       class="btn btn-sm btn-warning">Edit</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/user/edit/${user.id}" 
                                                       class="btn btn-sm btn-warning">Edit</a>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${user['class'].simpleName == 'RegularUser'}">
                                                <form action="${pageContext.request.contextPath}/user/upgrade/${user.id}" 
                                                      method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-sm btn-success ms-1"
                                                            ${user.premium ? 'disabled' : ''}>
                                                        ${user.premium ? 'Premium' : 'Upgrade to Premium'}
                                                    </button>
                                                </form>
                                            </c:if>
                                            
                                            <c:if test="${user['class'].simpleName != 'AdminUser'}">
                                                <form action="${pageContext.request.contextPath}/user/delete/${user.id}" 
                                                      method="post" style="display: inline;"
                                                      onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                    <button type="submit" class="btn btn-sm btn-danger ms-1">Delete</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Back to Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
