<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<%@ include file="../commons/sourceFile.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
</head>

<body class="gray-bg">
<input type="hidden" name="systemAccount" id="systemAccount" value="${systemAccount}" />
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>商家风险报表</h5>
                    </div>
				
					<div class="ibox-content">
						<form class="form-inline" role="form">
							<table>
								<tr>
									<td>
										<div class="input-group" id ="user">
											
										</div>
									</td>
									<td>
										<div class="input-group">
											<span class="input-group-addon">时间范围:</span> 
											<input type="text" onFocus="var endTime=$dp.$('endTime');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')||\'%y-%M-%d-%H:%m:%s\'}',minDate:'#F{$dp.$D(\'endTime\',{M:-6})}'})"
												class="Wdate form-control" style="height: 34px;border: 1px solid #cccccc;" id="startTime" name="startTime"
												placeholder="请选择起始时间"> 
												<span
												class="input-group-addon">至</span> 
												<input type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'startTime\',{M:6})||\'%y-%M-%d-%H:%m:%s\'}'})"
												class="Wdate form-control" style="height: 34px;border: 1px solid #cccccc;"  id="endTime" name="endTime"
												placeholder="请选择结束时间">
										</div>
									</td>
									<td>
										<button type="button" class="btn btn-primary margin-items-top"
											id="searchBtn">查询</button>
									</td>
								</tr>
							</table>
						</form>
						<div style="margin-left: 0px;margin-right: 0px">
						<table id="tb_listBusiness"></table>
					</div>
					</div>
				
					
					<br>
					<br>
					<br>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(function() {

		//1.初始化Table
		

	});

	var TableInit = function() {
		var oTableInit = new Object();
		//初始化Table
		//console.log($("#userId").val());
		oTableInit.Init = function() {
			$('#tb_listBusiness').bootstrapTable({
				url : '${pageContext.request.contextPath }/getStatisticsData', //请求后台的URL（*）
				method : 'post', //请求方式（*）
				toolbar : '#toolbar', //工具按钮用哪个容器
				contentType : 'application/x-www-form-urlencoded',
				striped : true, //是否显示行间隔色
				cache : false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
				pagination : true, //是否显示分页（*）
				sortable : false, //是否启用排序
				//sortName : 'riskTimes',//初始化的时候排序的字段
				//sortOrder: "asc", //排序方式
				//sortOrder : "desc", //排序方式
				sidePagination : "server", //分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, //初始化加载第一页，默认第一页
				pageSize : 10, //每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], //可供选择的每页的行数（*）
				//search : true, //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
				//strictSearch : true,
				//showColumns : true, //是否显示所有的列
				//showRefresh : true, //是否显示刷新按钮
				minimumCountColumns : 2, //最少允许的列数
				clickToSelect : true, //是否启用点击选中行
				smartDisplay: false,//智能显示分页按钮
			    paginationPreText: "上一页",
			    paginationNextText: "下一页",
				//height : 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
				//uniqueId : "id", //每一行的唯一标识，一般为主键列
				//showToggle : true, //是否显示详细视图和列表视图的切换按钮
				//cardView : false, //是否显示详细视图
				//detailView : false, //是否显示父子表
				columns : [ {
					field : 'merchantId',
					title : '商家号',
					align : 'center',
					
				},   {
					field : 'riskTimes',
					title : '风险事件数',
					align : 'center',
					sortable:"true",
		          formatter : function(value, row,
		                  index) {
		                var e = value + " 次";
		                return e;
		              }
				},{
					field : 'systemCode',
					title : '查看交易趋势',
					align : 'center',
					formatter : function(value, row,
							index) {
						var e = '';
						var detail = '<button href="#" class="btn-primary" onclick="showDetail(\''
							+ row.merchantId
							+ '\',\''
							+ $("#startTime").val()
							+ '\',\''
							+ $("#endTime").val()
							+ '\',\''
							+ $("#userId").val()
							+ '\')">查看</button>';
						return e + detail;
					}
				} ],
				queryParams : oTableInit.queryParams
			//传递参数（*）
			});
		};

		//得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				limit : params.limit, //页面大小
				offset : params.offset, //页码
				//sort: params.sort,  //排序列名  
			   // sortOrder: params.order, //排位命令（desc，asc） 
			    startTime : $("#startTime").val(),
				endTime : $("#endTime").val(),
				statisType : 'MerchantStatistics',
				systemId:$("#userId").val()
				
			};
			return temp;
		};
		return oTableInit;
	};

	var ButtonInit = function() {
		var oInit = new Object();
		var postdata = {};

		oInit.Init = function() {
			//初始化页面上面的按钮事件
		};

		return oInit;
	};
	
	$("#searchBtn").click(function() {
		$('#tb_listBusiness').bootstrapTable('destroy');
		var oTable = new TableInit();
		oTable.Init();
	});
	
</script>
<script type="text/javascript">
	$(function() {
		
		var systemAccount = $("#systemAccount").val();
		if(systemAccount =='1'){
			$("#user").append('<span class="input-group-addon">系统:</span><div class="sel"> <select id="userId" required="required" class="form-control" name="userId"> </select></div>');
			//$("#userId").append('<option value="1">1</option>');
			$.ajax({
				url : "${pageContext.request.contextPath}/getAllAdmin",
				type : "post",
				dataType : "json",
				contentType : "application/json",
				async : true,
				cache : false,
				success : function(data) {
					if (data) {
						for (var i = 0; i < data.length; i++) {
							if ('PTYH' == data[i].systemCode) {
								$("#userId").append('');
							} else {
								$("#userId").append(
										'<option value="'+data[i].systemId+'">'
												+ data[i].systemName + '</option>');
							}
							
						}
						var oTable = new TableInit();
						oTable.Init();

						//$('#tb_notice').bootstrapTable('hideColumn', 'id');//隐藏某一列

						//2.初始化Button的点击事件
						var oButtonInit = new ButtonInit();
						oButtonInit.Init();
					}
				}
			}); 
		}else{
			$("#user").append('<input type="hidden" name="userId" id="userId" value="" />');
		}
		
	});
</script>
<script type="text/javascript">
		function showDetail(merchantId,startTime,endTime,userId) {
			var pageUrl = "${pageContext.request.contextPath}/showRcEventDetail?merchantId="+ merchantId + "&detailType=BusinessDetail" + "&startTime=" + startTime + "&endTime=" + endTime+ "&systemId=" + userId
			var diag = new Dialog();
			diag.Width = 1000;
			diag.Height = 500;
			diag.Title = "查看交易趋势图";
			diag.URL = pageUrl;
			diag.Drag = false;
			diag.show();
		}
</script>
</html>