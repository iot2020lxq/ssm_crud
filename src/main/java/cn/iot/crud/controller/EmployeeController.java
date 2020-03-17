package cn.iot.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.iot.crud.bean.Employee;
import cn.iot.crud.bean.Msg;
import cn.iot.crud.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 删除员工:
	 * 		单个删除和批量删除二合一
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg delteEmp(@PathVariable("ids") String ids) {
		
		if(ids.contains("-")) {
			List<Integer> idList = new ArrayList<>();
			String[] str_ids = ids.split("-");
			for (String str_id : str_ids) {
				int id = Integer.parseInt(str_id);
				idList.add(id);
			}
			employeeService.deleteBatch(idList);
		}else {
			int id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/**
	 * 更新员工
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg updateEmp(Employee employee) {
		employeeService.updateEmp(employee);
		System.out.println(employee);
		return Msg.success();
	}
	
	/**
	 * 根据用户id查询员工
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 校验用户名是否重复
	 */
	@ResponseBody
	@RequestMapping(value="/checkuse")
	public Msg checkuse(@RequestParam("empName") String empName) {
		//System.out.println(empName);
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名为6-16位数字、字母组合或2-5位汉字!");
		}
		boolean b = employeeService.checkUse(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用！");
		}
	}
	
	/**
	 * 添加员工
	 * 后端员工校验：JSR303
	 * 防止恶意修改前端代码的非法注入
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/depts",method=RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			//创建map封装错误信息
			Map<String,Object> map = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
//				System.out.println("错误字段为："+fieldError.getField());
//				System.out.println("错误信息为："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn) {
		//引入pageHelper分页插件,每页的记录数
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果,并显示连续的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		
		return Msg.success().add("pageInfo", page);
	}
		
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,
			Model model) {
		//引入pageHelper分页插件,每页的记录数
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的查询就是分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果,并显示连续的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		//将信息显示到页面
		model.addAttribute("pageInfo", page);
		
		//当前连续页数
//		page.getNavigatepageNums();
		
		return "list";
	}
}
