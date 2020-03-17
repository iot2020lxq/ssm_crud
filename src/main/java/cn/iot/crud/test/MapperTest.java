package cn.iot.crud.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.iot.crud.bean.Department;
import cn.iot.crud.bean.Employee;
import cn.iot.crud.dao.DepartmentMapper;
import cn.iot.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	SqlSession sqlsession;
	
	@Test
	public void testCRUD() {
		List<Department> list = departmentMapper.selectAll();
		for (Department department : list) {
			System.out.println(department);
		}
		departmentMapper.insert(new Department(null,"质检部"));
		departmentMapper.insert(new Department(null,"公关部"));
		
		//批量插入
		EmployeeMapper employeeMapper = sqlsession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			employeeMapper.insert(new Employee(null,uid,"N",uid+"@iot.com",1));
		}
	}
		
}
