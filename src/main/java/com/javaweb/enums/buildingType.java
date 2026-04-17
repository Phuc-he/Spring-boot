package com.javaweb.enums;


import java.util.*;

public enum  buildingType {
    TANG_TRET ("Tầng Trệt "),
    NGUYEN_CAN ("Nguyên Căn "),
    NOI_THAT ("Nội Thất ");

    private final String name;

    buildingType(String name) {
        this.name = name;
    }

    public String getCode() {
        return name;
    }

    public static Map<String,String> type(){
        Map<String,String> listType = new HashMap<>();
        for(buildingType item : buildingType.values()){
            listType.put(item.toString() , item.name);
        }
        return listType;
    }

    public static buildingType fromCode(String code) {
        for (buildingType type : buildingType.values()) {
            if (type.name().equalsIgnoreCase(code)) {  // So sánh không phân biệt chữ hoa/thường
                return type;
            }
        }
        throw new IllegalArgumentException("Invalid building type code: " + code);
    }
}
