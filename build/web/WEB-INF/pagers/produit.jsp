<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../templates/header.jsp" %>
<main class="container-fluid">
    <div class="row">
        <section class="col-12 col-lg-4 p-lg-4 p-2 pe-lg-3">
            <form class="bg-light text-dark rounded p-4 mb-4" method="post" action="produit">
                <label for="designProduitToSearch" class="form-label fs-5 text-success">Recherche d'un produit</label>
                <div class="d-flex">
                    <input type="search" id="designProduitToSearch" class="form-control" onkeydown="searchClient()">
                    <input type="submit" id="submit" value="Chercher" name="submitProduit" class="flex-fill btn btn-success ms-3">
                </div>
            </form>
            <form class="bg-light text-dark p-4 rounded" method="post" autocomplete="off">
                <h3 class="text-success">Ajout d'un nouveau produit</h3>
                <div class="d-flex flex-column">
                    <label class="my-2 form-label" for="designProduitToAdd">Désignation</label>
                    <input class="my-2 form-control" type="text" name="designProduitToAdd" id="designProduit" required>
                </div>
                <div class="d-flex justify-content-evenly">
                    <div class="flex-fill d-flex flex-column me-2">
                        <label class="my-2 form-label" for="prixUniProduitToAdd">Prix Unitaire (Ar)</label>
                        <input class="my-2 form-control" type="number" name="prixUniProduitToAdd" id="prixUniProduitToAdd" min="0" required>
                    </div>
                    <div class="flex-fill d-flex flex-column ms-2">
                        <label class="my-2 form-label" for="stockProduitToAdd">Stock</label>
                        <input class="my-2 form-control" type="number" name="stockProduitToAdd" id="stockProduitToAdd" value="0" min="0">
                    </div>
                </div>
                <div class="d-flex justify-content-end mt-3 mb-1">
                    <input type="reset" id="reset" value="Effacer" name="reset" class="btn btn-outline-secondary me-2">
                    <input type="submit" id="submit" value="Ajouter" name="submit" formaction="produit" class="btn btn-success ms-2">
                </div>

            </form>
        </section>
        <section class="col-12 col-lg-8 p-lg-4 p-2 ps-lg-2">
            <table class="table table-responsive table-hover table-striped w-100" id="tbl-produit">
                <thead class="bg-primary">
                <th>ID</th>
                <th>Désignation</th>
                <th class="text-end">Prix Unitaire (Ar)</th>
                <th class="text-end">Stock</th>
                <th class="text-center">Actions</th>
                </thead>
                <tbody class="align-middle" id="tableResult">
                    <c:forEach var="produit" items="${ listProduit }">
                        <tr>
                            <th scope="row"><c:out value="${ produit.idProduit }" /></th>
                            <td><c:out value="${ produit.designProduit }" /></td>
                            <td class="text-end"><c:out value="${ produit.prixUniProduit}" /></td>
                            <td class="text-end"><c:out value="${ produit.stockProduit }" /></td>
                            <td class="d-flex align-items-center justify-content-evenly">
                                <a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectProduit(<c:out value="${ produit.idProduit }" />)"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <%@include file="../templates/pagination.jsp" %>
            <%@include file="../templates/modalProduit.jsp" %>

        </section>
    </div>
</main>
<%@include file="../templates/footer.jsp" %>

<script>

    function addProduit() {
        $(document).ready(function () {
            if ($("#designProduitToAdd").val() != "") {
                $.ajax({
                    url: "produit",
                    type: "POST",
                    data: {
                        submit: "Ajouter",
                        designProduit: $("#designProduitToAdd").val(),
                        prixUniProduit: $("#prixUniProduitToAdd").val(),
                        stockProduit: $("#stockProduitToAdd").val()
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
                url: "produit",
                type: "POST",
                data: {
                    submit: "Chercher",
                    keywordProduit: $("#designProduitToSearch").val()
                },
                success: function (result) {
                    console.log($("#designProduitToSearch").val());
                    console.table(result);
                    $('#tableResult tr').remove();
                    $.each(result, function (index, value) {
                        var html = '<tr>' +
                                '<th scope="row">' + value.idProduit + '</th>' +
                                '<td>' + value.designProduit + '</td>' +
                                '<td>' + value.prixUniProduit + '</td>' +
                                '<td>' + value.stockProduit + '</td>' +
                                '<td class="d-flex align-items-center justify-content-evenly"><a type="button" class="btn btn-primary position-relative rounded-circle d-flex align-items-center justify-content-center p-3" data-bs-toggle="modal" href="#modalUpdate" role="button" onclick="selectProduit(' + value.idProduit + ')"><img src="assets/img/ellipsis.svg" class="position-absolute" width="15" height="15"/></a></td>'
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

