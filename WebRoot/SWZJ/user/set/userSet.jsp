<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="robots" content="none" />
		<title>404 Not Found</title>
		<style>
			* {
				font-family: "Microsoft Yahei";
				margin: 0;
				font-weight: lighter;
				text-decoration: none;
				text-align: center;
				line-height: 2.2em;
			}

			html,
			body {
				height: 100%;
			}

			h1 {
				font-size: 100px;
				line-height: 1em;
			}

			table {
				width: 100%;
				height: 100%;
				border: 0;
			}
		</style>
	</head>
	<body>
		<table cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<h1>施工中</h1>
								<h3>设置页面维护中...</h3>
								<p>去访问其他的页面吧！！！<br />
									<a href="/CSMS/index.jsp">回到主页 ></a>
								</p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
