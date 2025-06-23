package com.PG64.RoomReservation.util;

import com.PG64.RoomReservation.model.Reservation;
import java.util.List;

public class ReservationSorter {
    
    public static void quickSort(List<Reservation> reservations) {
        if (reservations == null || reservations.size() <= 1) {
            return;
        }
        quickSort(reservations, 0, reservations.size() - 1);
    }

    private static void quickSort(List<Reservation> reservations, int low, int high) {
        if (low < high) {
            // Find the partition index
            int pi = partition(reservations, low, high);

            // Recursively sort elements before and after partition
            quickSort(reservations, low, pi - 1);
            quickSort(reservations, pi + 1, high);
        }
    }

    private static int partition(List<Reservation> reservations, int low, int high) {
        // Choose the rightmost element as pivot
        Reservation pivot = reservations.get(high);
        int i = (low - 1); // Index of smaller element

        for (int j = low; j < high; j++) {
            // If current element is smaller than or equal to pivot
            if (reservations.get(j).getCheckInDate().compareTo(pivot.getCheckInDate()) <= 0) {
                i++;
                // Swap reservations[i] and reservations[j]
                swap(reservations, i, j);
            }
        }

        // Swap reservations[i+1] and reservations[high] (or pivot)
        swap(reservations, i + 1, high);
        return i + 1;
    }

    private static void swap(List<Reservation> reservations, int i, int j) {
        Reservation temp = reservations.get(i);
        reservations.set(i, reservations.get(j));
        reservations.set(j, temp);
    }

    // Additional method for reverse sorting (latest check-in date first)
    public static void quickSortDescending(List<Reservation> reservations) {
        if (reservations == null || reservations.size() <= 1) {
            return;
        }
        quickSortDescending(reservations, 0, reservations.size() - 1);
    }

    private static void quickSortDescending(List<Reservation> reservations, int low, int high) {
        if (low < high) {
            int pi = partitionDescending(reservations, low, high);
            quickSortDescending(reservations, low, pi - 1);
            quickSortDescending(reservations, pi + 1, high);
        }
    }

    private static int partitionDescending(List<Reservation> reservations, int low, int high) {
        Reservation pivot = reservations.get(high);
        int i = (low - 1);

        for (int j = low; j < high; j++) {
            // If current element is larger than pivot (reverse of ascending sort)
            if (reservations.get(j).getCheckInDate().compareTo(pivot.getCheckInDate()) >= 0) {
                i++;
                swap(reservations, i, j);
            }
        }

        swap(reservations, i + 1, high);
        return i + 1;
    }
} 