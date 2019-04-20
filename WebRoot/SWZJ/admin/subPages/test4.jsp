<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

<!doctype html>
<html>

<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<body>
<!-- WRAPPER -->
<div id="wrapper">
    <!-- NAVBAR -->
        <nav class="navbar navbar-default navbar-fixed-top">
        <div class="brand">
            <a href="http://localhost:8888/GPMS/public/index.php"><img src="http://localhost:8888/GPMS/public/assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
        </div>
        <div class="container-fluid">
                        <div id="navbar-menu">
                <ul class="nav navbar-nav navbar-right">
                                            <li><a href="http://localhost:8888/GPMS/public/index.php/login">登陆</a></li>
                                    </ul>
            </div>
        </div>
    </nav>
        <!-- END NAVBAR -->
        <!-- MAIN CONTENT -->
    <div class="main-content">
                    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">登陆</div>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form" method="POST" action="http://localhost:8888/GPMS/public/index.php/login">
                            <input type="hidden" name="_token" value="dU2B8UNS8DJ1e1RApeBXzh8908t6UtWcSaTdxsKo">

                            <div class="form-group">
                                <label for="user_job_id" class="col-md-4 control-label">用户名</label>

                                <div class="col-md-6">
                                    <input id="user_job_id" type="text" class="form-control" name="user_job_id" placeholder="用户名(学号/工号)" value="">

                                                                    </div>
                            </div>

                            <div class="form-group">
                                <label for="password" class="col-md-4 control-label">密码</label>

                                <div class="col-md-6">
                                    <input id="password" type="password" class="form-control" name="password" placeholder="用户密码(初始密码为:)">

                                                                    </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-4">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="remember"> 下次自动登陆
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-6 col-md-offset-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-btn fa-sign-in"></i> 登陆
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
            </div>
    <!-- END MAIN CONTENT -->
    <div class="clearfix"></div>

    <footer>
        <div class="container-fluid">
            <p class="copyright">Copyright &copy; 2017.Company name All rights reserved.</p>
        </div>
    </footer>

</div>
<!-- END WRAPPER -->
<!-- Javascript -->
<script src="http://localhost:8888/GPMS/public/assets/vendor/jquery/jquery.min.js"></script>
<script src="http://localhost:8888/GPMS/public/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="http://localhost:8888/GPMS/public/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="http://localhost:8888/GPMS/public/assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="http://localhost:8888/GPMS/public/assets/vendor/chartist/js/chartist.min.js"></script>
<script src="http://localhost:8888/GPMS/public/assets/scripts/klorofil-common.js"></script>
</body>

</html>
