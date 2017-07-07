<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page import="oracle.sql.*" %>
<%@ page import="oracle.jdbc.driver.OracleDriver"%>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.naming.*" %>

<%@ page import="java.net.URL" %>
<%@ page import="javax.net.ssl.HostnameVerifier" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="javax.net.ssl.SSLSession" %>


<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="../js/jquery-2.2.4.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <script src="../js/bootstrap.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Offer Created!!</title>
    </head>
    <body>

<%

      InitialContext ctx;
      DataSource ds;
      Connection conn;
      Statement st;
      ResultSet rs;
      int i = 0;
      int points = 0;
      int offer = 0;
      int nextid = 0;
      int prodid = 0;
      String prodname = "";
      String offername = request.getParameter("offername");
      String offmsg = request.getParameter("offmsg");
      int reqpoint = Integer.parseInt(request.getParameter("offer"));
      String mysql = "";

      try {
            ctx = new InitialContext();
            ds = (DataSource) ctx.lookup("jdbc/loyaltyDS");
            conn = ds.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT MAX(ID) AS THELAST FROM OFFERS");
            while (rs.next()) {
              nextid = rs.getInt("THELAST") + 1;
            }
            prodname = request.getParameter("product");
            rs = st.executeQuery("SELECT ID AS PRODID FROM PRODUCT WHERE PRODUCTNAME='" + prodname + "'");
            while (rs.next())
            {
              prodid = rs.getInt("PRODID");
            }


            offer = Integer.parseInt(request.getParameter("offer"));

//            out.println("offer = " + request.getParameter("offer") +'\n');
//            out.println("points = " + offer +'\n');

            mysql = "insert into offers (ID,OFFERNAME,POINTS,MESSAGE,PRODUCTID) values (" + nextid + ", '" + offername + "', ";
            mysql = mysql + reqpoint + ", '" + offmsg + "', " + prodid + ")";

            st.executeUpdate(mysql);

            out.println(mysql);
            out.println("<br><br> Offer #" + nextid + " created!!");


            st.close();

            //
            HostnameVerifier hostnameVerifier = new HostnameVerifier() {
                @Override
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            };

            String mcs = "https://mcs-gse00011678.mobileenv.us2.oraclecloud.com:443/mobile/custom/LoyaltyManagementAPI/offer/notify";
            URL obj = new URL(null, mcs, new sun.net.www.protocol.https.Handler());
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
            con.setHostnameVerifier(hostnameVerifier);
            con.setRequestMethod("POST");
            con.setRequestProperty("Oracle-Mobile-Backend-ID","4a9d0d32-8aad-48fb-b803-5315459dce9f");
            con.setRequestProperty("Authorization","Basic R1NFMDAwMTE2NzhfTUNTX01PQklMRV9BTk9OWU1PVVNfQVBQSUQ6Smk3cXBld3lrczlfbmI=");
            con.setRequestProperty("Content-Type","application/json");

            con.setDoOutput(true);

            String POST_PARAMS =  " { \"template\": { \"name\": \"#default\", \"parameters\": { \"title\": \"Reminder\", ";
            POST_PARAMS = POST_PARAMS + " \"body\": \"Status on incident 1548 is due.\", \"custom\": { \"offerId\": 10001 ";
            POST_PARAMS = POST_PARAMS + "  } } }, \"tag\":\"Offers\", \"users\":[ \"mcs-demo_user07@oracleads.com\" ] } ";

            OutputStream os = con.getOutputStream();
		os.write(POST_PARAMS.getBytes());
		os.flush();
		os.close();
		// For POST only - END

		int responseCode = con.getResponseCode();
		System.out.println("POST Response Code :: " + responseCode);

		if (responseCode == HttpsURLConnection.HTTP_OK) { //success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer responsemcs = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				responsemcs.append(inputLine);
			}
			in.close();

			// print result
			System.out.println(responsemcs.toString());
		} else {
			System.out.println("POST request not worked" + responseCode);
		}

//             HttpClient httpclient = new HttpClient();
//             String mcsrespojnse ="";
//
//             PostMethod post = new PostMethod(mcs);
//             post.addRequestHeader("Oracle-Mobile-Backend-ID","4a9d0d32-8aad-48fb-b803-5315459dce9f");
//             post.addRequestHeader("Authorization","Basic R1NFMDAwMTE2NzhfTUNTX01PQklMRV9BTk9OWU1PVVNfQVBQSUQ6Smk3cXBld3lrczlfbmI=");
//             post.addRequestHeader("Content-Type","application/json");
//
//             httpclient.executeMethod(post);
//
//             post.setParameter("message","you have a new offer");
// post.setParameter("offerid", nextid);
// post.setParameter("mcsuser", "mcs_00001");



//             System.out.println("<br/><br/>");
// //responseText=getResponseText(post);
// InputStream is = post.getResponseBodyAsStream();
// Scanner scanner = new Scanner(is).useDelimiter("\\A");
// responseText=scanner.hasNext() ? scanner.next() : "";
//
// System.out.println(responseText);

             } catch (Exception e)
             {
               out.println("Exception : " + e.getMessage() + "");
             }

// offers - ID OFFERNAME POINTS MESSAGE PRODUCTID
// SQL insert into offers value (nextid, ' offername ', reqpoint, ' offmsg ', prodid)




// send push notification here!!!!


%>

      <div class="container">
              <form action="createoffer.jsp" method="post">
           <!-- form action="custsearch.jsp" method="post" -->
               <h2>Welcome to the Loyalty Manager !!</h2>

               <br></br>

               <div class="form-group col-xs-8">
                    <label for="offer" class="control-label col-xs-4">Input Offer Criteria:</label>
                    <input type="text" name="offer" value='<%=request.getParameter("offer")%>' readonly/>
                    <button type="button" class="btn btn-primary  btn-md" disabled="disabled">Search</button>


                    <br></br>

                    <label for="target" class="control-label col-xs-4"># of Target Customers:</label>
                    <input type="text" name="target" value="<%=i%>" readonly/>
                <!-- /div -->
           <!-- /form -->



           <!-- div class="form-group col-xs-8" -->
               <br></br>
               <label for="prevtarget" class="control-lable col-xs-4">Target Product:</label>
               <input type="text" name="targetx" disabled="disabled" value='<%=request.getParameter("product")%>'  /><br/>
               <label for="target" class="control-label col-xs-4">Confirm Target Product:</label>


               <select name="item">
                 <%
//                       InitialContext ctx;
//                       DataSource ds;
//                       Connection conn;
//                       Statement st;
//                       ResultSet rs;
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
               <button type="button" class="btn btn-primary  btn-md" onclick="location.href = 'welcome.jsp';">Go Back</button>

             <button type="submit" class="btn btn-primary  btn-md" >Next</button>

           </div>
       </form>
<!--
       <form action="welcome.jsp" method="post">
-->
           <div class="form-group col-xs-8">
           </div>
       </form>
    </body>
</html>
