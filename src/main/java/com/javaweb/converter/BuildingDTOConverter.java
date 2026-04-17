package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.ShowBuildingDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;
@Component
public class BuildingDTOConverter {
    @Autowired
    private ModelMapper modelMapper;

    public BuildingDTO toBuildingDTO(BuildingEntity item){
        BuildingDTO buildingDTO = modelMapper.map(item,BuildingDTO.class);
//        buildingDTO.setAddress(item.getStreet() + " " + item.getWard() + " " + item.getDistrict().getName());
//        List<RentAreaEntity> rentAreas = item.getItems();
//        String rentAreaStr = rentAreas.stream().map(area -> String.valueOf(area.getValue())).collect(Collectors.joining(", "));
//        buildingDTO.setRentArea(rentAreaStr);
        return buildingDTO;
    }
}
