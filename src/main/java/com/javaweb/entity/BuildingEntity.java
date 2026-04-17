package com.javaweb.entity;


import javax.persistence.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Entity
@Table(name = "building")
public class BuildingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "numberofbasement")
    private Long numberOfBasement;
    @Column(name = "ward")
    private String ward;
    @Column(name = "street")
    private String street;
    @Column(name = "floorarea")
    private Long floorArea;
    @Column(name = "rentprice")
    private Long rentPrice;
    @Column(name = "servicefee")
    private String serviceFee;
    @Column(name = "brokeragefee")
    private String BrokerageFee;
    @Column(name = "managername")
    private String managerName;
    @Column(name = "managerphone")
    private String managerPhone;
    @Column(name = "type")
    private String type;
    @Column(name = "district")
    private String district;

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }
//    @OneToMany(fetch = FetchType.LAZY,mappedBy = "buildingEntity")
//    List<AssignBuildngingEntity> assignBuildngingEntities = new ArrayList<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "assignmentbuilding",
                joinColumns = @JoinColumn(name = "buildingid",nullable = false),
                inverseJoinColumns = @JoinColumn(name = "staffid",nullable = false))
    private List<UserEntity> userEntities = new ArrayList<>();

    @OneToMany(mappedBy = "building",fetch = FetchType.LAZY)
    private List<RentAreaEntity> items = new ArrayList<>();

    public List<UserEntity> getUserEntities() {
        return userEntities;
    }

    @Transient  // Trường này không lưu trong DB, chỉ trong Entity
    private List<String> buildingTypes;  // Danh sách các kiểu building

    // Getter và Setter cho buildingTypes
    public List<String> getBuildingTypes() {
        return buildingTypes;
    }

    public void setBuildingTypes(List<String> buildingTypes) {
        this.buildingTypes = buildingTypes;
    }

    // Phương thức chuyển từ 'type' (String) sang List<String>
    public void setBuildingTypesFromDB() {
        String[] typeCodes = this.type.split(",");
        this.buildingTypes = Arrays.asList(typeCodes);  // Chuyển thành List<String>
    }


    public void setUserEntities(List<UserEntity> userEntities) {
        this.userEntities = userEntities;
    }

    public List<RentAreaEntity> getItems() {
        return items;
    }

    public void setItems(List<RentAreaEntity> items) {
        this.items = items;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getNumberOfBasement() {
        return numberOfBasement;
    }

    public void setNumberOfBasement(Long numberOfBasement) {
        this.numberOfBasement = numberOfBasement;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public Long getFloorArea() {
        return floorArea;
    }

    public void setFloorArea(Long floorArea) {
        this.floorArea = floorArea;
    }

    public Long getRentPrice() {
        return rentPrice;
    }

    public void setRentPrice(Long rentPrice) {
        this.rentPrice = rentPrice;
    }

    public String getServiceFee() {
        return serviceFee;
    }

    public void setServiceFee(String serviceFee) {
        this.serviceFee = serviceFee;
    }

    public String getBrokerageFee() {
        return BrokerageFee;
    }

    public void setBrokerageFee(String brokerageFee) {
        BrokerageFee = brokerageFee;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
