<%--
  Created by IntelliJ IDEA.
  User: anias
  Date: 04.05.2021
  Time: 17:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title>Rejestracja</title>

  <!--    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->
  <!--    <meta name="description" content="">-->
  <!--    <meta name="viewport" content="width=device-width, initial-scale=1">-->

  <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
  <link rel="stylesheet" href="css/bootstrap.css">

</head>
<body>
<header>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">AnDamPol</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
            aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
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
        <li class="nav-item active">
          <a class="nav-link" href="registration.jsp">Rejestracja
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="leave_form.jsp">Zaplanuj urlop</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Przeglądaj urlopy</a>
        </li>
      </ul>
    </div>
  </nav>
</header>
<main>
  <form action="ControllerServlet">

    <fieldset>
      <legend>Rejestracja pracownika</legend>

      <div class="form-group">
        <label class="col-form-label" for="inputFirstName">Imię</label>
        <input type="text" class="form-control" placeholder="Wprowadź imię" name="inputFirstName"
               id="inputFirstName">
      </div>

      <div class="form-group">
        <label class="col-form-label" for="inputSurname">Nazwisko</label>
        <input type="text" class="form-control" placeholder="Wprowadź nazwisko"
               name="inputSurname" id="inputSurname">
      </div>

      <div class="form-group">
        <label class="col-form-label" for="inputBirth">Data urodzenia</label>
        <input type="date" class="form-control" name="inputBirth" id="inputBirth">
      </div>

      <div class="form-group">
        <label for="inputEmail">Email</label>
        <input type="email" class="form-control" name="inputEmail" placeholder="Wprowadź email" id="inputEmail">
      </div>

      <div class="form-group">
        <label class="col-form-label" for="inputSeniority">Staż pracy w firmie (w latach)</label>
        <input type="number" class="form-control" min="0" step="1" name="inputSeniority" id="inputSeniority" value="0">
      </div>

      <div class="form-group">
        <label for="login">Login</label>
        <input type="text" class="form-control" name="loginInput" id="login" placeholder="Utwórz login">
      </div>

      <div class="form-group">
        <label for="passwordInput">Hasło</label>
        <input type="password" class="form-control" name="passwordInput" id="passwordInput"
               placeholder="Utwórz hasło">
      </div>

      <div class="form-group">
        <label for="repeadPassword">Ponowne wprowadzenie hasła</label>
        <input type="password" class="form-control" name="repeadPassword" id="repeadPassword"
               placeholder="Ponownie wprowadź to samo hasło">
      </div>

      <button type="submit" class="btn btn-primary">UTWÓRZ KONTO</button>
    </fieldset>
  </form>
</main>
</body>
</html>
