package com.example.vaanik_serv_1.repository;

import com.example.vaanik_serv_1.models.TOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TOrdersRepo extends JpaRepository<TOrder,String> {
}
