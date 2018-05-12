<%--
  Created by IntelliJ IDEA.
  User: Yz
  Date: 2018/5/8
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>

</head>
<body>

<script type="text/javascript">
    //获取分页数据
    $(function () {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn=1",
            type:"GET",
            success:function (result) {
                console.log(result);
            }
        });
    });
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
            <button class="btn-primary">新增</button>
            <button class="btn-danger">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <%--偏移8列 总共12列--%>
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.id}</th>
                        <th>${emp.lastName}</th>
                        <th>${emp.gender=="f"?"女":"男"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.departName}</th>
                        <th>
                            <button class="btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil"/>
                                编辑
                            </button>
                            <button class="btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash"/>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--页码--%>
    <div class="row">
        <div class="col-md-6">
            当前${pageInfo.pageNum}页,总共${pageInfo.pages}页,总${pageInfo.total}记录数
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageInfo.pageNum == pageNum}">
                        <li class="active"><a href="#">${pageNum}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum != pageNum}">
                            <li ><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                    <li>
                        <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    </c:if>
                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>

</body>
</html>
