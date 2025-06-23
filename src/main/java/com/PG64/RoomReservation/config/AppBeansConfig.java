package com.PG64.RoomReservation.config;

import com.PG64.RoomReservation.util.BST;
import com.PG64.RoomReservation.util.FileUtil;
import com.PG64.RoomReservation.util.QuickSort;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
public class AppBeansConfig {

    @Bean
    public FileUtil fileUtil() {
        return new FileUtil();
    }

    @Bean
    @Primary
    public BST bst() {
        return new BST();
    }

    @Bean
    public QuickSort quickSort() {
        return new QuickSort();
    }
}