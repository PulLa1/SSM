package com.spring.pojo;

public class Department {
    private Integer id;

    private String departName;

    public Department(Integer id, String departName) {
        this.id = id;
        this.departName = departName;
    }

    public Department() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName == null ? null : departName.trim();
    }
}