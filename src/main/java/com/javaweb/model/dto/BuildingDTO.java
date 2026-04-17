package com.javaweb.model.dto;

import com.javaweb.enums.buildingType;
import com.javaweb.enums.districtCode;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BuildingDTO extends AbstractDTO{
    private String name;
    private Long floorArea;
    private String district;
    private String ward;
    private String street;
    private Long numberOfBasement;
    private String direction;
    private Long level;
    private Long areaFrom;
    private Long areaTo;
    private Long rentPriceFrom;
    private Long rentPriceTo;
    private String managerName;
    private String managerPhone;
    private Long staffId;
    private String address;
    private String brokerageFee;

    public String getAddress() {
        return address;
    }

    public void setAddress() {
        // Kiểm tra districtCode và lấy tên quận tương ứng
        if (this.district != null) {
            try {
                districtCode districtc = districtCode.valueOf(this.district);  // Lấy tên quận từ enum
                String districtName = districtc.getDistrictName();  // Lấy tên quận
                this.address = this.street + " " + this.ward + " " + districtName;  // Ghép địa chỉ
            } catch (IllegalArgumentException e) {
                this.address = this.street + " " + this.ward + " " + "Không xác định";  // Nếu mã quận không hợp lệ
            }
        } else {
            this.address = this.street + " " + this.ward + " " + "Không xác định";  // Nếu mã quận là null
        }
    }

    private List<String> typeCode;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getFloorArea() {
        return floorArea;
    }

    public void setFloorArea(Long floorArea) {
        this.floorArea = floorArea;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
        setAddress();
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
        setAddress();
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
        setAddress();
    }

    public Long getNumberOfBasement() {
        return numberOfBasement;
    }

    public void setNumberOfBasement(Long numberOfBasement) {
        this.numberOfBasement = numberOfBasement;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public Long getLevel() {
        return level;
    }

    public void setLevel(Long level) {
        this.level = level;
    }

    public Long getAreaFrom() {
        return areaFrom;
    }

    public void setAreaFrom(Long areaFrom) {
        this.areaFrom = areaFrom;
    }

    public Long getAreaTo() {
        return areaTo;
    }

    public void setAreaTo(Long areaTo) {
        this.areaTo = areaTo;
    }

    public Long getRentPriceFrom() {
        return rentPriceFrom;
    }

    public void setRentPriceFrom(Long rentPriceFrom) {
        this.rentPriceFrom = rentPriceFrom;
    }

    public Long getRentPriceTo() {
        return rentPriceTo;
    }

    public void setRentPriceTo(Long rentPriceTo) {
        this.rentPriceTo = rentPriceTo;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone;
    }

    public Long getStaffId() {
        return staffId;
    }

    public void setStaffId(Long staffId) {
        this.staffId = staffId;
    }

    public String getBrokerageFee() {
        return brokerageFee;
    }

    public void setBrokerageFee(String brokerageFee) {
        this.brokerageFee = brokerageFee;
    }

    public List<String> getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(List<String> typeCode) {
        this.typeCode = typeCode;
    }

    public void setBuildingTypesFromDB(String typeFromDB) {
        String[] typeCodes = typeFromDB.split(",");  // Tách chuỗi từ DB
        this.typeCode = Arrays.asList(typeCodes);  // Chuyển thành List<String>
    }
}