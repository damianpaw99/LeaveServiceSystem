<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>Rejestracja</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="shortcut icon" type="image/png" href="images/favicon.png"/>
    <link rel="stylesheet" href="css/bootstrap.css">

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
                    <a class="nav-link" href="index.html">Strona główna</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Logowanie </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="registration.jsp">Rejestracja </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
<main>
    <div class="jumbotron">
        <div class="container">
            <form action="ControllerServlet">

                <fieldset>
                    <legend>Utwórz nowe konto pracownika</legend>

                    <div class="form-group">
                        <label class="col-form-label" for="inputFirstName">Imię</label>
                        <input type="text" class="form-control" placeholder="Wprowadź imię" name="inputFirstName"
                               id="inputFirstName">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongFirstName">Imię</label>
                        <input type="text" value="" class="form-control is-invalid" id="wrongFirstName">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label class="col-form-label" for="inputSurname">Nazwisko</label>
                        <input type="text" class="form-control" placeholder="Wprowadź nazwisko"
                               name="inputSurname" id="inputSurname">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongSurname">Nazwisko</label>
                        <input type="text" value="" class="form-control is-invalid" id="wrongSurname">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label class="col-form-label" for="inputBirth">Data urodzenia</label>
                        <input type="date" class="form-control" name="inputBirth" id="inputBirth">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongDate">Data urodzenia</label>
                        <input type="date" value="" class="form-control is-invalid" id="wrongDate">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label for="inputEmail">Email</label>
                        <input type="email" class="form-control" name="inputEmail" placeholder="Wprowadź email"
                               id="inputEmail">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongEmail">Email</label>
                        <input type="email" value="" class="form-control is-invalid" id="wrongEmail">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label class="col-form-label" for="inputSeniority">Staż pracy (w latach)</label>
                        <input type="number" class="form-control" min="0" step="1" name="inputSeniority"
                               id="inputSeniority"
                               value="0">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongSeniority">Staż pracy (w latach)</label>
                        <input type="number" value="" class="form-control is-invalid" id="wrongSeniority">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label for="login">Login</label>
                        <input type="text" class="form-control" name="loginInput" id="login" placeholder="Utwórz login">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongLogin">Login</label>
                        <input type="text" value="błędny login" class="form-control is-invalid" id="wrongLogin">
                        <div class="invalid-feedback">Użytkownik o takim loginie już istnieje. Wprowadź inny login.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="passwordInput">Hasło</label>
                        <input type="password" class="form-control" name="passwordInput" id="passwordInput"
                               placeholder="Utwórz hasło">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongFirstPassword">Hasło</label>
                        <input type="password" value="" class="form-control is-invalid" id="wrongFirstPassword">
                        <div class="invalid-feedback">PodPIS</div>
                    </div>

                    <div class="form-group">
                        <label for="repeadPassword">Ponowne wprowadzenie hasła</label>
                        <input type="password" class="form-control" name="repeadPassword" id="repeadPassword"
                               placeholder="Ponownie wprowadź to samo hasło">
                    </div>

                    <div class="form-group has-danger">
                        <label class="form-control-label" for="wrongPassword">Ponowne wprowadzenie hasła</label>
                        <input type="text" value="błędne hasło" class="form-control is-invalid" id="wrongPassword">
                        <div class="invalid-feedback">Błędne hasło.</div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg btn-block">Utwórz konto</button>
                </fieldset>
            </form>
        </div>
    </div>
</main>
</body>
</html>
