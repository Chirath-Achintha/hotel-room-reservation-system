<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Service Catalog</title>
    <style>
        body { font-family: Arial; background: #fffde7; padding: 20px; }
        table { width: 90%; margin: auto; border-collapse: collapse; background: #fff3cd; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background: #ffe082; }
        .actions button { background: #ffa000; color: white; border: none; padding: 5px 10px; margin-right: 5px; }
    </style>
</head>
<body>
<h2>Service Catalog</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Available</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="service" items="${services}">
        <tr>
            <td>${service.serviceId}</td>
            <td>${service.name}</td>
            <td>${service.description}</td>
            <td>$${service.price}</td>
            <td><c:choose>
                <c:when test="${service.available}">Yes</c:when>
                <c:otherwise>No</c:otherwise>
            </c:choose></td>
            <td class="actions">
                <c:if test="${user['class'].simpleName == 'AdminUser'}">
                    <form method="get" action="${pageContext.request.contextPath}/service/edit/${service.serviceId}" style="display:inline;">
                        <button type="submit">Edit</button>
                    </form>
                    <form method="post" action="${pageContext.request.contextPath}/service/delete/${service.serviceId}" style="display:inline;">
                        <button type="submit" onclick="return confirm('Delete this service?')">Delete</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div style="text-align: center; margin-top: 20px;">
    <c:if test="${user['class'].simpleName == 'AdminUser'}">
        <a href="${pageContext.request.contextPath}/service/add"><button>Add New Service</button></a>
    </c:if>
</div>
</body>
</html>
