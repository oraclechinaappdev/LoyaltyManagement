<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="oracle.jdbc.driver.OracleDriver"%>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.naming.*" %>

<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="../js/jquery-2.2.4.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <script src="../js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Offer</title>     
    </head>
    <body>

<%
            InitialContext ctx;
            DataSource ds;
            Connection conn;
            Statement st;
            ResultSet rs;

            try {
                  ctx = new InitialContext();
                  ds = (DataSource) ctx.lookup("jdbc/loyaltyDS");
                  conn = ds.getConnection();

                  st = conn.createStatement();
                  rs = st.executeQuery("SELECT * FROM CUSTOMER");
                    
                  int i = 0;
                  int points = 0;
                  int offer = Integer.parseInt(request.getParameter("offer"));
                  
                  out.println("offer = " + request.getParameter("offer") +'\n');
                  out.println("points = " + points +'\n');
                    
                  while(rs.next())
                  {       
                    points = rs.getInt("POINTS");

                    if(points < offer)
                    {
                      i++;
                      out.println(points);
                    }
//                    out.print("Customer Name: "+ rs.getString("CUSTOMERNAME") + '\n');           
                  }
                  out.println("i = " + i + '\n');
                  
                  st.close();

                } catch (Exception e)
                {
                  out.println("Exception : " + e.getMessage() + "");
                  
                }
%>
            
            
        </div>
    </body>
</html>