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

        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="../js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Loyalty Manager</title>
        <style>
          #errmsg {
            color: red
          }
        </style>
        <script>
          function checkform(itemx) {
            if (document.search.target.value == "${result}" ) {
               $( "#dialog" ).dialog( "open" );
               return false;
            } else {
               alert(itemx);
               document.search.product.value=itemx;
               document.search.submit();
            }
          }


        </script>
        <script>
  $( function() {
    $( "#dialog" ).dialog({
      autoOpen: false,
      show: {
        effect: "blind",
        duration: 500
      },
      hide: {
        effect: "blind",
        duration: 500
      }
    });


  } );
  </script>
<script>
  $(document).ready(function () {
  //called when key is pressed in textbox
  $("#offer").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
        $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });
});
  </script>

    </head>
    <body>


      <div id="dialog" title="Warning">
        <p>Please enter the offer criteria and click search befor proceed. Criteria must be a positive integer</p>
      </div>



        <div class="container">
            <form name="search" action="custsearch.jsp" method="post">
                <h2>Welcome to the Loyalty Manager !!</h2>

                <br></br>

                <div class="form-group col-xs-8">
                    <label for="offer" class="control-label col-xs-4">Input Offer Criteria:</label>
                    <input type="text" name="offer" id="offer" required="true"/>
                    <button type="submit" class="btn btn-primary  btn-md">Search</button>&nbsp;&nbsp; <span id="errmsg"></span>

                    <br></br>


                    <label for="target" class="control-label col-xs-4"># of Target Customers:</label>
                    <input type="text" name="target" disabled="disabled" value="${result}"/>
                    <input type="hidden" name="product" value="Samsam Galaxy 7"/>

                </div>
            </form>

            <form name="coffer" action="createoffer.jsp" method="post">
                <div class="form-group col-xs-8">
                    <br></br>

                    <label for="target" class="control-label col-xs-4">Target Product:</label>
                    <select name="item" onchange="javascript:document.search.product.value=document.coffer.item.value;return true;">
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
                                  out.println("<option value=\"" + prod + "\">" + prod + "</option>");
                                }

                                st.close();

                                } catch (Exception e)
                                {
                                  out.println("Exception : " + e.getMessage() + "");
                                }

                    %>
<!--
                      <option value="1">Red</option>
                      <option value="2">Blue</option>
                      <option value="3">Green</option>
-->
                    </select>

                    <br></br>
                    <br></br>
                    <button type="reset" class="btn btn-primary  btn-md" onclick="document.search.offer.value='';return true;">Clear</button>

                  <button type="button" class="btn btn-primary  btn-md" onclick="return checkform(document.coffer.item.value)">Next</button>
                </div>
            </form>
<!--
            <form action="welcome.jsp" method="post">
                <div class="form-group col-xs-8">

                </div>
            </form>
-->
        </div>
    </body>
</html>
