package com.spring.controller;


import com.spring.pojo.Department;
import com.spring.pojo.Msg;
import com.spring.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServlet;
import java.util.List;


@Controller
public class DepartmentCotroller extends HttpServlet {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg geDepts() {
        final List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
