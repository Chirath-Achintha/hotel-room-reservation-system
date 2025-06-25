<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    h2 {
        color: #3498db;
        font-weight: 700;
        letter-spacing: 1px;
    }
    .card {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .form-label {
        color: #4a5568;
        font-weight: 500;
    }
    .form-control, .form-select {
        border-radius: 8px;
        border: 1px solid #b3c6e0;
        transition: border 0.3s, box-shadow 0.3s;
    }
    .form-control:focus, .form-select:focus {
        border-color: #a1c4fd;
        box-shadow: 0 0 0 2px #a1c4fd55;
    }
    .btn-primary {
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
        border: none;
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-primary:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    .room-type-fields {
        padding: 15px;
        border-radius: 12px;
        background: rgba(161, 196, 253, 0.1);
        margin-bottom: 20px;
        transition: all 0.3s ease;
    }
    .room-type-fields:hover {
        background: rgba(161, 196, 253, 0.2);
    }
    .form-check {
        margin-bottom: 10px;
    }
    .form-check-input:checked {
        background-color: #3498db;
        border-color: #3498db;
    }
</style>

<div class="container mt-5">
    <h2 class="mb-4">Edit Room</h2>

    <form action="${pageContext.request.contextPath}/room/update" method="post">
        <input type="hidden" name="roomId" value="${room.roomId}" />

        <div class="mb-3">
            <label class="form-label">Room Number</label>
            <input type="text" name="roomNumber" value="${room.roomNumber}" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Price (Rs.)</label>
            <input type="number" name="price" value="${room.price}" step="0.01" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Availability</label>
            <select name="available" class="form-select">
                <option value="true" ${room.available ? 'selected' : ''}>Available</option>
                <option value="false" ${!room.available ? 'selected' : ''}>Not Available</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Room Type</label>
            <select name="roomType" class="form-select" id="roomType" onchange="toggleRoomTypeFields()">
                <option value="STANDARD" ${room['class'].simpleName == 'StandardRoom' ? 'selected' : ''}>Standard Room</option>
                <option value="DELUXE" ${room['class'].simpleName == 'DeluxeRoom' ? 'selected' : ''}>Deluxe Room</option>
                <option value="EXECUTIVE" ${room['class'].simpleName == 'ExecutiveSuite' ? 'selected' : ''}>Executive Suite</option>
                <option value="PRESIDENTIAL" ${room['class'].simpleName == 'PresidentialSuite' ? 'selected' : ''}>Presidential Suite</option>
            </select>
        </div>

        <!-- Standard Room Fields -->
        <div id="standardFields" class="room-type-fields" style="display: ${room['class'].simpleName == 'StandardRoom' ? 'block' : 'none'};">
            <div class="mb-3">
                <label class="form-label">Number of Beds</label>
                <input type="number" name="numberOfBeds" value="${room['class'].simpleName == 'StandardRoom' ? room.numberOfBeds : ''}" min="1" class="form-control" />
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasBalcony" name="hasBalcony" ${room['class'].simpleName == 'StandardRoom' && room.hasBalcony() ? 'checked' : ''}>
                <label class="form-check-label" for="hasBalcony">Has Balcony</label>
            </div>
        </div>

        <!-- Deluxe Room Fields -->
        <div id="deluxeFields" class="room-type-fields" style="display: ${room['class'].simpleName == 'DeluxeRoom' ? 'block' : 'none'};">
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasJacuzzi" name="hasJacuzzi" ${room['class'].simpleName == 'DeluxeRoom' && room.hasJacuzzi() ? 'checked' : ''}>
                <label class="form-check-label" for="hasJacuzzi">Has Jacuzzi</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasMinibar" name="hasMinibar" ${room['class'].simpleName == 'DeluxeRoom' && room.hasMinibar() ? 'checked' : ''}>
                <label class="form-check-label" for="hasMinibar">Has Minibar</label>
            </div>
        </div>

        <!-- Executive Suite Fields -->
        <div id="executiveFields" class="room-type-fields" style="display: ${room['class'].simpleName == 'ExecutiveSuite' ? 'block' : 'none'};">
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasSeparateLivingRoom" name="hasSeparateLivingRoom" 
                    ${room['class'].simpleName == 'ExecutiveSuite' && room.isHasSeparateLivingRoom() ? 'checked' : ''}>
                <label class="form-check-label" for="hasSeparateLivingRoom">Separate Living Room</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasWorkspace" name="hasWorkspace"
                    ${room['class'].simpleName == 'ExecutiveSuite' && room.isHasWorkspace() ? 'checked' : ''}>
                <label class="form-check-label" for="hasWorkspace">Dedicated Workspace</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasKitchenette" name="hasKitchenette"
                    ${room['class'].simpleName == 'ExecutiveSuite' && room.isHasKitchenette() ? 'checked' : ''}>
                <label class="form-check-label" for="hasKitchenette">Kitchenette</label>
            </div>
        </div>

        <!-- Presidential Suite Fields -->
        <div id="presidentialFields" class="room-type-fields" style="display: ${room['class'].simpleName == 'PresidentialSuite' ? 'block' : 'none'};">
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasPrivatePool" name="hasPrivatePool"
                    ${room['class'].simpleName == 'PresidentialSuite' && room.hasPrivatePool() ? 'checked' : ''}>
                <label class="form-check-label" for="hasPrivatePool">Private Pool</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasButlerService" name="hasButlerService"
                    ${room['class'].simpleName == 'PresidentialSuite' && room.hasButlerService() ? 'checked' : ''}>
                <label class="form-check-label" for="hasButlerService">24/7 Butler Service</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasPanoramicView" name="hasPanoramicView"
                    ${room['class'].simpleName == 'PresidentialSuite' && room.hasPanoramicView() ? 'checked' : ''}>
                <label class="form-check-label" for="hasPanoramicView">Panoramic View</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasPrivateDining" name="hasPrivateDining"
                    ${room['class'].simpleName == 'PresidentialSuite' && room.hasPrivateDining() ? 'checked' : ''}>
                <label class="form-check-label" for="hasPrivateDining">Private Dining Room</label>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Update Room</button>
    </form>
</div>

<script>
function toggleRoomTypeFields() {
    const roomType = document.getElementById('roomType').value;
    const allFields = document.querySelectorAll('.room-type-fields');
    allFields.forEach(field => field.style.display = 'none');

    switch(roomType) {
        case 'STANDARD':
            document.getElementById('standardFields').style.display = 'block';
            break;
        case 'DELUXE':
            document.getElementById('deluxeFields').style.display = 'block';
            break;
        case 'EXECUTIVE':
            document.getElementById('executiveFields').style.display = 'block';
            break;
        case 'PRESIDENTIAL':
            document.getElementById('presidentialFields').style.display = 'block';
            break;
    }
}

// Initialize fields on page load
document.addEventListener('DOMContentLoaded', function() {
    toggleRoomTypeFields();
});
</script>

<jsp:include page="../fragments/footer.jsp"/>
