<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion des commandes</title>
        <link rel="icon" href="favicon.png">
        <link href="assets/style/css/custom-bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="assets/js/jquery.min.js" type="text/javascript"></script>
        <script src="assets/js/bootstrap/bootstrap.bundle.js" type="text/javascript"></script>
    </head>
    <body>
        <header class="container-fluid text-center bg-primary p-2">
            <div class="d-flex align-items-center justify-content-between p-0">
                <h4 class="text-light m-0 me-4 d-none d-lg-block">Gestion des commandes</h4>
                <ul class="nav flex-fill flex-lg-row flex-column align-items-start justify-content-end fs-4">
                    <li class="nav-item">
                        <a class="nav-link py-0 text-center text-light px-lg-3 px-0" href="/G_Commande/login">Connexion</a>
                    </li>
                </ul>
            </div>
        </header>

        <main class="m-5">
            <div class="row">
                <section class="col-lg-4"></section>
                <section class="col-12 col-lg-4 p-4 pe-lg-3">
                    <form class="bg-light text-dark p-4 rounded" method="post" action="login">
                        <h2 class="text-primary">Connexion</h2>
                        <div class="d-flex flex-column">
                            <label class="my-2 form-label" for="idUser">Nom d'utilisateur</label>
                            <input class="my-2 form-control" type="text" name="userName" id="userName" value="<c:out value='${ userName }' />" autocomplete="off" required>
                        </div>
                        <div class="d-flex flex-column">
                            <label class="my-2 form-label" for="mdpUser">Mot de passe</label>
                            <input class="my-2 form-control" type="password" name="userPassword" id="userPassword" value="<c:out value='${ userPassword }' />" autocomplete="off" required>
                        </div>
                        <div class="d-flex justify-content-evenly mt-3 mb-1">
                            <input type="submit" id="submit" value="Se connecter" name="submit" class="flex-fill btn btn-primary">
                        </div>
                        <c:if test="${ errorMessage != '' }" >
                            <div class="alert alert-danger mt-4 mb-1" role="alert">
                                <c:out value="${ errorMessage }" />
                            </div>
                        </c:if>
                    </form>
                </section>
                <section class="col-lg-4"></section>
            </div>
        </main>
        <%@include file="../templates/footer.jsp" %>

