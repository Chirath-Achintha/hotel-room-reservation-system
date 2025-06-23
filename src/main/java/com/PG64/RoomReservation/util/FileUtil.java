package com.PG64.RoomReservation.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Component;

@Component
public class FileUtil {

    // Read all lines from a file
    public List<String> readLines(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            // Create parent directories if they don't exist
            Files.createDirectories(path.getParent());
            // Create the file with UTF-8 encoding
            Files.write(path, new ArrayList<>(), StandardCharsets.UTF_8);
            return new ArrayList<>();
        }
        return Files.readAllLines(path, StandardCharsets.UTF_8);
    }

    // Write lines to a file (overwrites existing content)
    public boolean writeLines(String filePath, List<String> lines) throws IOException {
        Path path = Paths.get(filePath);
        // Create parent directories if they don't exist
        if (!Files.exists(path.getParent())) {
            Files.createDirectories(path.getParent());
        }
        Files.write(path, lines, StandardCharsets.UTF_8, 
                StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
        return true;
    }

    // Append a single line to a file
    public boolean appendLine(String filePath, String line) throws IOException {
        Path path = Paths.get(filePath);
        // Create parent directories if they don't exist
        if (!Files.exists(path.getParent())) {
            Files.createDirectories(path.getParent());
        }
        if (!Files.exists(path)) {
            Files.createFile(path);
        }
        Files.write(path, (line + System.lineSeparator()).getBytes(StandardCharsets.UTF_8),
                StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        return true;
    }

    // Check if a file exists
    public boolean fileExists(String filePath) {
        return Files.exists(Paths.get(filePath));
    }

    // Create directory if it doesn't exist
    public void createDirectoryIfNotExists(String dirPath) throws IOException {
        Path path = Paths.get(dirPath);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
    }
}