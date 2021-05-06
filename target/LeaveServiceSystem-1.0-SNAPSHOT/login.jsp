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
    <link rel="stylesheet" href="css/split.css">
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.html">BiteOfRest</a>
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
                <li class="nav-item active">
                    <a class="nav-link" href="login.jsp">Logowanie
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="registration.jsp">Rejestracja
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main>
    <div class="split left">
        <div class="container">
            <div class="centered">
                <form action="LoginServlet" method="post">

                    <h3>Logowanie:</h3>

                    <div class="row form-group"></div>

                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" class="form-control" name="loginInput" id="login"
                               placeholder="Wprowadź login">
                    </div>
                    <div class="form-group">
                        <label for="password">Hasło</label>
                        <input type="password" class="form-control" name="passwordInput" id="password"
                               placeholder="Wprowadź hasło">
                    </div>

                    <p class="text-danger">
                        <%
                            String s=(String)request.getAttribute("loginError");
                            if(s!=null){
                                out.println(s);
                            }
                        %>
                    </p>

                    <button type="submit" class="btn btn-primary btn-lg btn-block">Zaloguj</button>
                </form>
            </div>
        </div>
    </div>
    <div class="vl centered"></div>

    <div class="split right">
        <div class="centered">
            <h4 class="text-warning">Nie masz konta? Zarejestruj się.</h4>
            <form action="registration.jsp" method="get">
                <button type="submit" class="btn btn-warning btn-lg btn-block">Załóż konto</button>
            </form>
        </div>
    </div>

</main>

</body>
</html>
