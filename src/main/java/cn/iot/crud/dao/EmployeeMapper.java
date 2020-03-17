package cn.iot.crud.dao;

import cn.iot.crud.bean.Employee;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    Employee selectByPrimaryKey(Integer empId);
    Employee selectByPrimaryKeyContainDept(Integer empId);
    List<Employee> selectByEmpName(String empName);

    List<Employee> selectAll();
    List<Employee> selectAllContainDept();

    int updateByPrimaryKey(Employee record);

	void deleteBatchById(@Param("ids") List<Integer> ids);
}