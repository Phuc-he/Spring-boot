package com.javaweb.repository;

import com.javaweb.entity.BuildingEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BuildingRepository extends JpaRepository<BuildingEntity,Long>, BuildingRepositoryCustom {
    void deleteAllByIdIn(List<Long> ids);
}
