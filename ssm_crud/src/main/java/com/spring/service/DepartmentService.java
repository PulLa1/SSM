package com.spring.service;

import com.spring.dao.DepartmentMapper;
import com.spring.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        final List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
