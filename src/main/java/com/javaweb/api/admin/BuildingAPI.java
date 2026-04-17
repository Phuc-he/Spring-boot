package com.javaweb.api.admin;

import com.javaweb.model.dto.AddBuildingDTO;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.ShowBuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@RestController(value = "buildingAPIOfAdmin")
@RequestMapping("/api/building")
public class BuildingAPI {

    @Autowired
    BuildingService buildingService;

    @GetMapping
    public List<BuildingDTO> getBuilding(@RequestParam Map<String, Object> params,
                                             @RequestParam(name = "typeCode",required = false) List<String> typeCode){
        List<BuildingDTO> result = buildingService.findAll(params,typeCode);
        return result;
    }

    @PostMapping
    public AddBuildingDTO addBuilding(@RequestBody AddBuildingDTO addBuildingDTO){
        buildingService.addOrUpdateBuilding(addBuildingDTO);
        return addBuildingDTO;
    }

    @PostMapping("/{id}")
    public AddBuildingDTO updateBuilding(@RequestBody AddBuildingDTO addBuildingDTO){
        buildingService.addOrUpdateBuilding(addBuildingDTO);
        return addBuildingDTO;
    }

    @DeleteMapping("/{ids}")
    public void deleteBuilding(@PathVariable List<Long> ids){
        buildingService.deleteBuilding(ids);
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaff(@PathVariable Long id){
        ResponseDTO result = buildingService.listStaffs(id);
        return result;
    }

    @PostMapping("/assignment")
    public void updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO){
        buildingService.updateAssignmentBuilding(assignmentBuildingDTO);

    }




}
