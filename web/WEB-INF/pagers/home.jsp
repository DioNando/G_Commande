<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../templates/header.jsp" %>
<nav class="container-fluid text-center bg-light p-1">
    <div class="d-flex align-items-center justify-content-between p-0">
        <ul class="nav flex-fill flex-lg-row flex-column align-items-start justify-content-start fs-5">

            <li class="nav-item">
                <a class="nav-link py-0 text-center px-lg-3 px-0" href="/G_Commande/client">Nouveau client</a>
            </li>
            <li class="mx-3 d-none d-lg-block">
                <img src="assets/img/dot.svg" width="5" height="5"/>
            </li>
            <li class="nav-item">
                <a class="nav-link py-0 text-center px-lg-3 px-0" href="/G_Commande/chiffre-affaire">Chiffre d'affaire</a>
            </li>
            <li class="mx-3 d-none d-lg-block">
                <img src="assets/img/dot.svg" width="5" height="5"/>
            </li>
            <li class="nav-item">
                <a class="nav-link py-0 text-center px-lg-3 px-0" href="/G_Commande/liste-2-date">Liste entre 2 dates</a>
            </li>
        </ul>
    </div>
</nav>
<main class="container-fluid fs-1">
    PAGE HOME
</main>
<%@include file="../templates/footer.jsp" %>

