package com.spring.service;

import com.spring.dao.EmployeeMapper;
import com.spring.pojo.Employee;
import com.spring.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insert(employee);
    }

    public boolean checkUser(String lastName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andLastNameEqualTo(lastName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> str_ids) {
        final EmployeeExample example = new EmployeeExample();
        final EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(str_ids);
        employeeMapper.deleteByExample(example);
    }
}
