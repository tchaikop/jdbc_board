<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글목록</title>
</head>
<body>
	<%
	
	String sql= "select * from board order by bnum desc";
	
	
	String driverName = "com.mysql.jdbc.Driver";
	String url ="jdbc:mysql://localhost:3306/boardtest";
	String username ="root";
	String password ="12345";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	ArrayList<BoardDto> boardlist = new ArrayList<BoardDto>();
	
	try{
		Class.forName(driverName);
		conn = DriverManager.getConnection(url,username,password);
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		
		
		while( rs.next()) {
			int bnum = rs.getInt("bnum");
			String btitle = rs.getString("btitle");
			String bcontent = rs.getString("bcontent");
			String bwriter = rs.getString("bwriter");
			int bhit = rs.getInt("bhit");
			String bdate = rs.getString("bdate");
			
			BoardDto bDto = new BoardDto(bnum,btitle,bcontent,bwriter,bhit,bdate);
			
			boardlist.add(bDto);
									
		}	
		
		request.setAttribute("boardlist",boardlist);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	%>

		<table border="1px solid black">
		
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
			
			</tr>
		
				
		</thead>
		
		<tbody>
		<c:forEach var="bDto" items="${boardlist}">
			<tr>
			
				<td>${bDto.bnum }</td>
				<td>${bDto.btitle }</td>
				<td>${bDto.bwriter }</td>
				<td>${bDto.bhit }</td>
				<td>${bDto.bdate }</td>
			</tr>
		
		</c:forEach>
		
		
		
		
		
		</tbody>
		
		
		
		
		</table>


</body>
</html>