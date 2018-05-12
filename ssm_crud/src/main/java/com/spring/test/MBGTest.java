package com.spring.test;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.spring.dao.DepartmentMapper;
import com.spring.dao.EmployeeMapper;
import com.spring.pojo.Department;
import com.spring.pojo.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//spring单元测试标签
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:/spring-mybatis.xml"})
public class MBGTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

//	public static void main(String[] args) throws Exception {
//		List<String> warnings = new ArrayList<String>();
//		boolean overwrite = true;
//		File configFile = new File("src/mbg.xml");
//		ConfigurationParser cp = new ConfigurationParser(warnings);
//		Configuration config = cp.parseConfiguration(configFile);
//		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
//		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
//				callback, warnings);
//		myBatisGenerator.generate(null);
//	}

	@Test
	public void testCRUD(){
		EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
		for (int i=0;i<1000;i++){
			String uuid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,i+"M"+uuid,"f",uuid+"@ss.com",1));
		}
		System.out.println("ok");
		//		Department department = new Department(null, "开发部");
		//departmentMapper.insertSelective(department);
//		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
//		System.out.println(employee);
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("spring-mybatis");
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
	}
}
