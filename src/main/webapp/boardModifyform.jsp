<%@page import="java.sql.DriverManager"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="jakarta.tags.functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 수정</title>
</head>
<body>
<%
String viewnum = request.getParameter("bnum");


String sql = "select * from board where bnum = ?";


String driverName = "com.mysql.jdbc.Driver";
String url ="jdbc:mysql://localhost:3306/boardtest";
String username ="root";
String password ="12345";

Connection conn = null;
PreparedStatement pstmt = null;

ResultSet rs = null;
BoardDto bDto = null;



try{
	Class.forName(driverName);
	conn = DriverManager.getConnection(url,username,password);
	pstmt = conn.prepareStatement(sql);
	
	
	pstmt.setString(1,viewnum);
	
	
	
	
	rs = pstmt.executeQuery();
	
	
	
	if( rs.next()) {
		int bnum = rs.getInt("bnum");
		String btitle = rs.getString("btitle");
		String bcontent = rs.getString("bcontent");
		String bwriter = rs.getString("bwriter");
		int bhit = rs.getInt("bhit");
		String bdate = rs.getString("bdate");
		
		bDto = new BoardDto(bnum,btitle,bcontent,bwriter,bhit,bdate);
		
		
								
	}	else {
		System.out.println("존재하지 않는 글");
	}
	
	request.setAttribute("boardDto", bDto);
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(pstmt != null) pstmt.close();
	
	if(conn != null) conn.close();
}


%>

<h2>글 내용 수정하기</h2>
<hr>

<form action="boardModifyOk.jsp">
	<input type="hidden" name="bnum" value="${boardDto.bnum }">
	번호:${boardDto.bnum }<br><br>
	작성자:${boardDto.bwriter }<br><br>
	제목:<input type="text" name="btitle" value="${boardDto.btitle }" size="50"><br><br>
	내용:<textarea rows="10" cols="50" name="bcontent">${boardDto.bcontent }</textarea><br><br>
	<input type="submit" value="수정완료">
	<!-- <input type="button" value="취소" onclick="location.href='boardlist.jsp'"> -->
	<input type="button" value="취소" onclick="history.go(-1)">

</form>

</body>
</html>