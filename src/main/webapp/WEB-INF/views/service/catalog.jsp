<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Service Catalog</title>
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
        h2 {
            text-align: center;
            color: #ff9800;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        table {
            width: 90%;
            margin: 40px auto;
            border-collapse: collapse;
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
            border: 1px solid #ccc;
            padding: 14px 18px;
            text-align: left;
        }
        th {
            background: linear-gradient(90deg, #ff9800 0%, #ffd200 100%);
            color: #fff;
            font-weight: 600;
            letter-spacing: 0.5px;
            border: none;
        }
        tr {
            transition: background 0.3s, transform 0.2s;
        }
        tr:hover {
            background: #ffe082;
            transform: scale(1.01);
        }
        .actions button, .actions form button, a > button {
            background: linear-gradient(90deg, #ff9800 0%, #ffd200 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            padding: 8px 14px;
            margin-right: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        .actions button:hover, .actions form button:hover, a > button:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
        }
        .actions {
            text-align: center;
        }
        .error {
            color: #e74c3c;
            margin-top: 10px;
            text-align: center;
            animation: fadeInAlert 0.7s;
        }
        @keyframes fadeInAlert {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }
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
