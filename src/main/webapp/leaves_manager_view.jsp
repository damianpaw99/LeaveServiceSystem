<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Wszystkie urlopy pracowników</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="active_leaves_view.jsp">BiteOfRest</a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
                    aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="AllEmployeesServlet">Pracownicy</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="ManagerAllServlet">Wszystkie urlopy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ManagerActiveServlet">Wnioski do rozpatrzenia</a>
                </li>
            </ul>
            <form action="ManagerAllServlet" method="get" class="d-flex">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link">Zalogowano jako kierownik </a>
                    </li>
                </ul>
            <button class="btn btn-secondary my-2 my-sm-0" type="submit" name="command" value="LOG OUT">Wyloguj</button>
            </form>
        </div>
    </nav>
</header>

<main>

    <table class="table table-hover" style="font-size:14px; text-align:center; vertical-align: center">

        <thead>
        <tr class="table-active">
            <th scope="col">#</th>
            <th scope="col">Imię pracownika</th>
            <th scope="col">Nazwisko pracownika</th>
            <th scope="col">Data rozpoczecia</th>
            <th scope="col">Data zakończenia</th>
            <th scope="col">Zmiana statusu</th>
            <th scope="col">Status</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="tmpLeave" items="${LEAVES_LIST}">


            <tr>
                <th scope="row" style="vertical-align: middle">${tmpLeave.id}</th>
                <td style="vertical-align: middle">${tmpLeave.employeeName}</td>
                <td style="vertical-align: middle">${tmpLeave.employeeSurname}</td>
                <td style="vertical-align: middle">${tmpLeave.startDate}</td>
                <td style="vertical-align: middle">${tmpLeave.endDate}</td>
                <td style="vertical-align: middle">${tmpLeave.statusDate}</td>
                <td style="vertical-align: middle">${tmpLeave.status}</td>
            </tr>

        </c:forEach>
        </tbody>
    </table>

    <div class="row form-group"></div>
    <div class="row form-group"></div>
    <div class="row form-group"></div>

</main>
</body>
</html>
