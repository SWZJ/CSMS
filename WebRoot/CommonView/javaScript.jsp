<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script src="/CSMS/public/assets/vendor/jquery/jquery.min.js"></script>
<script src="/CSMS/public/assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="/CSMS/public/assets/vendor/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="/CSMS/public/assets/vendor/toastr/toastr.min.js"></script>
<script src="/CSMS/public/assets/vendor/jquery.easy-pie-chart/jquery.easypiechart.min.js"></script>
<script src="/CSMS/public/assets/vendor/chartist/js/chartist.min.js"></script>
<script src="/CSMS/public/assets/scripts/klorofil-common.js"></script>
<script src="/CSMS/public/assets/scripts/jquerysession.js"></script>
<script src="/CSMS/public/assets/scripts/common.js"></script>
<script src="https://cdn.bootcss.com/jquery-scrollTo/2.1.2/jquery.scrollTo.min.js"></script>

<script>
//消息页面语言切换
$("#english").click(function(){
	alert($.session.get("language"));
	$.session.set('language', 'english');
	alert($.session.get("language"));
});
$("#chinese").click(function(){
	alert($.session.get("language"));
	$.session.set('language', 'chinese');
	alert($.session.get("language"));
});
</script>

