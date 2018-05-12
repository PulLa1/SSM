package com.spring.pojo;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

public class Employee {
    private Integer id;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"
    ,message = "用户名必须是6-16位数字和字母，或者2-5位中文")
    private String lastName;

    private String gender;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    ,message = "请输入正确的邮箱格式")
    private String email;

    private Integer deptId;

    private Department department;


    public Employee(Integer id, String lastName, String gender, String email, Integer deptId) {
        this.id = id;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.deptId = deptId;
    }

    public Employee() {
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName == null ? null : lastName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", lastName='" + lastName + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", deptId=" + deptId +
                ", department=" + department +
                '}';
    }
}