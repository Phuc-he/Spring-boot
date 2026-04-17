package com.javaweb.service;

import com.javaweb.model.dto.AddBuildingDTO;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.ShowBuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


public interface BuildingService {
    ResponseDTO listStaffs(Long buildingId);

    List<BuildingDTO> findAll(Map<String, Object> params, List<String> typeCode);

    void addOrUpdateBuilding(AddBuildingDTO addBuildingDTO);

    void deleteBuilding(List<Long> ids);

    AddBuildingDTO getBuildingById(Long id);

    void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTOd);
}
