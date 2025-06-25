<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Service</title>
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
        form {
            max-width: 450px;
            margin: 40px auto;
            background: rgba(255,255,255,0.95);
            padding: 32px 28px 24px 28px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.13);
            animation: slideIn 1s cubic-bezier(.68,-0.55,.27,1.55);
        }
        @keyframes slideIn {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        h2 {
            text-align: center;
            color: #ff9800;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }
        label {
            color: #4a5568;
            font-weight: 500;
        }
        input, textarea, select {
            border-radius: 8px;
            border: 1px solid #b3c6e0;
            padding: 10px;
            margin-bottom: 14px;
            transition: border 0.3s, box-shadow 0.3s;
        }
        input:focus, textarea:focus, select:focus {
            border-color: #ff9800;
            box-shadow: 0 0 0 2px #ff980055;
        }
        button {
            background: linear-gradient(90deg, #ff9800 0%, #ffd200 100%);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
        }
        button:hover {
            filter: brightness(1.1);
            transform: scale(1.07);
            box-shadow: 0 4px 16px rgba(0,0,0,0.13);
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
