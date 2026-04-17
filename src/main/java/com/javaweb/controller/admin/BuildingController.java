package com.javaweb.controller.admin;



import com.javaweb.enums.buildingType;
import com.javaweb.enums.districtCode;
import com.javaweb.model.dto.AddBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.dto.ShowBuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.service.BuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller(value="buildingControllerOfAdmin")
public class BuildingController {
    @Autowired
    private IUserService userService;
    @Autowired
    private BuildingService buildingService;

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute BuildingDTO buildingDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("modelSearch",buildingDTO);
        Map<String, Object> params = new HashMap<>();
        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            // Lấy giá trị đầu tiên của mảng hoặc xử lý nếu cần
            params.put(entry.getKey(), entry.getValue()[0]);
        }
        if (buildingDTO != null) {
            List<BuildingDTO> responseList = buildingService.findAll(params, buildingDTO.getTypeCode());
            mav.addObject("buildingList", responseList);
        }
        mav.addObject("listStaffs",userService.getStraffs());
        mav.addObject("districts", districtCode.type());
        mav.addObject("typeCodes", buildingType.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingEdit(@ModelAttribute AddBuildingDTO addBuildingDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("admin/building/edit");

        mav.addObject("buildingEdit",addBuildingDTO);
        mav.addObject("districts", districtCode.type());
        mav.addObject("typeCodes", buildingType.type());
        return mav;
    }

    @GetMapping(value = "/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable("id") Long id, HttpServletRequest request,@ModelAttribute AddBuildingDTO addBuildingDTO){
        ModelAndView mav = new ModelAndView("admin/building/edit");
        AddBuildingDTO buildingDTO = buildingService.getBuildingById(id);

        mav.addObject("buildingEdit",buildingDTO);
        mav.addObject("districts", districtCode.type());
        mav.addObject("typeCodes", buildingType.type());
        return mav;
    }
}
