package cn.iot.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.iot.crud.bean.Employee;
import cn.iot.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 获取所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectAllContainDept();
	}

	/**
	 * 添加员工
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insert(employee);
	}

	/**
	 * 校验用户名
	 * 根据用户名查询用户
	 * @param empName
	 * @return
	 */
	public boolean checkUse(String empName) {
		List<Employee> list = employeeMapper.selectByEmpName(empName);
		//System.out.println(list);
		if(list.isEmpty()) {
			return true;
		}
		return false;
	}

	/**
	 * 根据用户id查询用户
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKeyContainDept(id);
		return employee;
	}

	/**
	 * 更新用户
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKey(employee);
	}

	/**
	 * 删除员工
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void deleteBatch(List<Integer> ids) {
		employeeMapper.deleteBatchById(ids);
	}
}
