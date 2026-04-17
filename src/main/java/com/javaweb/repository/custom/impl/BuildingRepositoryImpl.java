package com.javaweb.repository.custom.impl;

import javax.persistence.*;

import com.javaweb.builder.BuildingSearchBuilder;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.repository.BuildingRepositoryCustom;
import com.javaweb.utils.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
@Primary
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(BuildingSearchBuilder buildingSearchBuilder, StringBuilder sql){
        Long staffId =buildingSearchBuilder.getStaffId();
        if (staffId != null){
            sql.append("INNER JOIN assignmentbuilding ON b.id = assignmentbuilding.buildingid ");
        }
    }

    public static void queryNormal(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();
            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                // Bỏ qua các trường xử lý riêng ở querySpecial
                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode")
                        && !fieldName.startsWith("area") && !fieldName.startsWith("rentPrice")) {

                    // 1. Lấy đối tượng ra trước
                    Object valueObj = item.get(buildingSearchBuilder);

                    // 2. Kiểm tra null trước khi gọi toString()
                    if (valueObj != null) {
                        String value = valueObj.toString();
                        if (StringUtils.check(value)) {
                            if (fieldName.equals("managerPhone")) {
                                where.append(" AND b.managerphone LIKE '%" + value + "%' ");
                            } else if (fieldName.equals("managerName")) {
                                where.append(" AND b.managername LIKE '%" + value + "%' ");
                            } else if (NumberUtils.isNumber(value)) {
                                where.append(" AND b." + fieldName.toLowerCase() + " = " + value);
                            } else {
                                // Sửa lỗi dấu & thành % cho đúng chuẩn SQL LIKE
                                where.append(" AND b." + fieldName.toLowerCase() + " LIKE '%" + value + "%' ");
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void querySpecial(BuildingSearchBuilder buildingSearchBuilder,StringBuilder where){
        Long staffId =buildingSearchBuilder.getStaffId();
        if ( staffId != null ){
            where.append(" AND assignmentbuilding.staffid = " + staffId) ;
        }
        Long rentAreaTo = buildingSearchBuilder.getAreaTo();
        Long rentAreaFrom = buildingSearchBuilder.getAreaFrom();
        if(rentAreaTo != null || rentAreaFrom != null){

            if (rentAreaTo != null){
                where.append( " AND b.floorarea <= " + rentAreaTo);
            }
            if (rentAreaFrom != null){
                where.append(" AND b.floorarea >= " + rentAreaFrom);
            }
        }

        Long rentPriceTo = buildingSearchBuilder.getRentPriceTo();
        Long rentPriceFrom = buildingSearchBuilder.getRentPriceFrom();
        if( rentPriceTo != null || rentPriceFrom != null){
            if( rentPriceTo != null ){
                where.append(" AND b.rentprice <= " + rentPriceTo);
            }
            if (rentPriceFrom != null){
                where.append(" AND b.rentprice >= " + rentPriceFrom);
            }
        }
        //java 7
//        if (typeCode != null && typeCode.size() != 0 ){
//            List<String> code = new ArrayList<>();
//            for( String item : typeCode ){
//                code.add("'" + item + "'");
//            }
//            where.append(" AND renttype.code IN(" + String.join(",",code) + ") ");
//        }
        //java 8
        List<String> selectedTypes = buildingSearchBuilder.getTypeCode();
        if (selectedTypes != null && !selectedTypes.isEmpty()) {
            where.append(" AND (");
            String sql = selectedTypes.stream()
                    .map(it -> "b.type LIKE '%" + it + "%'")
                    .collect(Collectors.joining(" AND "));
            where.append(sql);
            where.append(") ");
        }
    }


    public List<BuildingEntity> findAll(BuildingSearchBuilder buildingSearchBuilder) {
        StringBuilder sql = new StringBuilder("SELECT DISTINCT b.* FROM building b ");
        joinTable(buildingSearchBuilder,sql);
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        queryNormal(buildingSearchBuilder,where);
        querySpecial(buildingSearchBuilder,where);
        sql.append(where);
        System.out.println(sql);
        Query query = entityManager.createNativeQuery(sql.toString(),BuildingEntity.class);
        return query.getResultList();
    }
}
