package com.example.vaanik_serv_1.models;

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
@Entity
@Table(name = "t_orders", schema = "vaanik-1")
public class TOrder {
    @Id
    @Column(name = "order_id", nullable = false, length = Integer.MAX_VALUE)
    private String orderId;

    @Column(name = "orig_zip_id", length = Integer.MAX_VALUE)
    private String origZipId;

    @Column(name = "dest_zip_id", length = Integer.MAX_VALUE)
    private String destZipId;

    @Column(name = "current_zip_id", length = Integer.MAX_VALUE)
    private String currentZipId;

    @Column(name = "updated_on", length = Integer.MAX_VALUE)
    private String updatedOn;

    @Column(name = "order_status_id", length = Integer.MAX_VALUE)
    private String orderStatusId;

    @Column(name = "length", length = Integer.MAX_VALUE)
    private String length;

    @Column(name = "width", length = Integer.MAX_VALUE)
    private String width;

    @Column(name = "height", length = Integer.MAX_VALUE)
    private String height;

    @Column(name = "weight", length = Integer.MAX_VALUE)
    private String weight;

    @Column(name = "is_fragile")
    private Boolean isFragile;

    @Column(name = "is_hazmat")
    private Boolean isHazmat;

}