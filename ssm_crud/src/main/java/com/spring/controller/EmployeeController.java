package com.spring.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spring.pojo.Employee;
import com.spring.pojo.Msg;
import com.spring.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {


    @Autowired
    EmployeeService employeeService;


    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNumber, Model model) {
        PageHelper.startPage(pageNumber,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps,5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }


//    导入jackson包 将数据转化为json
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pageNumber) {
        PageHelper.startPage(pageNumber,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(emps,5);
        final Msg msg = new Msg();
        return msg.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/emp" ,method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        HashMap<String, Object> map = new HashMap<String, Object>();
        if (result.hasErrors()){
            final List<FieldError> errors = result.getFieldErrors();
            for (FieldError error :errors){
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorfield",map);
        }else {
        employeeService.saveEmp(employee);
        return Msg.success();
        }
    }


    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkuser(@RequestParam("lastName") String lastName){
        String regx ="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!lastName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母，或者2-5位中文");
        }
        boolean b = employeeService.checkUser(lastName);
        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已存在");
        }

    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return  Msg.success().add("employee",employee);
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    public Msg Update(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}" ,method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("id") String ids){
        //批量删除
        if (ids.contains("-")){
            ArrayList<Integer> list = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String str_id : str_ids){
                list.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(list);
        }else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }


}
