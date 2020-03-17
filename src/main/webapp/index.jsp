<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
 %>
<!-- 引入jquery -->
<script src="${APP_PATH }/static/js/jquery-1.12.4.min.js" type="text/javascript"></script>
<!-- 引入样式 -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_update_input"
									placeholder="Email">
								<span id="helpBlock3" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
									男
								</label> 
								<label class="radio-inline"> 
								<input type="radio" name="gender" id="gender2_update_input" value="F">
									女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								  
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input"
									placeholder="empName">
								<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_add_input"
									placeholder="Email">
								<span id="helpBlock3" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">
									男
								</label> 
								<label class="radio-inline"> 
								<input type="radio" name="gender" id="gender2_add_input" value="F">
									女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								  
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12 ">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		
		<!-- 显示表格数据 -->
		 <div class="row">
		 	<div class="col-md-12">
		 		<table class="table table-hover" id="emps_table"> 
		 			<thead>
			 			<tr>
			 				<th>
			 					<input type="checkbox" id="check_all">
			 				</th>
			 				<th>#</th>
			 				<th>empName</th>
			 				<th>gender</th>
			 				<th>email</th>
			 				<th>deptName</th>
			 				<th>操作</th>
			 			</tr>
		 			</thead>
		 			<tbody>
		 				
		 			</tbody>
		 		</table>
		 	</div>
		 </div>
		 
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
	
		//总记录数
		var totalRecord;
		
		//当前页
		var currentPage;
		
		//1.页面加载完成以后，直接发送一个ajax请求，获取分页数据
		$(function(){
			//第一页
			to_page(1);
		});
		
		//分页跳转,发送一个ajax请求
		function to_page(pn){
			//清空全选
			$("#check_all").prop("checked",false);
			
			$.ajax({
				url:"${APP_PATH}/emps",	//请求地址
				data:"pn="+pn,//请求参数
				type:"GET",//请求方式
				success:function(result){
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.显示分页条
					build_page_nav(result);
				}
			});
		}
		
		//解析json数据，显示原员工信息
		function build_emps_table(result){
			//清空table
			$("#emps_table tbody").empty();
			
			//得到所有员信息
			var emps = result.extend.pageInfo.list;
			
			//遍历员工信息,遍历的对象,遍历的回调函数
			$.each(emps,function(index,item){
				
				var checkBoxTd = $("<td><input type='checkBox' class='check_item' /></td>")
				
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender == 'M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").
					append($("<span></span>").addClass("glyphicon glyphicon-pencil")).
					append("编辑");
				
				//为编辑按钮添加一个自定义属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").
					append($("<span></span>").addClass("glyphicon glyphicon-trash")).
					append("删除");
				
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
				
				$("<tr></tr>").append(checkBoxTd)
				.append(empIdTd)
				 .append(empNameTd)
				 .append(genderTd)
				 .append(emailTd)
				 .append(deptNameTd)
				 .append(btnTd)
				 .appendTo("#emps_table tbody");
			});
		}
		
		//显示分页信息
		function build_page_info(result){
			//清空分页信息
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+" 页，总"+
					result.extend.pageInfo.pages+" 页，总"+
					result.extend.pageInfo.total+" 条记录");
			
			//给全局变量赋值
			totalRecord = result.extend.pageInfo.total + 1;
			currentPage = result.extend.pageInfo.pageNum;
			
		}
		
		//显示分页条
		function build_page_nav(result){
			//清空分页条
			$("#page_nav_area").empty();
			
			var ul = $("<ul></ul>").addClass("pagination"); 
			
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//去首页，发送ajax请求
				firstPageLi.click(function(){
					to_page(1);
				});
				//前一页，发送ajax请求
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi =  $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//末页，发送ajax请求
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
				//下一页，发送ajax请求
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum + 1);
				});
			}
			
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageLi);
			
			//页码号
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				//给页码添加点击事件，发送ajax请求
				numLi.click(function(){
					to_page(item);
				});
				//添加页码号
				ul.append(numLi);
			});
			
			//添加后一页和尾页
			ul.append(nextPageLi).append(lastPageLi);
			//把ul添加到nav元素
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清除表单数据的方法
		function reset_form(ele){
			//清除表单数据
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			//
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，打开模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据
			reset_form("#empAddModal form");
			
			//发送ajax请求，查出部分信息，显示在下拉列表
			getDepts("#empAddModal select");
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//点击编辑按钮，弹出模态框
		$(document).on("click",".edit_btn",function(){
			//清空表达样式
			reset_form("#empUpdateModal form");
			
			//发送ajax请求，查出部分信息，显示在下拉列表
			getDepts("#empUpdateModal select");
			
			//查询员工信息
			getEmp($(this).attr("edit-id"));
			
			//把员工的id赋值给按钮的一个自定义属性
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		//单个删除按钮
		$(document).on("click",".delete_btn",function(){
			//弹出对话框
			//alert($(this).parents("tr").find("td:eq(0)").text());
			var empId = $(this).parents("tr").find("td:eq(1)").text();
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确定删除"+' "'+empId+'" '+"号员工 "+'"'+empName+'"'+" 吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						//alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//查询员工信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val(empData.dId);
				}
			});
		} 
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//校验邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = /(^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式错误！");
				return false;
			} else{
				show_validate_msg("#email_update_input","success","");
				//alert($("#empUpdateModal form").serialize());
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
					type:"PUT",
					data:$("#empUpdateModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						//1.关闭模态框
						$("#empUpdateModal").modal('hide');
						//2.发送ajax请求，来到显示的最后一页数据
						to_page(currentPage);
					}
				}); 
			}
		});
		
		//查出部分信息，显示在下拉列表
		function getDepts(ele){
			//清空下拉列表
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_from(){
			//1.拿到要校验的数据，使用正则表达式
			//校验用户名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","用户名为6-16位数字、字母组合或2-5位汉字!");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /(^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","邮箱格式错误！");
				return false;
			} else{
				show_validate_msg("#email_add_input","success","");
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//清除父的类
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if(status == "success"){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if(status == "error"){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//绑定事件
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuse",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用！");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//点击保存，保存员工
		$("#emp_save_btn").click(function(){
			//1.将模态框的数据保存到服务器
			//添加员工前进行前端校验
			if(!validate_add_from()){
				return false;
			} 
			
			if($(this).attr("ajax-va") == "error"){
				return false;
			} 
			
			//2.发送ajax请求保存员工
			//alert($("#empAddModal form").serialize());//序列化，将表单数据转为字符串
			    $.ajax({
				url:"${APP_PATH}/depts",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code == 100){
						//1.关闭模态框
						$("#empAddModal").modal('hide');
						//2.发送ajax请求，来到显示的最后一页数据
						to_page(totalRecord);
					}else{
						//显示失败信息
						if(undefined != result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
					}
				}
			});  
		});
		
		//完成全选和全不选
		$("#check_all").click(function(){
			//attr获取自定义属性，prop获取dom原生属性
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断被选中的元素是否为5个
			if($(".check_item:checked").length==$(".check_item").length){
				$("#check_all").prop("checked",true);
			}else{
				$("#check_all").prop("checked",false);
			}
		});
		
		//点击全部删除按钮就批量删除
		$("#emp_delete_all_btn").click(function(){
			var empIds = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empIds += $(this).parents("tr").find("td:eq(1)").text()+"，";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			
			//去除empIds多余的逗号
			empIds = empIds.substring(0,empIds.length-1);
			
			//去除del_idstr多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			
			if(confirm("确定删除【"+empIds+"】号员工吗？")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>