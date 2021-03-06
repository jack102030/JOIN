<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.newsinfo.model.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	NewsInfoService newsinfoSvc = new NewsInfoService();
	List<NewsInfoVO> list = newsinfoSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>listallNewsInfo</title>

<style>
table#table-1 {
	background-color: #00caca;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}

#pic {
	width: 135px;
	hight: 200px;
}
</style>

<style>
table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

<!-- Bootstrap CSS start-->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css">
<!-- Bootstrap CSS end-->

</head>
<body bgcolor='white'>

	<jsp:include page="/BackHeaderFooter/Header.jsp" />
	<h1></h1>
	<br>
	<!-- 工作區開始 -->

	<div class="container">
		<div class="row justify-content">
			<div class="col-12">
				<!-- BT -->

				<div class="card">
					<div class="card-header">
						<h4>電影新聞瀏覽</h4>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<%@ include file="page1.file"%>
							<table class="table table-striped mb-0">
								<tr>
									<th>專欄編號</th>
									<th>電影編號</th>
									<th>專欄標題</th>
									<th>專欄作者</th>
									<th>發文日期</th>
									<th>專欄圖片</th>
									<!-- <th>專欄內容</th> -->
									<th colspan="2">編輯</th>
								</tr>

								<c:forEach var="newsinfoVO" items="${list}"
									begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

									<tr>
										<td>${newsinfoVO.news_no}</td>
										<td>${newsinfoVO.movie_no}</td>
										<td>${newsinfoVO.news_title}</td>
										<td>${newsinfoVO.news_auther}</td>
										<td>${newsinfoVO.news_times}</td>
										<!-- 新增圖片			 -->
										<c:set var="news_pic" value="${newsinfoVO.news_pic}"></c:set>
										<%
											byte b[] = (byte[]) pageContext.getAttribute("news_pic");
												String encode = null;
												if (b != null) {
													encode = Base64.encode(b);
										%>
										<td><img id="pic" src="data:image/jpg;base64,<%=encode%>"></td>
										<%
											} else {
										%><td></td>
										<%
											}
										%>
										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/Back_end/newsinfo/newsinfo.do"
												style="margin-bottom: 0px;">
												<button type="submit" class="btn btn-primary">修改</button>
												<input type="hidden" name="news_no" value="${newsinfoVO.news_no}">
												<input type="hidden" name="action" value="getOne_For_Update">
											</FORM>
										</td>
										
										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/Back_end/newsinfo/newsinfo.do"
												style="margin-bottom: 0px;">
												<button type="submit" class="btn btn-primary">刪除</button>
												<input type="hidden" name="news_no" value="${newsinfoVO.news_no}">
												<input type="hidden" name="action" value="delete">
											</FORM>
										</td>
									</tr>
								</c:forEach>
							</table>
							<%@ include file="page2.file"%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 工作區結束 -->

	<jsp:include page="/BackHeaderFooter/Footer.jsp" />
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS start-->
	<script
		src="<%=request.getContextPath()%>/bootstrap/jquery-3.3.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/popper.min.js"></script>
	<script	src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
	<!-- jQuery first, then Popper.js, then Bootstrap JS end-->

</body>
</html>