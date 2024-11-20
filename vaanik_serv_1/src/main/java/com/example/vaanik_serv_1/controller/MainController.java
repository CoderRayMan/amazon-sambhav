package com.example.vaanik_serv_1.controller;

import com.example.vaanik_serv_1.dto.OrderDTO;
import com.example.vaanik_serv_1.services.OrdersService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/main")
@RequiredArgsConstructor
public class MainController {
    private final OrdersService ordersService;
    @GetMapping("/get-all")
    public ResponseEntity<List<OrderDTO>> getAll() {
        return ResponseEntity.ok(ordersService.getAllOrders());
    }
}
