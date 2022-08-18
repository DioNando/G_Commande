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
    <div class="d-flex flex-column py-4 gap-3">
        <section class="container-fluid">
            <div class="row">

                <div class="col-12 col-lg-3">
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

                <div class="accordion col-12 col-lg-6" id="accordionPanelsStayOpenExample">
                    <div class="accordion-item bg-light text-dark mb-4 border-0">
                        <h2 class="accordion-header" id="panelsStayOpen-headingOne">
                            <button class="accordion-button fs-3 bg-light text-primary" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                                Nouvelle commande
                            </button>
                        </h2>
                        <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
                            <div class="accordion-body">
                                <form method="post" autocomplete="off">
                                    <div class="d-flex flex-column">
                                        <label class="my-2 form-label fw-bold" for="nomClient">Nom du client</label>
                                        <input class="my-2 form-control" type="text" name="nomClient" id="nomClient" readonly>
                                    </div>
                                    <div class="d-flex justify-content-evenly">
                                        <div class="flex-fill d-flex flex-column me-2">
                                            <label class="my-2 form-label fw-bold" for="idClient">Identification du client</label>
                                            <input class="my-2 form-control-plaintext" type="text" name="idClient" id="idClient" readonly>
                                        </div>
                                        <div class="flex-fill d-flex flex-column ms-2">
                                            <label class="my-2 form-label fw-bold" for="dateCommande">Date</label>
                                            <input class="my-2 form-control" type="date" name="dateCommande" id="dateCommande">
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly">
                                        <div class="flex-fill d-flex flex-column me-2">
                                            <label class="my-2 form-label fw-bold" for="nomProduit">Produit</label>
                                            <input class="my-2 form-control-plaintext" type="text" name="nomProduit" id="nomProduit" readonly>
                                        </div>
                                        <div class="flex-fill d-flex flex-column mx-2 d-none">
                                            <label class="my-2 form-label" for="idProduit">Idenfication du produit</label>
                                            <input class="my-2 form-control" type="text" name="idProduit" id="idProduit" readonly>
                                        </div>
                                        <div class="flex-fill d-flex flex-column ms-2">
                                            <label class="my-2 form-label fw-bold" for="puProduit">Prix Unitaire (Ar)</label>
                                            <input class="my-2 form-control-plaintext" type="number" name="puProduit" id="puProduit" readonly>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-evenly">
                                        <div class="flex-fill d-flex flex-column me-2">
                                            <label class="my-2 form-label fw-bold" for="stockProduit">Stock</label>
                                            <input class="my-2 form-control-plaintext" type="number" name="stockProduit" id="stockProduit" min="0" readonly>
                                        </div>
                                        <div class="flex-fill d-flex flex-column mx-2">
                                            <label class="my-2 form-label fw-bold" for="quantiteProduit">Quantité</label>
                                            <input class="my-2 form-control" type="number" name="quantiteProduit" id="quantiteProduit" value="0" min="1" onchange="calculQuantite()">
                                        </div>
                                        <div class="flex-fill d-flex flex-column ms-2">
                                            <label class="my-2 form-label fw-bold" for="prixProduit">Prix (Ar)</label>
                                            <input class="my-2 form-control" type="number" name="prixProduit" id="prixProduit" readonly>
                                        </div>
                                    </div>
                                    <div class="mt-3" id="listProduitCommande"></div>
                                    <div class="d-flex justify-content-end mt-3 mb-1">
                                        <input type="reset" id="reset" value="Effacer" name="reset" class="btn btn-outline-secondary me-2">
                                        <input type="submit" id="submit" value="Ajouter" name="submit" formaction="commande" class="btn btn-success ms-2">
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-3">
                    <h2 class="text-primary">Liste des produits</h2>
                    <table class="table table-responsive table-hover table-striped w-100" id="tbl-produit">
                        <thead class="bg-primary">
                        <th>ID</th>
                        <th>Désignation</th>
                        <th class="text-end">Stock</th>
                        </thead>
                        <tbody class="align-middle">
                            <c:forEach var="produit" items="${ listProduit }">
                                <tr class="cursorTable" onclick="selectProduit(<c:out value="${ produit.idProduit }" />)">
                                    <th scope="row"><c:out value="${ produit.idProduit }" /></th>
                                    <td><c:out value="${ produit.designProduit }" /></td>
                                    <th class="text-end"><c:out value="${ produit.stockProduit }" /></th>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <form class="bg-light text-dark rounded p-4 d-none" method="post" action="commande">
                <label for="inputSearch" class="form-label fs-5 text-success">Recherche d'une commande</label>
                <div class="d-flex">
                    <input type="search" id="inputSearch" class="form-control">
                    <input type="submit" id="submit" value="Chercher" name="submit" class="flex-fill btn btn-success ms-3">
                </div>
            </form>
        </section>
        <section class="container-fluid d-none">
            <h2 class="text-primary">Liste des commandes</h2>
            <table class="table table-dark table-responsive table-hover table-striped w-100">
                <thead class="bg-primary">
                <th>ID</th>
                <th>Client</th>
                <th>Date</th>
                <th class="text-end">Montant</th>
                <th class="text-center">Actions</th>
                </thead>
                <tbody class="align-middle">
                    <c:forEach var="commande" items="${ listCommande }">
                        <tr>
                            <th scope="row"><c:out value="${ commande.id } ${ commande.num }" /></th>
                            <td><c:out value="${ commande.num }" /></td>
                            <td class="d-flex align-items-center justify-content-evenly">
                                <a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectCommande(<c:out value="${ commande.num }" />)"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <%@include file="../templates/pagination.jsp" %>
            <%@include file="../templates/modalCommande.jsp" %>

        </section>

    </div>
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

