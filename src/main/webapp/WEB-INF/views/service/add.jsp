<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add New Service</title>
    <style>
        body { font-family: Arial; background: #fffbe6; padding: 20px; }
        form { max-width: 400px; margin: auto; background: #fff3cd; padding: 20px; border-radius: 10px; }
        input, textarea { width: 100%; padding: 8px; margin: 10px 0; }
        button { background: #ff9800; color: white; padding: 10px 15px; border: none; cursor: pointer; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>Add New Service</h2>

<form action="${pageContext.request.contextPath}/service/add" method="post">
    <div class="form-group">
        <label for="type">Service Type:</label>
        <select name="type" id="type" required>
            <option value="RoomService">Room Service</option>
            <option value="SpaService">Spa Service</option>
            <option value="LaundryService">Laundry Service</option>
        </select>
    </div>
    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" required />
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea name="description" id="description" required></textarea>
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" name="price" id="price" step="0.01" required />
    </div>
    <button type="submit">Add Service</button>
</form>

<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>
</body>
</html>
