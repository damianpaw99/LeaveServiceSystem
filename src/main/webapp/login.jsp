<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Logowanie</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

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
                <li class="nav-item active">
                    <a class="nav-link" href="login.jsp">Logowanie
                    </a>
                </li>
                <li class="nav-item">
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
    <div class="jumbotron">
        <div class="container">
            <h3>Logowanie</h3>
            <div class="row form-group"></div>

            <form action="AdminServlet" method="post">

                <div class="form-group">
                    <label for="login">Login</label>
                    <input type="text" class="form-control" name="loginInput" id="login" placeholder="Wprowadź login">
                </div>
                <div class="form-group">
                    <label for="password">Hasło</label>
                    <input type="password" class="form-control" name="passwordInput" id="password"
                           placeholder="Wprowadź hasło">
                </div>

                <p class="text-danger">Błędny login lub hasło.</p>

                <button type="submit" class="btn btn-primary">Zaloguj</button>

                <div class="row form-group"></div>
                <div class="row form-group"></div>

                <h4 class="text-info">Nie masz konta? Zarejestruj się.</h4>
                <button type="button" class="btn btn-info" href="registration.html">Załóż konto</button>
            </form>

        </div>
    </div>
</main>

</body>
</html>
