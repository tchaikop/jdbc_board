<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 저장</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String btitle = request.getParameter("btitle");
	String bcontent = request.getParameter("bcontent");
	String bwriter = request.getParameter("bwriter");

	String sql = "insert into board(btitle,bcontent,bwriter,bhit) values(?,?,?,0)";

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
		
		pstmt.setString(1,btitle);
		pstmt.setString(2,bcontent);
		pstmt.setString(3,bwriter);
		
		int result = pstmt.executeUpdate();
		
		if(result == 1 ) {
			System.out.println("글 작성 성공");
			response.sendRedirect("boardlist.jsp");
		}else {
			System.out.println("글 작성 실패");
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