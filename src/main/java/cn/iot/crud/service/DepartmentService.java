package cn.iot.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.iot.crud.bean.Department;
import cn.iot.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	/**
	 * 查询所有部分
	 * @return
	 */
	public List<Department> getDepts() {
		List<Department> selectAll = departmentMapper.selectAll();
		return selectAll;
	}
	
}
