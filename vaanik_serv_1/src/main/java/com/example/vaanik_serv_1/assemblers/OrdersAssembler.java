package com.example.vaanik_serv_1.assemblers;

import com.example.vaanik_serv_1.dto.OrderDTO;
import com.example.vaanik_serv_1.models.TOrder;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.modelmapper.ModelMapper;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class OrdersAssembler {
    public static OrderDTO entityToDTO(TOrder order) {
        ModelMapper modelMapper = new ModelMapper();
        return modelMapper.map(order, OrderDTO.class);
    }
}
