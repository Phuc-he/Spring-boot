package com.javaweb.service.impl;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.converter.BuildingDTOConverter;
import com.javaweb.converter.BuildingSearchBuilderConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.enums.buildingType;
import com.javaweb.model.dto.AddBuildingDTO;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.ShowBuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.BuildingService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.*;

@Service
@Transactional
public class BuildingServiceImpl implements BuildingService {
    @Autowired
    private BuildingRepository buildingRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BuildingSearchBuilderConverter buildingSearchBuilderConverter;
    @Autowired
    private BuildingDTOConverter buildingDTOConverter;
    @Autowired
    private ModelMapper modelMapper;

    @Override
    public ResponseDTO listStaffs(Long buildingId) {
        // Lấy tòa nhà theo buildingId
        BuildingEntity building = buildingRepository.findById(buildingId).get();

        // Lấy danh sách nhân viên có status là 1 và role là STAFF
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1,"STAFF");

        // Lấy danh sách nhân viên đã được phân công cho tòa nhà
        List<UserEntity> staffAssignment = building.getUserEntities();

        // Tạo danh sách DTO để trả về
        List<StaffResponseDTO> staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();

        // Kiểm tra và log thông tin staffAssignment
        System.out.println("Staff assignment for building " + buildingId + ": " + staffAssignment.size() + " staff(s) assigned.");

        // Duyệt qua từng nhân viên trong danh sách tất cả nhân viên
        for (UserEntity item : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setFullName(item.getFullName());
            staffResponseDTO.setStaffId(item.getId());

            // Kiểm tra xem nhân viên có được phân công cho tòa nhà không
            if (staffAssignment.contains(item)) {
                staffResponseDTO.setChecked("checked");
            } else {
                staffResponseDTO.setChecked("");
            }

            // Thêm vào danh sách trả về
            staffResponseDTOS.add(staffResponseDTO);
        }

        // Đặt dữ liệu vào responseDTO và trả về
        responseDTO.setData(staffResponseDTOS);
        return responseDTO;
    }

    @Override
    public List<BuildingDTO> findAll(Map<String, Object> params, List<String> typeCode) {
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(params, typeCode);
        List<BuildingEntity> buildingEntities = buildingRepository.findAll(buildingSearchBuilder);
        List<BuildingDTO> result = new ArrayList<BuildingDTO>();
        for (BuildingEntity item : buildingEntities){
            BuildingDTO buildingDTO = buildingDTOConverter.toBuildingDTO(item);
            result.add(buildingDTO);
        }
        return result;
    }

    @Override

    public void deleteBuilding(List<Long> ids) {
        buildingRepository.deleteAllByIdIn(ids);
    }

    @Override
    public void addOrUpdateBuilding(AddBuildingDTO addBuildingDTO) {
        BuildingEntity buildingEntity = modelMapper.map(addBuildingDTO, BuildingEntity.class);


        // Chuyển List<String> typeCode thành chuỗi (type) trong Entity
        String type = String.join(",", addBuildingDTO.getTypeCode());
        buildingEntity.setType(type);

        // Lưu BuildingEntity vào cơ sở dữ liệu
        buildingRepository.save(buildingEntity);
    }

    @Override
    public AddBuildingDTO getBuildingById(Long id) {
        // Lấy thông tin tòa nhà từ repository
        BuildingEntity buildingEntity = buildingRepository.findById(id).orElseThrow(() -> new RuntimeException("Building not found"));

        // Chuyển từ Entity sang DTO
        AddBuildingDTO buildingDTO = new AddBuildingDTO();
        buildingDTO.setId(buildingEntity.getId());
        buildingDTO.setName(buildingEntity.getName());
        buildingDTO.setStreet(buildingEntity.getStreet());
        buildingDTO.setWard(buildingEntity.getWard());
        buildingDTO.setDistrict(buildingEntity.getDistrict());
        buildingDTO.setFloorArea(buildingEntity.getFloorArea());
        buildingDTO.setManagerName(buildingEntity.getManagerName());
        buildingDTO.setManagerPhone(buildingEntity.getManagerPhone());
        buildingDTO.setBrokerageFee(buildingEntity.getBrokerageFee());
        buildingDTO.setNumberOfBasement(buildingEntity.getNumberOfBasement());
        if (buildingEntity.getType() != null) {
            String[] typeCodes = buildingEntity.getType().split(",");  // Tách chuỗi từ cơ sở dữ liệu
            buildingDTO.setTypeCode(Arrays.asList(typeCodes));  // Chuyển thành List<String>
        }

        return buildingDTO;
    }

    @Override
    @Transactional
    public void updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        List<Long> staffs = assignmentBuildingDTO.getStaffs();
        Long buildingId = assignmentBuildingDTO.getBuildingId();

        BuildingEntity buildingEntity = buildingRepository.findById(buildingId).orElseThrow(() -> new RuntimeException("Building not found"));
        List<UserEntity> userEntities = new ArrayList<>();
        List<UserEntity> staffAssignment = buildingEntity.getUserEntities();
        Iterator<UserEntity> iterator = staffAssignment.iterator();
        while (iterator.hasNext()) {
            UserEntity staff = iterator.next();
            if (!staffs.contains(staff.getId())) {
                iterator.remove();  // Loại bỏ nhân viên không còn được chọn
            }
        }
        for (Long staffId : staffs) {
            UserEntity userEntity = userRepository.findById(staffId)
                    .orElseThrow(() -> new RuntimeException("Nhân viên không tồn tại"));
            userEntities.add(userEntity);
        }
        buildingEntity.setUserEntities(userEntities);
        try {
            buildingRepository.save(buildingEntity);  // Lưu mối quan hệ giữa tòa nhà và nhân viên
        } catch (Exception e) {
            e.printStackTrace();  // In lỗi nếu có
        }
    }
}
