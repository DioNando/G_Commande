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
        <section class="col-12 col-lg-4 p-lg-4 p-2 pe-lg-3 d-flex flex-column">
            <div class="mb-4">
                <h2 class="text-primary mb-3" >Liste des produits par client</h2>
                <form class="bg-light text-dark rounded p-4 mb-1">
                    <label for="nomClientToSearch" class="form-label fs-5 text-success">Client</label>
                    <div class="d-flex mb-3">
                        <input type="text" id="idClient" class="me-3 form-control" readonly required>
                        <input type="text" id="nomClient" class="form-control" readonly>
                    </div>
                    <label for="nomClientToSearch" class="form-label fs-5 text-success">Choisir date début et fin</label>
                    <div class="d-flex">
                        <input type="date" id="dateDebut" class="form-control">
                        <input type="date" id="dateFin" class="ms-3 form-control">
                        <input type="button" class="flex-fill btn btn-success ms-3" id="submit" value="Chercher2Dates" onclick="select2Dates()" name="submit">
                    </div>
                </form>
            </div>
            <div class="">
                <h2 class="text-primary">Liste des clients</h2>
                <table class="table table-responsive table-hover table-striped w-100" id="tbl-produit">
                    <thead class="bg-primary">
                    <th>ID</th>
                    <th>Nom</th>
                    </thead>
                    <tbody class="align-middle">
                        <c:forEach var="client" items="${ listClient }">
                            <tr class="cursorTable" onclick="selectClient(<c:out value="${ client.idClient }" />)">
                                <th scope="row"><c:out value="${ client.idClient }" /></th>
                                <td><c:out value="${ client.nomClient }" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
        <section class="col-12 col-lg-8 p-lg-4 p-2 ps-lg-2">

            <div class="">
                <h2 class="text-primary">Liste des produits commandés par le client</h2>
                <table class="table table-responsive table-hover table-striped w-100" id="tbl-produit">
                    <thead class="bg-primary">
                    <th>Client</th>
                    <th>Designation Produit</th>
                    <th>Date Commande</th>
                    </thead>
                    <tbody class="align-middle" id="tableResult">
                    </tbody>
                </table>
            </div>

        </section>

    </div>

</main>
<%@include file="../templates/footer.jsp" %>

<script>

    function select2Dates() {
        $(document).ready(function () {
            $.ajax({
                url: "client",
                type: "POST",
                data: {
                    submit: "Chercher2Dates",
                    idClient: $("#idClient").val(),
                    dateDebut: $("#dateDebut").val(),
                    dateFin: $("#dateFin").val()
                },
                success: function (result) {
                    console.table(result);
                    $('#tableResult tr').remove();
                    if (result.length > 0) {
                        $.each(result, function (index, value) {
                            var html = '<tr>' +
                                    '<th scope="row">' + value.nomClient + '</th>' +
                                    '<td>' + value.designProduit + '</td>' +
                                    '<td>' + value.dateCommande + '</td>' +
                                    '</tr>';
                            $('#tableResult').append(html);
                        });
                    } else {
                        var html = '<tr>' +
                                '<td colspan="3">Aucun resultat n\'a été trouvé</td>' +
                        '</tr>';
                        $('#tableResult').append(html);
                    }

                },
                error: function () {
                    console.log("ERROR BRO");
                }
            });
        });
    }

    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    var yyyy_1 = today.getFullYear() - 1;
    today = yyyy + '-' + mm + '-' + dd;
    today_1 = yyyy_1 + '-' + mm + '-' + dd;
    $("#dateDebut").val(today_1);
    $("#dateFin").val(today);
    function selectProduit(idProduit) {
        $(document).ready(function () {
            $.ajax({
                url: "produit",
                type: "GET",
                dataType: "json",
                data: {
                    action: "Selectionner",
                    idProduit: idProduit
                },
                success: function (result) {
                    console.table(result);
                    $("#nomProduit").val(result.idProduit + " - " + result.designProduit);
                    $("#idProduit").val(result.idProduit);
                    $("#puProduit").val(result.prixUniProduit);
                    $("#stockProduit").val(result.stockProduit);
                    /* $("#listProduitCommande").append("<div>"
                     + result.idProduit + " - " + result.designProduit + " "
                     + "<b>" + result.prixUniProduit + "Ar </b>" +
                     "</div>"); */
                },
                error: function () {
                    console.log("Error");
                }
            });
        });
    }

    function selectClient(idClient) {
        $(document).ready(function () {
            $.ajax({
                url: "client",
                type: "GET",
                dataType: "json",
                data: {
                    action: "Selectionner",
                    idClient: idClient
                },
                success: function (result) {
                    console.table(result);
                    $("#nomClient").val(result.nomClient);
                    $("#idClient").val(result.idClient);
                },
                error: function () {
                    console.log("Error");
                }
            });
        });
    }

    function calculQuantite() {
        let quantite = $("#quantiteProduit").val();
        let pu = $("#puProduit").val();
        $("#prixProduit").val(quantite * pu);
    }
</script>  

