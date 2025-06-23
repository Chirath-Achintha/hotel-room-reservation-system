<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../fragments/header.jsp"/>

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
                                    <td>${room['class'].simpleName == 'DeluxeRoom' ? 'Deluxe' : 'Standard'}</td>
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
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="price" class="form-label">Price per Night</label>
                        <input type="number" class="form-control" id="price" name="price" step="0.01" required>
                    </div>
                    
                    <!-- Standard Room Fields -->
                    <div id="standardFields">
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
                    <div id="deluxeFields" style="display: none;">
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasJacuzzi" name="hasJacuzzi">
                            <label class="form-check-label" for="hasJacuzzi">Has Jacuzzi</label>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="hasMinibar" name="hasMinibar">
                            <label class="form-check-label" for="hasMinibar">Has Minibar</label>
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

function editRoom(roomId) {
    // Implement room editing functionality
    window.location.href = '${pageContext.request.contextPath}/room/edit/' + roomId;
}
</script>

<jsp:include page="../fragments/footer.jsp"/> 