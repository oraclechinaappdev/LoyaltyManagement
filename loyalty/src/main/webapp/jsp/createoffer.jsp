<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%--
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
--%>

<!DOCTYPE html>

<html>
    <head>
        <script type="text/javascript" src="../js/jquery-2.2.4.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <script src="../js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Offer</title>
        <script>
        $( function() {
          var dateFormat = "dd-mm-yyyy",
            from = $( "#from" )
              .datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                dateFormat: 'dd-mm-yy'
              })
              .on( "change", function() {
                to.datepicker( "option", "minDate", getDate( this ) );
              }),
            to = $( "#to" ).datepicker({
              defaultDate: "+1w",
              changeMonth: true,
              numberOfMonths: 1,
              dateFormat: 'dd-mm-yy'
            })
            .on( "change", function() {
              from.datepicker( "option", "maxDate", getDate( this ) );
            });

          function getDate( element ) {
            var date;
            try {
              date = $.datepicker.parseDate( dateFormat, element.value );
            } catch( error ) {
              date = null;
            }

            return date;
          }
        } );
        </script>

    </head>
    <body>
        <div class="container">
        <%--
            <form action="${pageContext.request.contextPath}/Welcome" method="post">
        --%>
            <form action="confirm.jsp" method="post">
                <h2>Create Offer</h2>

                <br />

                <div class="form-group col-xs-8">
                    <label for="offer" class="control-label col-xs-4">Input Offer Criteria:</label>
                    <input type="text" name="offer" value='<%=request.getParameter("offer")%>' readonly />

                    <br></br>

                    <label for="target" class="control-label col-xs-4"># of Target Customers:</label>
                    <input type="text" name="customercount" value='<%=request.getParameter("target")%>' readonly />

                    <br></br>

                    <label for="target" class="control-label col-xs-4">Target Product:</label>
                    <input type="text" name="product" value='<%=request.getParameter("item")%>' readonly />

<!--
                    <select name="item">
                      <option value="1">Red</option>
                      <option value="2">Blue</option>
                      <option value="3">Green</option>
                    </select>
-->
                    <br></br>

                    <label for="offername" class="control-label col-xs-4">Offer Name:</label>
                    <input type="text" name="offername"/>

                    <br></br>

                    <label for="offerperiod" class="control-label col-xs-4">Offer Period:</label>
                    <input type="text"  pattern="^\d{2}-\d{2}-\d{4}$" name="from" id="from" maxlength="10" placeholder="dd-MM-yyyy" required="true"/>
                    To
                    <input type="text"  pattern="^\d{2}-\d{2}-\d{4}$" name="to" id="to" maxlength="10" placeholder="dd-MM-yyyy" required="true"/><br />

                    <br></br>


<%--                <input type="text"  pattern="^\d{2}-\d{2}-\d{4}$" name="offerperiod" id="offerperiod" class="form-control" value="${loyalty.peridoffer}" maxlength="10" placeholder="dd-MM-yyyy" required="true"/>
--%>

                    <label for="target" class="control-label col-xs-4">Offer Message:</label>
                    <textarea rows="5" cols="30" placeholder="enter offer message"></textarea><br />

                    <br></br>
                    <button type="button" class="btn btn-primary  btn-md" onclick="location.href = 'welcome.jsp';">Cancel</button>
                    <button type="submit" class="btn btn-primary  btn-md">Create Offer</button>


               </div>
            </form>
        </div>
    </body>
</html>
