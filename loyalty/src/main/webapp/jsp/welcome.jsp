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
      String prod;

      try {
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("jdbc/loyaltyDS");
            conn = ds.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM PRODUCT");
 
            while(rs.next())
            {       
              prod = rs.getString("PRODUCTNAME");
//              out.println(prod);
   
            }
                  
            st.close();

            } catch (Exception e)
            {
              out.println("Exception : " + e.getMessage() + "");
            }
          
%>
    
    
    
    
        <div class="container">
            <form action="custsearch.jsp" method="post">
                <h2>Test Welcome to the Loyalty Manager !!<font color="red">MODIFIED IN OEPE.</font></h2>

                <br></br>

                <div class="form-group col-xs-8">
                    <label for="offer" class="control-label col-xs-4">Input Offer Criteria:</label>
                    <input type="text" name="offer"/>
                    <button type="submit" class="btn btn-primary  btn-md">Search</button>                                   
                   
                    <br></br>
                  
                    <label for="target" class="control-label col-xs-4"># of Target Customers:</label>  
                    <input type="text" name="target" disabled="disabled" value="${result}"/>
                </div>
            </form>

            <form action="createoffer.jsp" method="post">        
                <div class="form-group col-xs-8">
                    <br></br>

                    <label for="target" class="control-label col-xs-4">Target Product:</label>

                    <select name="item">
                      <option value="1">Red</option>
                      <option value="2">Blue</option>
                      <option value="3">Green</option>
                    </select>
                    
                    <br></br>
                    <br></br>
                    
                  <button type="submit" class="btn btn-primary  btn-md">Next</button>              
                </div>
            </form>

            <form action="welcome.jsp" method="post">        
                <div class="form-group col-xs-8">
                  <button type="submit" class="btn btn-primary  btn-md">Clear</button>
                </div>
            </form>
        </div>
    </body>
</html>