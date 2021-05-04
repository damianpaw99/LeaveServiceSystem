<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="java.util.*" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Urlopy</title>
    <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">AnDamPol</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Strona główna
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Logowanie
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registration.jsp">Rejestracja
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="leave_form.jsp">Zaplanuj urlop</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">Przeglądaj urlopy</a>
                </li>
            </ul>

        </div>
    </nav>
</header>

<main>
    <div class="row form-group"></div>
    <div class="row form-group"></div>
    <div class="row form-group"></div>
    <div class="row form-group"></div>


    <table class="table table-striped" style="font-size:11px; text-align:center;">

        <thead>
        <tr>
            <th scope="col" style="font-size:11px;" >#</th>
            <th scope="col" style="font-size:11px;">Data rozpoczecia</th>
            <th scope="col" style="font-size:11px;">Data zakończenia</th>
            <th scope="col" style="font-size:11px;">Zmień datę</th>
            <th scope="col" style="font-size:11px;">Zrezygnuj</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="tmpLeave" items="${LEAVES_LIST}">

            <c:url var="updateLink" value="LeavesServlet">
                <c:param name="command" value="LOAD"></c:param>
                <c:param name="leaveID" value="${tmpLeave.id}"></c:param>
            </c:url>

            <c:url var="deleteLink" value="LeavesServlet">
                <c:param name="command" value="DELETE"></c:param>
                <c:param name="leaveID" value="${tmpLeave.id}"></c:param>
            </c:url>

            <tr>
                <th scope="row">${tmpLeave.id}</th>
                <td>${tmpLeave.startDate}</td>
                <td>${tmpLeave.endDate}</td>
                <td><a href="${updateLink}">
                    <button type="button" class="btn btn-info">Modyfikuj</button>
                </a></td>
                <td><a href="${deleteLink}"
                       onclick="if(!(confirm('Czy na pewno chcesz usunąć ten ośrodek?'))) return false">
                    <button type="button" class="btn btn-warning">Usuń</button>
                </a></td>
            </tr>

        </c:forEach>
        </tbody>
    </table>

    <div class="row form-group"></div>
    <div class="row form-group"></div>
    <div class="row form-group"></div>

    <div class="col-sm-9">
        <p><a class="btn btn-primary" href="leave_form.jsp" role="button">Zaplanuj urlop</a>
        </p>
    </div>


</main>
</body>
</html>
