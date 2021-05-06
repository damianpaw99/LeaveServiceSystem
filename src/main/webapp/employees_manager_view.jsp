<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         import="java.util.*" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Wnioski</title>
    <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
    <link rel="stylesheet" href="css/bootstrap.css">
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="active_leaves_view.jsp">BiteOfRest</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="AllEmployeesServlet">Pracownicy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ManagerAllServlet">Wszystkie urlopy</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ManagerActiveServlet">Wnioski do rozpatrzenia</a>
                </li>
            </ul>
            <form action="ManagerAllServlet" method="get">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit" name="command" value="LOG OUT">Wyloguj</button>
            </form>
        </div>
    </nav>
</header>

<main>
    <table class="table table-striped" style="font-size:14px; text-align:center;">

        <thead>
        <tr class="table-light">
            <th scope="col" >#</th>
            <th scope="col" >Imię pracownika</th>
            <th scope="col" >Nazwisko pracownika</th>
            <th scope="col" >Data urodzenia</th>
            <th scope="col" >Adres e-mail</th>
            <th scope="col" >Staż pracy</th>

        </tr>
        </thead>

        <tbody>

        <c:forEach var="tmpEmployee" items="${EMPLOYEE_LIST}">


            <tr>
                <th scope="row">${tmpEmployee.id}</th>
                <td>${tmpEmployee.name}</td>
                <td>${tmpEmployee.surname}</td>
                <td>${tmpEmployee.birthDate}</td>
                <td>${tmpEmployee.email}</td>
                <td>${tmpEmployee.employmentYears}</td>
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
