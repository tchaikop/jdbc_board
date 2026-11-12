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
<title>Insert title here</title>
</head>
<body>
<%
	String dbnum = request.getParameter("bnum");


	String sql = "delete from board where bnum = ?";


	String driverName = "com.mysql.jdbc.Driver";
	String url ="jdbc:mysql://localhost:3306/boardtest";
	String username ="root";
	String password ="12345";

	Connection conn = null;
	PreparedStatement pstmt = null;


try{
	Class.forName(driverName);
	conn = DriverManager.getConnection(url,username,password);
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1,dbnum);
	
	
	int result = pstmt.executeUpdate();
	
	if(result == 1 ) {
		out.println("글 삭제 성공");
		response.sendRedirect("boardlist.jsp");
	}else {
		out.println("글 삭제 실패");
	}
	
	
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
}

 

%>
</body>
</html>