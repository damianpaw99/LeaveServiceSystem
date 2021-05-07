<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Planowanie urlopu</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="EmployeeViewServlet">BiteOfRest</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
                aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="LeaveServlet">Zaplanuj urlop</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="EmployeeViewServlet">Przeglądaj urlopy</a>
                </li>
            </ul>
            <form action="LeaveServlet" method="get" class="d-flex">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link">Zalogowano jako ${sessionScope.employeeLogin}</a>
                    </li>
                </ul>
                <button class="btn btn-secondary my-2 my-sm-0" type="submit" name="commend" value="LOG OUT"  onclick="if(!(confirm('Czy na pewno chcesz się wylogować?'))) return false">Wyloguj</button>
            </form>
        </div>
    </nav>
</header>

<main>


    <div class="jumbotron" style="margin:30px;">

        <div class="container">

            <div class="row form-group"></div>

            <h3>Wniosek o urlop</h3>

            <div class="row form-group"></div>

            <p class="text-info">Pozostało ci <%
                out.println(request.getAttribute("daysLeft"));
            %> dni urlopu do wykorzystania.</p>

            <form action="LeaveServlet" method="post">
                <input type="hidden" name="leaveId" value="<%
            if(request.getAttribute("leaveId")!=null) {out.println(request.getAttribute("leaveId"));}
            %>">

                <%
                    String sStart = (String) request.getAttribute("startError");
                    String startValue = (String) request.getAttribute("startValue");
                    if (startValue == null)
                        startValue = request.getParameter("startDateInput") != null ? request.getParameter("startDateInput") : "";
                    if (sStart != null) {
                        out.println("                <div class=\"form-group has-danger\">\n" +
                                "                    <label class=\"form-control-label\" for=\"wrongStartDate\">Dzień rozpoczęcia</label>\n" +
                                "                    <input type=\"date\" value=\"" + startValue + "\" class=\"form-control is-invalid\" id=\"wrongStartDate\" name=\"startDateInput\">\n" +
                                "                    <div class=\"invalid-feedback\">" + sStart + "</div>\n" +
                                "                </div>");
                    } else {
                        out.println("                <div class=\"form-group\">\n" +
                                "                    <label for=\"startDate\">Dzień rozpoczęcia</label>\n" +
                                "                    <input type=\"date\" class=\"form-control\" value=\"" + startValue + "\" name=\"startDateInput\" id=\"startDate\">\n" +
                                "                </div>");
                    }
                %>

                <%
                    String sEnd = (String) request.getAttribute("endError");
                    String endValue = (String) request.getAttribute("endValue");
                    if (endValue == null)
                        endValue = request.getParameter("endDateInput") != null ? request.getParameter("endDateInput") : "";
                    if (sEnd != null) {
                        out.println("                <div class=\"form-group has-danger\">\n" +
                                "                    <label class=\"form-control-label\" for=\"wrongEndDate\">Dzień zakończenia</label>\n" +
                                "                    <input type=\"text\" value=\"" + endValue + "\" class=\"form-control is-invalid\" name=\"endDateInput\" id=\"wrongEndDate\">\n" +
                                "                    <div class=\"invalid-feedback\">" + sEnd + "</div>\n" +
                                "                </div>");
                    } else {
                        out.println("                <div class=\"form-group\">\n" +
                                "                    <label for=\"endDate\">Dzień zakończenia</label>\n" +
                                "                    <input type=\"date\" class=\"form-control\" value=\"" + endValue + "\" name=\"endDateInput\" id=\"endDate\">\n" +
                                "                </div>");
                    }
                %>


                <p class="text-danger">
                    <%
                        String sOther = (String) request.getAttribute("otherError");
                        if (sOther != null) {
                            out.println(sOther);
                        }
                    %>
                </p>

                <button type="submit" class="btn btn-primary btn-lg btn-block">Wyślij</button>

                <div class="row form-group"></div>
                <div class="row form-group"></div>
                <div class="row form-group"></div>


            </form>

        </div>
    </div>
</main>

</body>
</html>
