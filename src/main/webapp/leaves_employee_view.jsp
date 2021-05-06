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
        <a class="navbar-brand" href="EmployeeViewServlet">BiteOfRest</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor02">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="leave_form.jsp">Zaplanuj urlop</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="EmployeeViewServlet">Przeglądaj urlopy</a>
                </li>
            </ul>
            <form action="EmployeeViewServlet" method="get">
                <input type="hidden" name="method" value="LOG OUT">
                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Wyloguj</button>
            </form>
        </div>
    </nav>
</header>

<main>

    <table class="table table-striped" style="font-size:14px; text-align:center;">

        <thead>
        <tr class="table-secondary">
            <th scope="col" >#</th>
            <th scope="col" >Data rozpoczecia</th>
            <th scope="col" >Data zakończenia</th>
            <th scope="col" >Zmiana statusu</th>
            <th scope="col" >Status</th>
            <th scope="col" >Zmień datę</th>
            <th scope="col" >Zrezygnuj</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="tmpLeave" items="${LEAVES_LIST}">

            <c:url var="updateLink" value="EmployeeViewServlet">
                <c:param name="command" value="EDIT"></c:param>
                <c:param name="leaveID" value="${tmpLeave.leaveId}"></c:param>
            </c:url>

            <c:url var="deleteLink" value="EmployeeViewServlet" >
                <c:param name="command" value="CANCEL"></c:param>
                <c:param name="leaveID" value="${tmpLeave.leaveId}"></c:param>
            </c:url>

            <tr>
                <th scope="row">${tmpLeave.leaveId}</th>
                <td>${tmpLeave.startDate}</td>
                <td>${tmpLeave.endDate}</td>
                <td>${tmpLeave.statusDate}</td>
                <td>${tmpLeave.status}</td>


                <td><a href="${tmpLeave.isEditable() ? updateLink :""}">

                    <button type="button" ${tmpLeave.isEditable()?"":"disabled"} class="btn btn-warning ${tmpLeave.isEditable()?"":"disabled"}">Modyfikuj</button>

                </a></td>
                <td><a href="${tmpLeave.isEmployeeDeletable() ? deleteLink :""}"
                    onclick="if(!(confirm('Czy na pewno chcesz anulować urlop?'))) return false">
                     <button type="button" ${tmpLeave.isEmployeeDeletable()?"":"disabled"} class="btn btn-danger ${tmpLeave.isEmployeeDeletable()?"":"disabled"}">Anuluj</button>

             </a></td>

<%--                <td><a--%>
<%--                    <button type="button" class="btn btn-warning disabled">Modyfikuj</button>--%>
<%--                </a></td>--%>
<%--                <td><a--%>
<%--                    <button type="button" class="btn btn-danger disabled">Anuluj</button>--%>
<%--                </a></td>--%>
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
