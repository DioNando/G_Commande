<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../templates/header.jsp" %>
<nav class="container-fluid text-center bg-light p-1">
    <div class="d-flex align-items-center justify-content-between p-0">
        <ul class="nav flex-fill flex-lg-row flex-column align-items-start justify-content-start fs-5">

            <li class="nav-item">
                <a class="nav-link py-0 text-center px-lg-3 px-0" href="/G_Commande/commande">Nouvelle commande</a>
            </li>
            <li class="mx-3 d-none d-lg-block">
                <img src="assets/img/dot.svg" width="5" height="5"/>
            </li>
            <li class="nav-item">
                <a class="nav-link py-0 text-center px-lg-3 px-0" href="/G_Commande/liste-commande">Liste des commandes</a>
            </li>
        </ul>
    </div>
</nav>
<main class="container-fluid">

    <section class="container-fluid pt-3">
        <h2 class="text-primary">Liste des commandes</h2>
        <table class="table table-responsive table-hover table-striped w-100">
            <thead class="bg-primary">
            <th>ID Commande</th>
            <th class="text-center">Facture</th>
            <th>Date</th>
            <th>Client</th>
            <th>Produit</th>
            <th>Quantité</th>
            <th class="text-end">Montant</th>
            <th class="text-center">Actions</th>
            </thead>
            <tbody class="align-middle">
                <c:forEach var="commande" items="${ listCommande }">
                    <tr>
                        <th scope="row"><c:out value="${ commande.idCommande }" /></th>
                        <td class="d-flex no-wrap align-items-center justify-content-evenly">
                            <a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalFacture" role="button" onclick="selectCommande(<c:out value="${ commande.idCommande }" />)"><img src="assets/img/receipt.svg" class="position-absolute" width="15" height="15"/></a>
                        </td>
                        <td><c:out value="${ commande.dateCommande }" /></td>
                        <td class="fw-bold"><c:out value="${ commande.nomClient }" /></td>
                        <td><c:out value="${ commande.designProduit }" /></td>
                        <td><c:out value="${ commande.quantite }" /></td>
                        <td class="text-end fw-bold"><c:out value="${ commande.montant } Ar" /></td>
                        <td class="d-flex no-wrap align-items-center justify-content-evenly">
                            <a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectCommande(<c:out value="${ commande.idCommande }" />)"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <%@include file="../templates/pagination.jsp" %>
        <%@include file="../templates/modalCommande.jsp" %>

    </section>

</main>

<script>
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    $("#dateCommande").val(today);

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
<%@include file="../templates/footer.jsp" %>

