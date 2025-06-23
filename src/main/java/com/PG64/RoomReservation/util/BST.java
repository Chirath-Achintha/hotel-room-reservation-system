package com.PG64.RoomReservation.util;

import com.PG64.RoomReservation.model.Room;

import java.util.ArrayList;
import java.util.List;

public class BST {
    private Node root;

    private class Node {
        Room room;
        Node left;
        Node right;

        Node(Room room) {
            this.room = room;
            left = right = null;
        }
    }

    // Insert a room into the BST
    public void insert(Room room) {
        root = insertRec(root, room);
    }

    private Node insertRec(Node root, Room room) {
        if (root == null) {
            return new Node(room);
        }

        if (room.getRoomId() < root.room.getRoomId()) {
            root.left = insertRec(root.left, room);
        } else if (room.getRoomId() > root.room.getRoomId()) {
            root.right = insertRec(root.right, room);
        }

        return root;
    }

    // Search for a room by ID
    public Room search(int roomId) {
        Node result = searchRec(root, roomId);
        return result == null ? null : result.room;
    }

    private Node searchRec(Node root, int roomId) {
        if (root == null || root.room.getRoomId() == roomId) {
            return root;
        }

        if (roomId < root.room.getRoomId()) {
            return searchRec(root.left, roomId);
        }

        return searchRec(root.right, roomId);
    }

    // Delete a room
    public void delete(int roomId) {
        root = deleteRec(root, roomId);
    }

    private Node deleteRec(Node root, int roomId) {
        if (root == null) {
            return null;
        }

        if (roomId < root.room.getRoomId()) {
            root.left = deleteRec(root.left, roomId);
        } else if (roomId > root.room.getRoomId()) {
            root.right = deleteRec(root.right, roomId);
        } else {
            // Node with only one child or no child
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }

            // Node with two children: Get the inorder successor (smallest in the right subtree)
            root.room = minValue(root.right);
            root.right = deleteRec(root.right, root.room.getRoomId());
        }

        return root;
    }

    private Room minValue(Node root) {
        Room minv = root.room;
        while (root.left != null) {
            minv = root.left.room;
            root = root.left;
        }
        return minv;
    }

    // Get all rooms (in-order traversal)
    public List<Room> inOrderTraversal() {
        List<Room> rooms = new ArrayList<>();
        inOrderTraversalRec(root, rooms);
        return rooms;
    }

    private void inOrderTraversalRec(Node root, List<Room> rooms) {
        if (root != null) {
            inOrderTraversalRec(root.left, rooms);
            rooms.add(root.room);
            inOrderTraversalRec(root.right, rooms);
        }
    }

    // Search rooms by price range
    public List<Room> searchByPriceRange(double minPrice, double maxPrice) {
        List<Room> result = new ArrayList<>();
        searchByPriceRangeRec(root, minPrice, maxPrice, result);
        return result;
    }

    private void searchByPriceRangeRec(Node root, double minPrice, double maxPrice, List<Room> result) {
        if (root == null) {
            return;
        }

        // If current node's price is greater than minPrice, then rooms in left subtree may qualify
        if (minPrice < root.room.getPrice()) {
            searchByPriceRangeRec(root.left, minPrice, maxPrice, result);
        }

        // If current node is in range, add it
        if (root.room.getPrice() >= minPrice && root.room.getPrice() <= maxPrice) {
            result.add(root.room);
        }

        // If current node's price is less than maxPrice, then rooms in right subtree may qualify
        if (maxPrice > root.room.getPrice()) {
            searchByPriceRangeRec(root.right, minPrice, maxPrice, result);
        }
    }

    // Get available rooms
    public List<Room> getAvailableRooms() {
        List<Room> result = new ArrayList<>();
        getAvailableRoomsRec(root, result);
        return result;
    }

    private void getAvailableRoomsRec(Node root, List<Room> result) {
        if (root != null) {
            getAvailableRoomsRec(root.left, result);
            if (root.room.isAvailable()) {
                result.add(root.room);
            }
            getAvailableRoomsRec(root.right, result);
        }
    }

    // Clear the BST
    public void clear() {
        root = null;
    }
}
