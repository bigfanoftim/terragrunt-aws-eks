package me.bigfanoftim.core.api.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class HealthController {

    @GetMapping("/health")
    public ResponseEntity<Object> health() {
        return ResponseEntity.status(HttpStatus.OK).build();
    }
}
