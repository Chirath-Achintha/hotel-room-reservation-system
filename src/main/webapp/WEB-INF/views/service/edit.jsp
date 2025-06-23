<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Service</title>
    <style>
        body { font-family: Arial; background: #fffbe6; padding: 20px; }
        form { max-width: 400px; margin: auto; background: #fff3cd; padding: 20px; border-radius: 10px; }
        input, textarea { width: 100%; padding: 8px; margin: 10px 0; }
        button { background: #ff9800; color: white; padding: 10px 15px; border: none; cursor: pointer; }
    </style>
</head>
<body>
<h2>Edit Service</h2>

<form action="${pageContext.request.contextPath}/service/update" method="post">
    <input type="hidden" name="serviceId" value="${service.serviceId}" />
    <div class="form-group">
        <label for="type">Service Type:</label>
        <select name="type" id="type" required>
            <option value="RoomService" ${service.getClass().getSimpleName() == 'RoomService' ? 'selected' : ''}>Room Service</option>
            <option value="SpaService" ${service.getClass().getSimpleName() == 'SpaService' ? 'selected' : ''}>Spa Service</option>
            <option value="LaundryService" ${service.getClass().getSimpleName() == 'LaundryService' ? 'selected' : ''}>Laundry Service</option>
        </select>
    </div>
    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" value="${service.name}" required />
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea name="description" id="description" required>${service.description}</textarea>
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" name="price" id="price" step="0.01" value="${service.price}" required />
    </div>
    <div class="form-group">
        <label for="available">Available:</label>
        <input type="checkbox" name="available" id="available" ${service.available ? 'checked' : ''} />
    </div>
    <button type="submit">Save Changes</button>
</form>

<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>
</body>
</html>
