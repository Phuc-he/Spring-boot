<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url var="buildingListURL" value="/admin/building-list"/>
<c:url var="buildingAPI" value="/api/building"/>
<c:url var="formAjax" value="/api/user"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách tòa nhà</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/font-awesome/4.2.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="assets/css/ace.min.css" class="ace-main-stylesheet" id="main-ace-style" />
</head>
<body>
<ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="<c:url value="/admin/home"/>">
                                <%--<spring:message code="label.home"/>--%>
                            Trang chủ
                        </a>
                    </li>
                    <li class="active">
                            <%--<spring:message code="label.user.list"/>--%>
                        Danh sách tòa nhà
                    </li>
                </ul>
        <div class="main-container" id="main-container">
            <div class="main-content" >

                <div class="page-header">
                    <h1>
                        Quản lý tòa nhà
                    </h1>
                </div><!-- /.page-header -->
                <div class="col-xs-12">
                    <div class="widget-box">
                        <div class="widget-header">
                            <h4 class="widget-title">Tìm kiếm</h4>

                            <div class="widget-toolbar">
                                <a href="#" data-action="collapse">
                                    <i class="ace-icon fa fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>

                        <div class="widget-body" style="font-family: 'Times New Roman', Times, serif;">
                            <div class="widget-main">
                                <form:form action = "${buildingListURL}" id="listForm" method="GET" modelAttribute="modelSearch">
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="col-xs-12">
                                                <div class="col-ms -6">
                                                    <label class="name">Tên tòa nhà</label>
                                                    <form:input  class="form-control" path="name"/>
                                                </div>
                                                <div class="col-ms-6">
                                                    <label class="name">Diện tích sàn</label>
                                                   <form:input  class="form-control" path="floorArea"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-12">
                                                <div class="col-ms-2">
                                                    <label class="name">Quận</label>
                                                    <form:select path="district" id="" class="form-control">
                                                        <form:option value="">---Chọn quận---</form:option>
                                                        <form:options items="${districts}"/>
                                                    </form:select>
                                                </div>
                                                <div class="col-ms-5">
                                                    <label class="name">Phường</label>
                                                    <form:input  class="form-control" path="ward"/>
                                                </div>
                                                <div class="col-ms-5">
                                                    <label class="name">Đường</label>
                                                    <form:input  class="form-control" path="street"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-12">
                                                <div class="col-ms-4">
                                                    <label class="name">Số tầng hầm</label>
                                                    <form:input  class="form-control" path="numberOfBasement"/>
                                                </div>
                                                <div class="col-ms-4">
                                                    <label class="name">Hướng</label>
                                                    <form:input  class="form-control" path="direction"/>
                                                </div>
                                                <div class="col-ms-4">
                                                    <label class="name">Hạng</label>
                                                    <form:input  class="form-control" path="level"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-12">
                                                <div class="col-ms-3">
                                                    <label class="name">Diện tích từ</label>
                                                    <form:input  class="form-control" path="areaFrom"/>
                                                </div>
                                                <div class="col-ms-3">
                                                    <label class="name">Diện tích đến</label>
                                                    <form:input  class="form-control" path="areaTo"/>
                                                </div>
                                                <div class="col-ms-3">
                                                    <label class="name">Giá thuê từ</label>
                                                    <form:input  class="form-control" path="rentPriceFrom"/>
                                                </div>
                                                <div class="col-ms-3">
                                                    <label class="name">Giá thuê đến</label>
                                                    <form:input  class="form-control" path="rentPriceTo"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-12">
                                               <div class="col-ms-5">
                                                   <label class="name">Tên quản lý</label>
                                                   <form:input class="form-control" path="managerName" />
                                               </div>
                                               <div class="col-ms-5">
                                                   <label class="name">Điện thoại quản lý</label>
                                                   <form:input class="form-control" path="managerPhone" />
                                               </div>
                                               <div class="col-ms-2">
                                                   <label class="name">Chọn nhân viên quản lý</label>
                                                   <form:select class="form-control" path="staffId">
                                                       <form:option value="">---Chọn nhân viên---</form:option>
                                                       <form:options items="${listStaffs}"/>
                                                   </form:select>
                                               </div>
                                            </div>
                                            <div class="col-xs-12">
                                                <div class="col-ms-6">
                                                    <form:checkboxes items = "${typeCodes}" path="typeCode"/>
                                                </div>
                                            </div>
                                            <div class="col-xs-12">
                                                <div class="col-ms-6">
                                                    <button class="btn btn-xs btn-danger" id="btnSearchBuilding">
                                                            <i class="ace-icon glyphicon glyphicon-search"></i>
                                                            Tìm kiếm
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>

                        <div class="pull-right" style="margin-bottom: 50px">
                        <a href = "/admin/building-edit">
                            <button class="btn-info btn" title="Thêm tòa nhà">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                    <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                    <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                </svg>
                            </button>
                        </a>
                            <button class="btn-danger btn" title="Xóa tòa nhà" id="btnDeleteBuilding">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-dash" viewBox="0 0 16 16">
                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1"/>
                                    <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                    <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                </svg>
                            </button>
                        </div>

                    </div>
                    <!-- Bang danh sach -->
                         <div class="row">
                            <div class="col-xs-12">
                                <table id="tableList" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace">
                                                    <span class="lbl"></span>
                                                </label>
                                            </th>
                                            <th>Tên tòa nhà</th>
                                            <th>Địa chỉ</th>
                                            <th>Số tầng hầm</th>
                                            <th>Tên quản lý</th>
                                            <th>Số điện thoại quản lý</th>
                                            <th>DT sàn</th>
                                            <th>DT trống</th>
                                            <th>DT thuê</th>
                                            <th>Phí môi giới</th>
                                            <th class="hidden-480">Thao tác</th>

                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items = "${buildingList}">
                                        <tr>
                                            <td class="center">
                                                <label class="pos-rel">
                                                    <input type="checkbox" class="ace" name="checkList" value="${item.id}">
                                                    <span class="lbl"></span>
                                                </label>
                                            </td>

                                            <td>${item.name}</td>
                                            <td>${item.address}</td>
                                            <td>${item.numberOfBasement}</td>
                                            <td>${item.managerName}</td>
                                            <td>${item.managerPhone}</td>
                                            <td>${item.floorArea}</td>
                                            <td></td>
                                            <td></td>
                                            <td>${item.brokerageFee}</td>

                                            <td>
                                                <div class="hidden-sm hidden-xs btn-group">
                                                    <button class="btn btn-xs btn-success" title="Giao tòa nhà" onclick="assignmentBuilding(${item.id})">
                                                        <i class="ace-icon fa fa-check bigger-120"></i>
                                                    </button>

                                                    <a class="btn btn-xs btn-info" href="/admin/building-edit-${item.id}" title = "sửa tòa nhà">
                                                        <i class="ace-icon fa fa-pencil bigger-120"></i>
                                                    </a>

                                                    <button class="btn btn-xs btn-danger" title="Xóa tòa nhà" onclick="deleteBuilding(${item.id})">
                                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div><!-- /.span -->
                        </div>
                </div><!-- /.page-content -->
            </div><!-- /.main-content -->

            <div class="footer">
                <div class="footer-inner">
                    <div class="footer-content">
                        <span class="bigger-120">
                            <span class="blue bolder">Ace</span>
                            Application &copy; 2013-2014
                        </span>

                        &nbsp; &nbsp;
                        <span class="action-buttons">
                            <a href="#">
                                <i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
                            </a>

                            <a href="#">
                                <i class="ace-icon fa fa-facebook-square text-primary bigger-150"></i>
                            </a>
                            <a href="#">
                                <i class="ace-icon fa fa-rss-square orange bigger-150"></i>
                            </a>
                        </span>
                    </div>
                </div>
            </div>
        </div><!-- /.main-container -->

            <div class="modal fade" id="assignmentBuildingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="font-family: 'Times New Roman', Times, serif;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Danh sách nhân viên</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                    <table id="staffList" class="table table-striped table-bordered table-hover"  style="font-family: 'Times New Roman', Times, serif;">
                        <thead>
                            <tr>
                                <th>Chọn</th>
                                <th>Tên nhân viên</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                    <input type="hidden" id="buildingId" name="buildingId" value="">
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="btnAssignmentBuilding">Giao tòa nhà</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>

                    </div>
                </div>
            </div>

<script>
    function assignmentBuilding(buildingId) {
        $('#buildingId').val(buildingId);
        loadStaff(buildingId); // Phải gọi hàm này để load danh sách nhân viên
        $('#assignmentBuildingModal').modal('show');
    }

    function loadStaff(buildingId) {
        $.ajax({
            type: "GET", // Lấy danh sách nhân viên nên dùng GET
            url: "${buildingAPI}/" + buildingId + "/staffs",
            dataType: "json",
            success: function(response) {
                var row = "";
                // Sửa lại cú pháp $.each cho đúng
                $.each(response.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="text-center">';
                    row += '    <input type="checkbox" value="' + item.staffId + '" ';
                    row += '           id="checkbox_' + item.staffId + '" ';
                    row += '           class="check-box-element" ' + item.checked + '>';
                    row += '</td>';
                    row += '<td class="text-center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $("#staffList tbody").html(row);
            },
            error: function(response) {
                console.log("Lỗi lấy danh sách nhân viên:", response);
            }
        });
    }
    $(document).ready(function() {
        $('#btnAssignmentBuilding').click(function(e){
            e.preventDefault();
            var data = {};
            data['buildingId'] = $('#buildingId').val();
            var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            data['staffs'] = staffs;
            if( data['staffs'] != ""){
                assignmentBuilding1(data);
            }
            console.log("Data gửi đi:", data);
        });

        function assignmentBuilding1(data){
            $.ajax({
                type: "POST", // Lấy danh sách nhân viên nên dùng GET
                url: "${buildingAPI}/" + "assignment",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "json",
                success: function(response) {
                    console.info("Success");
                },
                error: function(response) {
                    console.log("Lỗi lấy danh sách nhân viên:", response);
                }
            });
        }

        $('#btnSearchBuilding').click(function(e){
            e.preventDefault();
            $('#listForm').submit();
        });
    });

        function deleteBuilding(data){
            var buildingId = [data];
            deleteBuildings(buildingId);
        }

        $('#btnDeleteBuilding').click(function(e){
            e.preventDefault();
            var buildingIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function(){
                return $(this).val();
            }).get();
            deleteBuildings(buildingIds);
        });

        function deleteBuildings(data){
            $.ajax({
                type: "Delete",
                url: "${buildingAPI}/" + data.join(','),      // Đường dẫn đến file hoặc API cần lấy dữ liệu
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function(respond) {
                    location.reload();
                    // Nếu lấy dữ liệu thành công, kết quả trả về nằm trong biến 'result'
                    $("#buildingList").html(data);
                },
                error: function(respond) {
                    // Xử lý nếu xảy ra lỗi (ví dụ: file không tồn tại)
                    console.log(respond);
                }
            });
        }
</script>
</body>

</html>

