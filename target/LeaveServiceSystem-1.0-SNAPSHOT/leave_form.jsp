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
        <a class="navbar-brand" href="leaves_employee_view.jsp">BiteOfRest</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
                aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="leave_form.jsp">Zaplanuj urlop</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="leaves_employee_view.jsp">Przeglądaj urlopy</a>
                </li>
            </ul>
            <form action="LeaveServlet" method="get">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit" >Wyloguj</button>
            </form>
        </div>
    </nav>
</header>

<main>

    <div class="container">

        <div class="row form-group"></div>
        <div class="row form-group"></div>
        <div class="row form-group"></div>
        <div class="row form-group"></div>
        <div class="row form-group"></div>

        <div class="jumbotron">

            <div class="row form-group"></div>

            <h3>Wniosek o urlop</h3>

            <div class="row form-group"></div>

            <%--            <p class="text-info">Pozostało ci ${tutaj.liczba.dni} dni urlopu do wykorzystania.</p>--%>

            <form action="LeaveServlet" method="post">


                <%
                    String sStart = (String) request.getAttribute("startError");
                    if (sStart != null) {
                        out.println("                <div class=\"form-group has-danger\">\n" +
                                "                    <label class=\"form-control-label\" for=\"wrongStartDate\">Dzień rozpoczęcia</label>\n" +
                                "                    <input type=\"date\" value=\"${param.startDateInput!=null ? param.startDateInput:\"\"}\" class=\"form-control is-invalid\" id=\"wrongStartDate\" name=\"startDateInput\">\n" +
                                "                    <div class=\"invalid-feedback\">" + sStart + "</div>\n" +
                                "                </div>");
                    } else {
                        out.println("                <div class=\"form-group\">\n" +
                                "                    <label for=\"startDate\">Dzień rozpoczęcia</label>\n" +
                                "                    <input type=\"date\" class=\"form-control\" value=\"${param.startDateInput!=null ? param.startDateInput:\"\"}\" name=\"startDateInput\" id=\"startDate\">\n" +
                                "                </div>");
                    }
                %>

                <%
                    String sEnd = (String) request.getAttribute("endError");
                    if (sEnd != null) {
                        out.println("                <div class=\"form-group has-danger\">\n" +
                                "                    <label class=\"form-control-label\" for=\"wrongEndDate\">Dzień rozpoczęcia</label>\n" +
                                "                    <input type=\"text\" value=\"${param.endDateInput!=null ? param.endDateInput:\"\"}\" class=\"form-control is-invalid\" name=\"endDateInput\" id=\"wrongEndDate\">\n" +
                                "                    <div class=\"invalid-feedback\">" + sEnd + "</div>\n" +
                                "                </div>");
                    } else {
                        out.println("                <div class=\"form-group\">\n" +
                                "                    <label for=\"endDate\">Dzień zakończenia</label>\n" +
                                "                    <input type=\"date\" class=\"form-control\" value=\"${param.endDateInput!=null ? param.endDateInput:\"\"}\" name=\"endDateInput\" id=\"endDate\">\n" +
                                "                </div>");
                    }
                %>


                <p class="text-danger">
                    <%
                    String sOther=(String) request.getAttribute("otherError");
                    if(sOther!=null){
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
