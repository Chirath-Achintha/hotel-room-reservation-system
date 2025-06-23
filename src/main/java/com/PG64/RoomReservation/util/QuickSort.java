package com.PG64.RoomReservation.util;

import com.PG64.RoomReservation.model.Booking;
import java.time.LocalDate;
import java.util.List;
import org.springframework.stereotype.Component;

@Component
public class QuickSort {

    // Sort bookings by check-in date (ascending)
    public void sortByDate(List<Booking> bookings) {
        if (bookings == null || bookings.size() <= 1) {
            return;
        }
        quickSort(bookings, 0, bookings.size() - 1);
    }

    private void quickSort(List<Booking> bookings, int low, int high) {
        if (low < high) {
            int pi = partition(bookings, low, high);
            quickSort(bookings, low, pi - 1);
            quickSort(bookings, pi + 1, high);
        }
    }

    private int partition(List<Booking> bookings, int low, int high) {
        LocalDate pivot = bookings.get(high).getCheckInDate();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (bookings.get(j).getCheckInDate().isBefore(pivot)) {
                i++;
                swap(bookings, i, j);
            }
        }

        swap(bookings, i + 1, high);
        return i + 1;
    }

    private void swap(List<Booking> bookings, int i, int j) {
        Booking temp = bookings.get(i);
        bookings.set(i, bookings.get(j));
        bookings.set(j, temp);
    }

    // Sort in descending order (for recent first)
    public void sortByDateDescending(List<Booking> bookings) {
        sortByDate(bookings);
        reverse(bookings);
    }

    private void reverse(List<Booking> bookings) {
        int i = 0;
        int j = bookings.size() - 1;
        while (i < j) {
            swap(bookings, i, j);
            i++;
            j--;
        }
    }
}