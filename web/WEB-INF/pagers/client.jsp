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
<main class="container-fluid">
    <div class="row">
        <section class="col-12 col-lg-4 p-lg-4 p-2 pe-lg-3">
            <form class="bg-light text-dark rounded p-4 mb-4">
                <label for="nomClientToSearch" class="form-label fs-5 text-success">Recherche d'un client</label>
                <div class="d-flex">
                    <input type="search" id="nomClientToSearch" class="form-control" onkeyup="searchClient()" autocomplete="off">
                    <input type="submit" id="submit" value="Chercher" name="submit" class="flex-fill btn btn-success ms-3">
                </div>
            </form>
            <form class="bg-light text-dark p-4 rounded" method="post" autocomplete="off">
                <h3 class="text-success">Ajout d'un nouveau client</h3>
                <div class="d-flex flex-column">
                    <label class="my-2 form-label" for="nomClientToAdd">Nom du client</label>
                    <input class="my-2 form-control" type="text" name="nomClientToAdd" id="nomClientToAdd">
                </div>
                <div class="d-flex justify-content-end mt-3 mb-1">
                    <input type="reset" id="reset" value="Effacer" name="reset" class="btn btn-outline-secondary me-2">
                    <input type="submit" id="submit" value="Ajouter" name="submit" formaction="client" class="btn btn-success ms-2">
                </div>
            </form>
        </section>
        <section class="col-12 col-lg-8 p-lg-4 p-2 ps-lg-2">
            <table class="table table-responsive table-hover table-striped w-100">
                <thead class="bg-primary">
                <th>ID</th>
                <th>Nom</th>
                <th class="text-center">Actions</th>
                </thead>
                <tbody class="align-middle" id="tableResult">
                    <c:forEach var="client" items="${ listClient }">
                        <tr>
                            <th scope="row"><c:out value="${ client.idClient }" /></th>
                            <td><c:out value="${ client.nomClient }" /></td>
                            <td class="d-flex align-items-center justify-content-evenly">
                                <a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectClient(<c:out value="${ client.idClient }" />)"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <%@include file="../templates/pagination.jsp" %>
            <%@include file="../templates/modalClient.jsp" %>

        </section>

    </div>

    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div class="toast align-items-center text-dark bg-primary border-0" id="toastAdd" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    Ajout réussi !
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
        <div class="toast align-items-center text-light bg-danger border-0" id="toastAddError" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    Ajout impossible, veuillez reessayer !
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

</main>
<%@include file="../templates/footer.jsp" %>

<script>

    function addClient() {
        $(document).ready(function () {
            if ($("#nomClientToAdd").val() != "") {
                $.ajax({
                    url: "client",
                    type: "POST",
                    data: {
                        submit: "Ajouter",
                        nomClient: $("#nomClientToAdd").val()
                    },
                    success: function () {
                        $(document).ready(function () {
                            $("#toastAdd").toast("show");
                        });
                    },
                    error: function () {
                        $("#toastAddError").toast("show");
                    }
                });
            } else {
                $("#toastAddError").toast("show");
            }
        });
    }

    function searchClient() {
        $(document).ready(function () {
            $.ajax({
                url: "client",
                type: "POST",
                data: {
                    submit: "Chercher",
                    keywordClient: $("#nomClientToSearch").val()
                },
                success: function (result) {
                    console.log($("#nomClientToSearch").val());
                    console.table(result);
                    $('#tableResult tr').remove();
                    $.each(result, function (index, value) {
                        var html = '<tr>' +
                                '<th scope="row">' + value.idClient + '</th>' +
                                '<td>' + value.nomClient + '</td>' +
                                '<td class="d-flex align-items-center justify-content-evenly"><a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectClient(' + value.idClient + ')"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a></td>'
                                '</tr>';

                        $('#tableResult').append(html);
                    });

                },
                error: function () {
                    $("#toastAddError").toast("show");
                }
            });
        });
    }

</script>

