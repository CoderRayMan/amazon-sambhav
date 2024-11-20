package com.example.vaanik_serv_1.services;

import com.example.vaanik_serv_1.assemblers.OrdersAssembler;
import com.example.vaanik_serv_1.dto.OrderDTO;
import com.example.vaanik_serv_1.repository.TOrdersRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrdersService {
    private final TOrdersRepo tOrdersRepo;

    public List<OrderDTO> getAllOrders() {
            return tOrdersRepo.findAll().stream().map(OrdersAssembler::entityToDTO).toList();
    }


}
