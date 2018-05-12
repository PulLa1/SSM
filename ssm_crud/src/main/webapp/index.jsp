<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<%--模态框--%>
<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="empFrom">
                    <div class="form-group">
                        <label for="lastName_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="lastName" id="lastName_input" placeholder="lastName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_input" placeholder="email@xx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male_input" checked="checked" value="m"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female_input" value="f"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="empUpdateFrom">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" name="lastName" id="lastName_update_input" ></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" name="email" id="email_update_input" placeholder="email@xx.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male_update_input" checked="checked" value="m"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female_update_input" value="f"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    var tatalRecord; // 总记录数
    var currentPage; // 当前页
    $(document).ready(function(){

        //点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            reset_form("#empAndModal form");
            getDepts("#empAndModal select");
            $("#empAndModal").modal({
                backdrop:"static"
            });
        });
        //新增保存方法
        $("#emp_save_btn").click(function () {
            if (!validata_add_form()){
                return false;
            }
            if($(this).attr("ajax-value")=="error"){
                return false;
            }
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAndModal form").serialize(),
                success:function (result) {
                    if (result.code == 100) {
                        $("#empAndModal").modal('hide');
                        to_page(tatalRecord);
                    }else{
                    //    跳过前段校验 后端校验显示失败信息
                        //
                        if (undefied != result.extend.errorfield.email){
                            show_validata_msg("#email_input","error",result.extend.errorfield.email);
                        }else if(undefied != result.extend.errorfield.lastName){
                            show_validata_msg("#lastName_input","error",result.extend.errorfield.lastName);
                        }
                    }
                }
            });
             // alert($("#empAndModal form").serialize());
        });
        //新增 名字校验
        $("#lastName_input").change(function () {
            //发送ajax请求校验用户名是否可用
            var lastName = this.value;
            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:"lastName="+lastName,
                type:"POST",
                success:function (result) {
                    if (result.code == 100){
                        show_validata_msg("#lastName_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-value","success");
                    }else {
                        show_validata_msg("#lastName_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-value","error");
                    }
                }
            });
        });

        // 点击编辑弹出模态框，由于绑定生成在控件生成之前 所以用这个方法
        $(document).on("click",".edit_btn",function () {
            //alert("esd");
            getDepts("#empUpdateModal select");
            getEmp($(this).attr("edit_id"));
            //给更新按钮赋予id值
            $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });

        //编辑 模态框 更新按钮事件
        $("#emp_update_btn").click(function () {
            var Email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if (!regEmail.test(Email)){
                show_validata_msg("#email_input","error","请输入正确的邮箱格式");
                return false;
            }else {
                show_validata_msg("#email_input","success","");
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),
                    success:function (result) {
                        $("#empUpdateModal").modal('hide');
                        to_page(currentPage);
                    }
                });
            }

        });

        //删除单行
        $(document).on("click",".delete_btn",function () {
           // alert($(this).attr("delete_id"));
            var lastName = $(this).parents("tr").find("td:eq(2)").text();
            if (confirm("确认删除 "+lastName+" 吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                });
            }
        });

        //完成全选
        $("#check_all").click(function () {
            // prop读取原生值
            //alert($(this).prop("checked"));
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        $(document).on("click",".check_item",function () {
            //alert($(".check_item").length);
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);
        });

        //删除所有选中的
        $("#emp_delete_all").click(function () {
            var lastNames = "";
            var deIdString = ""
            $.each($(".check_item:checked"),function () {
                lastNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                deIdString += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            lastNames = lastNames.substring(0,lastNames.length-1);
            deIdString = deIdString.substring(0,lastNames.length-1);
            if (confirm("确认删除 "+lastNames+" 吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+deIdString,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        });

    });



    //获取员工信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var employee = result.extend.employee;
                $("#lastName_update_input").text(employee.lastName);
                $("#email_update_input").val(employee.email);
                $("#empUpdateModal input[name=gender]").val([employee.gender]);
                $("#empUpdateModal select").val([employee.deptId]);
            }
        });
    }
    //清空表单内容和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //校验新增模板里的名字和email
    function validata_add_form() {
        // var lastName = $("#lastName_input").val();
        // var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        // if (!regName.test(lastName)){
        //     show_validata_msg("#lastName_input","error","请输入正确的用户名");
        //     return false;
        // }else {
        //     show_validata_msg("#lastName_input","success","");
        // }
        var Email = $("#email_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(Email)){
            show_validata_msg("#email_input","error","请输入正确的邮箱格式");
            return false;
        }else {
            show_validata_msg("#email_input","success","");
        }
        return true;
    }
    //添加框中的提示信息
    function show_validata_msg(ele,status,msg) {
        //清楚元素
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if ("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //查询部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
           url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.departName).attr("value",this.id);
                    optionEle.appendTo(ele);
                })
            }
        });
    }
    //获取分页数据
    $(function () {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=1",
            type:"GET",
            success:function (result) {
                //console.log(result);
                build_emps_table(result);

                build_page_info(result);

                build_page_nav(result);
            }
        });
    });

    function to_page(pn) {
        $(function () {
            $.ajax({
                url:"${APP_PATH}/emps?pn="+pn,
                data:"pn=1",
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    build_emps_table(result);

                    build_page_info(result);

                    build_page_nav(result);
                }
            });
         });
    }
    //完成表格
    function build_emps_table(result) {
        //清空数据
        $("#emps_table tbody").empty();
        var emps= result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            // alert(item.lastName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var idTd = $("<td></td>").append(item.id);
            var lastNameTd = $("<td></td>").append(item.lastName);
            var genderTd = $("<td></td>").append(item.gender=="f"?"女":"男");
            var emailTd = $("<td></td>").append(item.email);
            var departNameTd = $("<td></td>").append(item.department.departName);
            var editBtn = $("<button></button>").addClass("btn-primary btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑")
                .attr("edit_id",item.id);
            var deleBtn =$("<button></button>").addClass("btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除")
                .attr("delete_id",item.id);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
            $("<tr></tr>").append(checkBoxTd).append(idTd)
                .append(lastNameTd).append(genderTd)
                .append(emailTd).append(departNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分信息
     <%--当前${pageInfo.pageNum}页,总共${pageInfo.pages}页,总${pageInfo.total}记录数--%>
    function build_page_info(result) {
        $("#page_info").empty();
        $("#page_info").append("当前"+result.extend.pageInfo.pageNum+"页,总共$"+result.extend.pageInfo.pages
            +"页,总"+result.extend.pageInfo.total+"记录数");
        tatalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        if (result.extend.pageInfo.hasPreviousPage == false){ //如果有上一页则可以点击并且显示
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum-1);
        });
        firstPageLi.click(function () {
            to_page(1);
        });
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if (result.extend.pageInfo.pageNum == item){ //如果是当前页面则 亮色显示
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if (result.extend.pageInfo.hasNextPage == false){ //如果有下一页则可以点击并且显示
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum+1);
        });
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);
        });

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav");
    }



</script>

<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn-primary" id="emp_add_modal_btn" >新增</button>
            <button class="btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <%--偏移8列 总共12列--%>
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
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
    <%--页码--%>
    <div class="row">
        <div class="col-md-6" id="page_info">

        </div>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>

</body>
</html>
