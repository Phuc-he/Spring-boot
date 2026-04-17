<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formUrl" value="/admin/user-list"/>
<c:url var="buildingAddURL" value="/admin/building-edit"/>
<c:url var="formAjax" value="/api/user"/>
<c:url var="buildingAPI" value="/api/building"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>
        <%--<spring:message code="label.user.list"/>--%>
        Thêm tòa nhà
    </title>

    		<!-- bootstrap & fontawesome -->
    		<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    		<link rel="stylesheet" href="assets/font-awesome/4.2.0/css/font-awesome.min.css" />

    		<!-- page specific plugin styles -->

    		<!-- text fonts -->
    		<link rel="stylesheet" href="assets/fonts/fonts.googleapis.com.css" />

    		<!-- ace styles -->
    		<link rel="stylesheet" href="assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
</head>
<body>
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#">Home</a>
                    </li>
                    <li class="active">Dashboard</li>
                </ul><!-- /.breadcrumb -->
            </div>

            <div class="page-content">
                <div class="ace-settings-container" id="ace-settings-container">
                    <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                        <i class="ace-icon fa fa-cog bigger-130"></i>
                    </div>

                    <div class="ace-settings-box clearfix" id="ace-settings-box">
                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <div class="pull-left">
                                    <select id="skin-colorpicker" class="hide">
                                        <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                        <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                        <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                        <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                                    </select>
                                </div>
                                <span>&nbsp; Choose Skin</span>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
                                <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
                                <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
                                <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
                                <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
                                <label class="lbl" for="ace-settings-add-container">
                                    Inside
                                    <b>.container</b>
                                </label>
                            </div>
                        </div><!-- /.pull-left -->

                        <div class="pull-left width-50">
                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
                                <label class="lbl" for="ace-settings-hover"> Submenu on Hover</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
                                <label class="lbl" for="ace-settings-compact"> Compact Sidebar</label>
                            </div>

                            <div class="ace-settings-item">
                                <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
                                <label class="lbl" for="ace-settings-highlight"> Alt. Active Item</label>
                            </div>
                        </div><!-- /.pull-left -->
                    </div><!-- /.ace-settings-box -->
                </div><!-- /.ace-settings-container -->

                <div class="page-header">
                    <h1>
                        Quản lý tòa nhà
                    </h1>
                </div><!-- /.page-header -->
                <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                    <form:form modelAttribute = "buildingEdit" id="listForm" method = "GET" action = "${buildingAddURL}">
                        <div class="col-xs-12">
                            <!-- PAGE CONTENT BEGINS -->
                            <form  role="form"  class="form-horizontal">

                                <div class="form-group">
                                    <label class="col-xs-3"> Tên tòa nhà </label>
                                    <div class="col-xs-9">
                                        <form:input class="form-control" path="name"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Quận </label>
                                    <div class="col-sm-4">
                                        <form:select path="district" id="" class="form-control">
                                            <form:option value="">---Chọn quận---</form:option>
                                            <form:options items="${districts}"/>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phường </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="ward"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Đường </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="street"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Kết cấu </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="structure"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Số tầng hầm </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="numberOfBasement"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Diện tích sàn </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="floorArea"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Hướng </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="direction"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Hạng </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="level"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Diện tích thuê </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="rentArea"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3" > Giá thuê </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="rentPrice"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Mô tả giá </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="rentPriceDescription"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phí dịch vụ </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="serviceFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phí ô tô </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="carFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phí xe máy </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="motorbikeFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phí ngoài giờ </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="overtimeFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Tiền nước </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="waterFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Tiền điện </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="electrictyFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Đặt cọc </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="deposit"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Thanh toán </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="payment"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Thời gian thuê </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="rentTime"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Thời gian trang trí </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="decorationTime"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Tên quản lý </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="managerName"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> SĐT quản lý </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="managerPhone"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Phí môi giới </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="brokerageFee"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3" for="form-field-1-1"> Loại tòa nhà </label>
                                    <div class="col-sm-3" style="display: flex; flex-direction: row; justify-content: space-between;">
                                        <form:checkboxes items = "${typeCodes}" path="typeCode"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"> Ghi chú </label>
                                    <div class="col-sm-9">
                                        <form:input  class="form-control" path="note"/>
                                    </div>
                                </div>
                                <div class="space-4"></div>
                                <div class="form-group">
                                    <label class="col-sm-3"></label>
                                    <div class="col-sm-9">
                                        <c:if test="${not empty buildingEdit.id}">
                                        <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding">Cập nhật tòa nhà</button>
                                        <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                        </c:if>
                                        <c:if test="${empty buildingEdit.id}">
                                            <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding">Thêm mới</button>
                                            <button type="button" class="btn btn-primary" id="btnCancel">Hủy thao tác</button>
                                        </c:if>
                                    </div>
                                </div>
                                <form:hidden path="id" id="buildingId"/>
                            </form>
                            </div><!-- PAGE CONTENT ENDS -->
                        </div><!-- /.col -->
                    </form:form>
                </div>
            </div><!-- /.page-content -->
        </div>
    </div><!-- /.main-content -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $('#btnAddOrUpdateBuilding').click(function(){
            var data = {};
            var typeCode = [];
            var formData = $('#listForm').serializeArray();
            $.each(formData, function(i,v){
                if(v.name != 'typeCode'){
                    data["" + v.name + ""] = v.value;
                }else{
                    typeCode.push(v.value);
                }
            })
            data['typeCode'] = typeCode;
            var buildingId = $('#buildingId').val();  // Lấy id tòa nhà từ form
            if (buildingId != "") {
                // Nếu có id => là cập nhật
                btnAddOrUpdateBuilding(data, buildingId);
            } else {
                // Nếu không có id => là thêm mới
                btnAddOrUpdateBuilding(data, null);
            }
        });

        function btnAddOrUpdateBuilding(data, buildingId) {
            // Gọi API để lưu hoặc cập nhật tòa nhà
            var url = buildingId ? "${buildingAPI}/" + buildingId : "${buildingAPI}";  // Nếu có id thì gọi API cập nhật, không có id thì gọi API thêm mới
            $.ajax({
                type: "POST",
                url: url,  // Sử dụng url có chứa id nếu đang cập nhật
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function(respond) {
                    $("#h11").html("Success");
                    window.location.href = "/admin/building-list"; // Chuyển hướng đến trang danh sách
                },
                error: function(respond) {
                    console.log(respond);
                }
            });
        }

        $('#btnCancel').click(function(){
            window.location.href = "/admin/building-list";
        });


    </script>
</body>

</html>