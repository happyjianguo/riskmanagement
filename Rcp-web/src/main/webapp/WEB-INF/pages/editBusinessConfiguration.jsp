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
<script type="text/javascript" src="${pageContext.request.contextPath }/js/additional-methods.js"></script>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<div class="ibox-title">
                        <h5>设置行业配置参数</h5>
                    </div>
					<div class="ibox-content">
						<div class="panel admin-panel">
							<div class="body-content">
									<form class="form-horizontal" id="editBusinessConfigurationForm" method="POST"
										role="form">
										<div class="form-group">
											<label class="col-sm-2 control-label">【大额订单】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>单笔交易最大金额:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="bigOrderTxMoney" name="bigOrderTxMoney"
													required="required" placeholder="请输入单笔交易最大金额"
													value="${bigOrderConfigurationParam.bigOrderTxMoney }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
							            
				            
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>说明:</label>
											<div class="col-sm-8">
												<input type="text"
													class="form-control" id="bigOrderRemark" name="bigOrderRemark" required="required"
													placeholder="请输入大额订单说明" value="${bigOrderConfigurationParam.bigOrderRemark }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
										<div class="form-group">
											<label class="col-sm-2 control-label">【可疑订单】</label>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>可疑订单交易金额:</label>
											<div class="col-sm-8">
												<input type="text"
				                  class="form-control" id="doubtfulOrderTxMoney" name="doubtfulOrderTxMoney"
				                  required="required" placeholder="请输入可疑订单交易金额"
				                  value="${doubtfulOrderConfigurationParam.doubtfulOrderTxMoney }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>浮动比率:</label>
											<div class="col-sm-8">
												<input type="text"
				                  class="form-control" id="floatingRate" name="floatingRate"
				                  required="required" placeholder="请输入浮动比率"
				                  value="${doubtfulOrderConfigurationParam.floatingRate }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
										
				            			<div class="form-group">
											<label class="col-sm-2 control-label"><span style="color:red;font-size:18px;">* </span>说明:</label>
											<div class="col-sm-8">
												<input type="text"
				                  class="form-control" id="doubtfulOrderRemark" name="doubtfulOrderRemark" required="required"
				                  placeholder="请输入可以订单说明" value="${doubtfulOrderConfigurationParam.doubtfulOrderRemark }">
											</div>
										</div>
										<div class="hr-line-dashed"></div>
				            
				            			<div class="form-group">
											
											<div class="col-sm-4 col-sm-offset-2">
												<div class="btn-toolbar" role="toolbar">
											<div class="btn-group">
												<button id="submitBtn" type="submit"
													class="btn btn-primary margin-items-top">保 存</button>
											</div>
											<div class="btn-group">
												<button id="resetBtn" type="button"
													class="btn btn-primary margin-items-top">重置</button>
											</div>
											<div class="btn-group">
												<button id="returnBtn" type="button" class="btn btn-primary">返回</button>
											</div>
										</div>
										<input type="hidden" id="id" name="id" value="${bigOrderConfiguration.businessId }">
										<input type="hidden" id="bigOrderId" name="bigOrderId" value="${bigOrderConfiguration.id }">
										<input type="hidden" id="doubtfulId" name="doubtfulId" value="${doubtfulOrderConfiguration.id }">
										<input type="hidden" name="creatorId" value="${bigOrderConfiguration.creatorId }">
										<input type="hidden" name="createDate" value="${bigOrderConfiguration.createDate }">
											</div>
										</div>
				
										
									</form>
							</div>
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

		$.validator.setDefaults({
			submitHandler : function(form) {
				ajaxSubmitForm();
			}
		});

		$(function() {
			// 在键盘按下并释放及提交后验证提交表单
			$("#editBusinessConfigurationForm").validate({
				invalidHandler : function(form, validator) { //不通过回调
					return false;
				},
				rules : {
					bigOrderTxMoney : {
						required : true,
						validatePositiveNum : true
					},
					bigOrderRemark : {
						required : true
					},
					doubtfulOrderTxMoney : {
						required : true,
						validatePositiveNum : true
					},
					floatingRate : {
            			required : true,
            			validateDecimals : true
          			},
          			doubtfulOrderRemark : {
            			required : true
          			}
				},
				messages : {
					bigOrderTxMoney : {
						required : "请输入单笔交易最大金额！",
						validatePositiveNum : "请输入正整数！"
					},
					bigOrderRemark : {
						required : "请输入大额订单说明！"
					},
					doubtfulOrderTxMoney : {
						required : "请输入可疑订单交易金额！",
						validatePositiveNum : "请输入正整数！"
					},
					floatingRate : {
            			required : "请输入浮动比率！",
            			validateDecimals : "请输入正确的小数！"
          			},
         			 doubtfulOrderRemark : {
            			required : "请输入可以订单说明！"
          	}
				},
				//重写showErrors
				showErrors : function(errorMap, errorList) {
					var msg = "";
					$.each(errorList, function(i, v) {
						//msg += (v.message + "\r\n");
						//在此处用了layer的方法,显示效果更美观
						layer.tips(v.message, v.element, {
							time : 2000
						});
						return false;
					});
				},
				/* 失去焦点时不验证 */
				onfocusout : function(element) {
					$(element).valid();
				},
				//提交表单后，未通过验证的表单（第一个或提交之前获得焦点的未通过验证的表单）会获得焦点。
				focusInvalid : function(element) {
					$(element).valid();
				}
			});
		});

		function ajaxSubmitForm() {
			$
					.ajax({
						cache : false,
						type : "POST",
						url : "${pageContext.request.contextPath }/editBusinessConfiguration",
						data : $('#editBusinessConfigurationForm').serialize(),// 你的formid
						async : false,
						error : function(request) {
							layer.alert('网络异常！', {
								skin : 'layui-layer-molv',
								icon : 5,
								closeBtn : 0,
								btnAlign : 'c', //按钮居中
								anim : 0, //动画类型
								time : 2000
							});
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
						},
						beforeSend : function() {
							//在表单提交后后端未作出响应时，禁用提交按钮，提高用户体验。
							$("#submitBtn").attr({
								disabled : "disabled"
							});
						},
						/* complete : function() {
							//后端响应后放开按钮
							$("#submitBtn").removeAttr("disabled");
						}, */
						success : function(data) {
							if ("success" == data.status) {
								layer
										.alert(
												'编辑成功！',
												{
													skin : 'layui-layer-molv',
													icon : 1,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listBusinessType";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							} else {
								layer
										.alert(
												'编辑失败！',
												{
													skin : 'layui-layer-molv',
													icon : 5,
													closeBtn : 0,
													btnAlign : 'c', //按钮居中
													anim : 0, //动画类型
													time : 2000,
													end : function() {
														window.location.href = "${pageContext.request.contextPath }/listBusinessType";
													}
												});
								//后端响应后放开按钮
								$("#submitBtn").removeAttr("disabled");
								return;
							}
						}
					});
		}
	})

	$("#resetBtn").click(function() {
		window.location.href = "${pageContext.request.contextPath}/showSettingBusinessType?id=" + $("#id").val();
	});
	$("#returnBtn")
			.click(
					function() {
						window.location.href = "${pageContext.request.contextPath}/listBusinessType";
					});
</script>

<script type="text/javascript">
	$(function() {
		$("#floatingRate").change(function() {
			var rate = $("#floatingRate").val();
			var rateSplit = rate.split(".");
			var decimalDigits = rateSplit[1].length;
			if (decimalDigits == 1) {
				$("#floatingRate").val(rate + "0");
			}
		});
		
		$("#bigOrderTxMoney").change(function() {
			var bigOrderTxMoney = $("#bigOrderTxMoney").val().replace(/<\/?[^>]*>/g,'');
			$("#bigOrderTxMoney").val($.trim(bigOrderTxMoney));
		});
		
		$("#bigOrderRemark").change(function() {
			var bigOrderRemark = $("#bigOrderRemark").val().replace(/<\/?[^>]*>/g,'');
			$("#bigOrderRemark").val($.trim(bigOrderRemark));
		});
		
		$("#doubtfulOrderTxMoney").change(function() {
			var doubtfulOrderTxMoney = $("#doubtfulOrderTxMoney").val().replace(/<\/?[^>]*>/g,'');
			$("#doubtfulOrderTxMoney").val($.trim(doubtfulOrderTxMoney));
		});
		
		$("#floatingRate").change(function() {
			var floatingRate = $("#floatingRate").val().replace(/<\/?[^>]*>/g,'');
			$("#floatingRate").val($.trim(floatingRate));
		});
		
		$("#doubtfulOrderRemark").change(function() {
			var doubtfulOrderRemark = $("#doubtfulOrderRemark").val().replace(/<\/?[^>]*>/g,'');
			$("#doubtfulOrderRemark").val($.trim(doubtfulOrderRemark));
		})
	});	
</script>

</html>