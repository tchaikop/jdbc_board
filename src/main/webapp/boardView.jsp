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
<title>게시판 글 내용보기</title>
</head>
<body>
<%
	String viewnum = request.getParameter("bnum");

	String sql1 = "update board set bhit = bhit +1 where bnum=?";
	String sql2 = "select * from board where bnum = ?";
	
	
	String driverName = "com.mysql.jdbc.Driver";
	String url ="jdbc:mysql://localhost:3306/boardtest";
	String username ="root";
	String password ="12345";
	
	Connection conn = null;
	PreparedStatement pstmt1 = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	BoardDto bDto = null;
	
	
	
	try{
		Class.forName(driverName);
		conn = DriverManager.getConnection(url,username,password);
		pstmt1 = conn.prepareStatement(sql1);
		
		
		pstmt1.setString(1,viewnum);
		pstmt1.executeUpdate();
		
		
		//-> ====sql2 실행============
		
		pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1,viewnum);
		rs = pstmt2.executeQuery();
		
		
		
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
		if(pstmt1 != null) pstmt1.close();
		if(pstmt2 != null) pstmt2.close();
		if(conn != null) conn.close();
	}


%>



<h2>글 게시판 내용 보기</h2>
<hr>
<p>글 번호: ${boardDto.bnum }</p>
<p>조회수 :${boardDto.bhit }<p>
<p>제목: ${boardDto.btitle }</p>
<p>내용: ${boardDto.bcontent }</p>
<p>작성자: ${boardDto.bwriter }</p>
<hr>
<a href="boardlist.jsp">글목록</a>
<a href="#">글수정</a>
<a href="#">글삭제</a>

</body>
</html>