<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

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
                <option value="STANDARD" ${room['class'].simpleName == 'StandardRoom' ? 'selected' : ''}>Standard</option>
                <option value="DELUXE" ${room['class'].simpleName == 'DeluxeRoom' ? 'selected' : ''}>Deluxe</option>
            </select>
        </div>

        <!-- Standard Room Fields -->
        <div id="standardFields" style="display: ${room['class'].simpleName == 'StandardRoom' ? 'block' : 'none'};">
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
        <div id="deluxeFields" style="display: ${room['class'].simpleName == 'DeluxeRoom' ? 'block' : 'none'};">
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasJacuzzi" name="hasJacuzzi" ${room['class'].simpleName == 'DeluxeRoom' && room.hasJacuzzi() ? 'checked' : ''}>
                <label class="form-check-label" for="hasJacuzzi">Has Jacuzzi</label>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="hasMinibar" name="hasMinibar" ${room['class'].simpleName == 'DeluxeRoom' && room.hasMinibar() ? 'checked' : ''}>
                <label class="form-check-label" for="hasMinibar">Has Minibar</label>
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Update Room</button>
    </form>
</div>

<script>
function toggleRoomTypeFields() {
    const roomType = document.getElementById('roomType').value;
    const standardFields = document.getElementById('standardFields');
    const deluxeFields = document.getElementById('deluxeFields');
    if (roomType === 'STANDARD') {
        standardFields.style.display = 'block';
        deluxeFields.style.display = 'none';
    } else {
        standardFields.style.display = 'none';
        deluxeFields.style.display = 'block';
    }
}
</script>

<jsp:include page="../fragments/footer.jsp"/>
