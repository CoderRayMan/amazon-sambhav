package com.example.vaanik_serv_1.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDTO {
    private String orderId;
    private String origZipId;
    private String destZipId;
    private String currentZipId;
    private String updatedOn;
    private String orderStatusId;
    private String length;
    private String width;
    private String height;
    private String weight;
    private Boolean isFragile;
    private Boolean isHazmat;
}
