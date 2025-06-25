<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    .card {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.10);
        background: rgba(255,255,255,0.95);
        transition: transform 0.3s, box-shadow 0.3s;
        opacity: 0;
        animation: cardFadeIn 0.9s forwards;
    }
    .card-header {
        border-radius: 18px 18px 0 0;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 1.2rem;
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%) !important;
        color: #fff !important;
    }
    @keyframes cardFadeIn {
        to { opacity: 1; }
    }
    .btn, .btn-primary, .btn-light, .btn-warning, .btn-secondary, .btn-success, .btn-danger {
        border-radius: 8px;
        font-weight: 600;
        letter-spacing: 0.5px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        transition: background 0.3s, color 0.3s, box-shadow 0.3s, transform 0.2s;
    }
    .btn-primary {
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
        border: none;
    }
    .btn-light {
        background: #b3c6e0;
        color: #333;
        border: none;
    }
    .btn-light:hover {
        background: #a1c4fd;
        color: #222;
    }
    .btn-warning {
        background: linear-gradient(90deg, #f7971e 0%, #ffd200 100%);
        color: #fff;
        border: none;
    }
    .btn-secondary {
        background: #b3c6e0;
        color: #333;
        border: none;
    }
    .btn-success {
        background: linear-gradient(90deg, #43cea2 0%, #185a9d 100%);
        color: #fff;
        border: none;
    }
    .btn-danger {
        background: linear-gradient(90deg, #ff5858 0%, #f09819 100%);
        color: #fff;
        border: none;
    }
    .btn:hover {
        filter: brightness(1.1);
        transform: scale(1.07);
        box-shadow: 0 4px 16px rgba(0,0,0,0.13);
    }
    .badge {
        font-size: 1em;
        padding: 0.5em 1em;
        border-radius: 8px;
        animation: badgePop 0.7s;
    }
    @keyframes badgePop {
        from { transform: scale(0.7); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }
    .table {
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
        padding: 14px 18px;
        text-align: center;
        vertical-align: middle;
    }
    th {
        background: linear-gradient(90deg, #a1c4fd 0%, #c2e9fb 100%);
        color: #fff;
        font-weight: 600;
        letter-spacing: 0.5px;
        border: none;
    }
    tr {
        transition: background 0.3s, transform 0.2s;
    }
    tr:hover {
        background: #e0c3fc;
        transform: scale(1.01);
    }
    .modal-content {
        border-radius: 18px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.13);
        background: rgba(255,255,255,0.98);
        animation: modalFadeIn 0.7s;
    }
    @keyframes modalFadeIn {
        from { opacity: 0; transform: scale(0.97); }
        to { opacity: 1; transform: scale(1); }
    }
</style>

<div class="container mt-5">
    <!-- Room Search Form -->
    <form class="row mb-4" action="${pageContext.request.contextPath}/room/manage" method="get">
        <div class="col-md-4">
            <input type="text" class="form-control" name="searchQuery" placeholder="Search by Room ID or Number" value="${param.searchQuery != null ? param.searchQuery : ''}" />
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary">Find Room</button>
        </div>
    </form>
    <!-- End Room Search Form -->
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">Room Management</h3>
                    <button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                        Add New Room
                    </button>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            ${success}
                        </div>
                    </c:if>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Room ID</th>
                                <th>Room Number</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Features</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="room" items="${rooms}">
                                <tr>
                                    <td>${room.roomId}</td>
                                    <td>${room.roomNumber}</td>
                                    <td>${room['class'].simpleName == 'DeluxeRoom' ? 'Deluxe' : 
                                         room['class'].simpleName == 'ExecutiveSuite' ? 'Executive Suite' :
                                         room['class'].simpleName == 'PresidentialSuite' ? 'Presidential Suite' : 'Standard'}</td>
                                    <td>$${room.price}</td>
                                    <td>
                                        <span class="badge ${room.available ? 'bg-success' : 'bg-danger'}">
                                            ${room.available ? 'Available' : 'Occupied'}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${room['class'].simpleName == 'DeluxeRoom'}">
                                                ${room.hasJacuzzi() ? 'Jacuzzi, ' : ''}
                                                ${room.hasMinibar() ? 'Minibar' : ''}
                                            </c:when>
                                            <c:when test="${room['class'].simpleName == 'ExecutiveSuite'}">
                                                ${room.isHasSeparateLivingRoom() ? 'Separate Living Room, ' : ''}
                                                ${room.isHasWorkspace() ? 'Workspace, ' : ''}
                                                ${room.isHasKitchenette() ? 'Kitchenette' : ''}
                                            </c:when>
                                            <c:when test="${room['class'].simpleName == 'PresidentialSuite'}">
                                                ${room.isHasPrivatePool() ? 'Private Pool, ' : ''}
                                                ${room.isHasButlerService() ? 'Butler Service, ' : ''}
                                                ${room.isHasPanoramicView() ? 'Panoramic View, ' : ''}
                                                ${room.isHasPrivateDining() ? 'Private Dining' : ''}
                                            </c:when>
                                            <c:otherwise>
                                                ${room.numberOfBeds} Beds
                                                ${room.hasBalcony() ? ', Balcony' : ''}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button type="button" class="btn btn-sm btn-warning"
                                                    onclick="editRoom(${room.roomId})">Edit</button>
                                            <form action="${pageContext.request.contextPath}/room/toggle/${room.roomId}" 
                                                  method="post" style="display: inline;">
                                                <button type="submit" class="btn btn-sm ${room.available ? 'btn-secondary' : 'btn-success'} ms-1">
                                                    ${room.available ? 'Mark Occupied' : 'Mark Available'}
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/room/delete/${room.roomId}" 
                                                  method="post" style="display: inline;"
                                                  onsubmit="return confirm('Are you sure you want to delete this room?');">
                                                <button type="submit" class="btn btn-sm btn-danger ms-1">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Room Modal -->
<div class="modal fade" id="addRoomModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Room</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/room/add" method="post" id="addRoomForm">
                    <div class="mb-3">
                        <label for="roomNumber" class="form-label">Room Number</label>
                        <input type="text" class="form-control" id="roomNumber" name="roomNumber" required>
                    </div>
                    <div class="mb-3">
                        <label for="roomType" class="form-label">Room Type</label>
                        <select class="form-select" id="roomType" name="roomType" onchange="toggleRoomTypeFields()">
                            <option value="STANDARD">Standard Room</option>
                            <option value="DELUXE">Deluxe Room</option>
                            <option value="EXECUTIVE">Executive Suite</option>
                            <option value="PRESIDENTIAL">Presidential Suite</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price per Night</label>
                        <input type="number" class="form-control" id="price" name="price" required min="0" step="0.01">
                    </div>
                    
                    <!-- Standard Room Fields -->
                    <div id="standardFields" class="room-type-fields">
                        <div class="mb-3">
                            <label for="numberOfBeds" class="form-label">Number of Beds</label>
                            <input type="number" class="form-control" id="numberOfBeds" name="numberOfBeds" min="1">
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasBalcony" name="hasBalcony">
                            <label class="form-check-label" for="hasBalcony">Has Balcony</label>
                        </div>
                    </div>
                    
                    <!-- Deluxe Room Fields -->
                    <div id="deluxeFields" class="room-type-fields" style="display: none;">
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasJacuzzi" name="hasJacuzzi">
                            <label class="form-check-label" for="hasJacuzzi">Has Jacuzzi</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasMinibar" name="hasMinibar">
                            <label class="form-check-label" for="hasMinibar">Has Minibar</label>
                        </div>
                    </div>

                    <!-- Executive Suite Fields -->
                    <div id="executiveFields" class="room-type-fields" style="display: none;">
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasSeparateLivingRoom" name="hasSeparateLivingRoom">
                            <label class="form-check-label" for="hasSeparateLivingRoom">Separate Living Room</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasWorkspace" name="hasWorkspace">
                            <label class="form-check-label" for="hasWorkspace">Dedicated Workspace</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasKitchenette" name="hasKitchenette">
                            <label class="form-check-label" for="hasKitchenette">Kitchenette</label>
                        </div>
                    </div>

                    <!-- Presidential Suite Fields -->
                    <div id="presidentialFields" class="room-type-fields" style="display: none;">
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasPrivatePool" name="hasPrivatePool">
                            <label class="form-check-label" for="hasPrivatePool">Private Pool</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasButlerService" name="hasButlerService">
                            <label class="form-check-label" for="hasButlerService">24/7 Butler Service</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasPanoramicView" name="hasPanoramicView">
                            <label class="form-check-label" for="hasPanoramicView">Panoramic View</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasPrivateDining" name="hasPrivateDining">
                            <label class="form-check-label" for="hasPrivateDining">Private Dining Room</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="addRoomForm" class="btn btn-primary">Add Room</button>
            </div>
        </div>
    </div>
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

function editRoom(roomId) {
    // Implement room editing functionality
    window.location.href = '${pageContext.request.contextPath}/room/edit/' + roomId;
}
</script>

<jsp:include page="../fragments/footer.jsp"/> 