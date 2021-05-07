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
            <form action="RegistrationServlet">

                <fieldset>
                    <legend>Utwórz nowe konto pracownika</legend>

                    <%
                        String sName = (String) request.getAttribute("nameError");
                        String inputName=request.getParameter("inputFirstName");
                        if(inputName==null){inputName="";}
                        if (sName != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongFirstName\">Imię</label><input type=\"text\" value=\""+inputName+"\" name=\"inputFirstName\" class=\"form-control is-invalid\" id=\"wrongFirstName\"><div class=\"invalid-feedback\">" + sName + "</div></div>");
                        } else {
                            out.print("                    <div class=\"form-group\">\n" +
                                    "                        <label class=\"col-form-label\" for=\"inputFirstName\">Imię</label>\n" +
                                    "                        <input type=\"text\" class=\"form-control\" value=\""+inputName+"\" placeholder=\"Wprowadź imię\" name=\"inputFirstName\"\n" +
                                    "                               id=\"inputFirstName\">\n" +
                                    "                    </div>");
                        }
                    %>

                    <%
                        String sSurname = (String) request.getAttribute("surnameError");
                        String inputSurname=request.getParameter("inputSurname");
                        if(inputSurname==null){inputSurname="";}
                        if (sSurname != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongSurname\">Nazwisko</label><input type=\"text\" name=\"inputSurname\" value=\""+inputSurname+"\" class=\"form-control is-invalid\" id=\"wrongSurname\"><div class=\"invalid-feedback\">" + sSurname + "</div></div>");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label class=\"col-form-label\" for=\"inputSurname\">Nazwisko</label>\n" +
                                    "                        <input type=\"text\" class=\"form-control\" value=\""+inputSurname+"\" placeholder=\"Wprowadź nazwisko\"\n" +
                                    "                               name=\"inputSurname\" id=\"inputSurname\">\n" +
                                    "                    </div>");
                        }
                    %>


                    <%
                        String sBirth = (String) request.getAttribute("birthError");
                        String inputBirth=request.getParameter("inputBirth");
                        if(inputBirth==null){inputBirth="";}
                        if (sBirth != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongDate\">Data urodzenia</label><input type=\"date\" value=\""+inputBirth+"\" class=\"form-control is-invalid\" name=\"inputBirth\" id=\"wrongDate\"><div class=\"invalid-feedback\">" + sBirth + "</div></div>");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label class=\"col-form-label\" for=\"inputBirth\">Data urodzenia</label>\n" +
                                    "                        <input type=\"date\" class=\"form-control\" value=\""+inputBirth+"\" name=\"inputBirth\" id=\"inputBirth\">\n" +
                                    "                    </div>");
                        }
                    %>

                    <%
                        String sEmail = (String) request.getAttribute("emailError");
                        String inputEmail=request.getParameter("inputEmail");
                        if(inputEmail==null){inputEmail="";}
                        if (sEmail != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongEmail\">Email</label><input type=\"email\" value=\""+inputEmail+"\" name=\"inputEmail\" class=\"form-control is-invalid\" id=\"wrongEmail\"><div class=\"invalid-feedback\">" + sEmail + "</div></div>");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label for=\"inputEmail\">Email</label>\n" +
                                    "                        <input type=\"email\" class=\"form-control\" name=\"inputEmail\" value=\""+inputEmail+"\" placeholder=\"Wprowadź email\"\n" +
                                    "                               id=\"inputEmail\">\n" +
                                    "                    </div>");
                        }
                    %>

                    <%
                        String sYears = (String) request.getAttribute("yearsError");
                        String inputYears=request.getParameter("inputSeniority");
                        if(inputYears==null){inputYears="0";}
                        if (sYears != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongSeniority\">Staż pracy (w latach)</label><input type=\"number\" value=\""+inputYears+"\" name=\"inputSeniority\" class=\"form-control is-invalid\" id=\"wrongSeniority\"><div class=\"invalid-feedback\">" + sYears + "</div></div>");

                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label class=\"col-form-label\" for=\"inputSeniority\">Staż pracy (w latach)</label>\n" +
                                    "                        <input type=\"number\" class=\"form-control\" value=\""+inputYears+"\" min=\"0\" step=\"1\" name=\"inputSeniority\"\n" +
                                    "                               id=\"inputSeniority\"\n" +
                                    "                               value=\"0\">\n" +
                                    "                    </div>");
                        }
                    %>

                    <%
                        String s = (String) request.getAttribute("loginError");
                        String inputLogin=request.getParameter("loginInput");
                        if(inputLogin==null){inputLogin="";}
                        if (s != null) {
                            out.println("<div class=\"form-group has-danger\" > <label class=\"form-control-label\" for=\"wrongLogin\" > Login </label > <input type = \"text\" value = \""+inputLogin+"\" name=\"loginInput\" class=\"form-control is-invalid\" id = \"wrongLogin\" > <div class=\"invalid-feedback\" >" + s + " </div > </div >");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label for=\"login\">Login</label>\n" +
                                    "                        <input type=\"text\" class=\"form-control\" value=\""+inputLogin+"\" name=\"loginInput\" id=\"login\" placeholder=\"Utwórz login\">\n" +
                                    "                    </div>");
                        }
                    %>


                    <%
                        String sPassword = (String) request.getAttribute("mainPasswordError");
                        if (sPassword != null) {
                            out.println("<div class=\"form-group has-danger\"><label class=\"form-control-label\" for=\"wrongFirstPassword\">Hasło</label><input type=\"password\" value=\"\" class=\"form-control is-invalid\" id=\"wrongFirstPassword\"><div class=\"invalid-feedback\">" + sPassword + "</div></div>");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label for=\"passwordInput\">Hasło</label>\n" +
                                    "                        <input type=\"password\" class=\"form-control\" name=\"passwordInput\" id=\"passwordInput\"\n" +
                                    "                               placeholder=\"Utwórz hasło\">\n" +
                                    "                    </div>");
                        }
                    %>


                    <%
                        String s2 = (String) request.getAttribute("passwordError");
                        if (s2 != null) {
                            out.println("<div class=\"form-group has-danger\" ><label class=\"form-control-label\" for=\"wrongPassword\" > Ponowne wprowadzenie hasła</label ><input type = \"text\" value = \"\" class=\"form-control is-invalid\" id = \"wrongPassword\" ><div class=\"invalid-feedback\" >" + s2 + "</div ></div >");
                        } else {
                            out.println("                    <div class=\"form-group\">\n" +
                                    "                        <label for=\"repeatPassword\">Ponowne wprowadzenie hasła</label>\n" +
                                    "                        <input type=\"password\" class=\"form-control\" name=\"repeatPassword\" id=\"repeatPassword\"\n" +
                                    "                               placeholder=\"Ponownie wprowadź to samo hasło\">\n" +
                                    "                    </div>");
                        }
                    %>
                    <button type="submit" class="btn-primary btn-lg btn-block">UTWÓRZ KONTO</button>
                </fieldset>
            </form>
        </div>
    </div>
</main>
</body>
</html>