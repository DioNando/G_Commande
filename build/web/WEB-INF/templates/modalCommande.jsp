<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalUpdate" aria-hidden="true" aria-labelledby="modalLabelUpdate" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-dark">
            <div class="modal-header">
                <h5 class="modal-title text-success" id="modalLabelUpdate">Modification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="alertHide()"></button>
            </div>
            <div class="modal-body">
                <div id="alertUpdate"></div>
                <div class="d-flex flex-column">
                    <label class="my-0 form-label" for="idCommandeToUpdate">Identification</label>
                    <input class="my-2 form-control" type="text" name="idCommandeToUpdate" id="idCommandeToUpdate" disabled readonly>
                </div>
                <div class="d-flex flex-column">
                    <label class="my-2 form-label" for="idProduitToUpdate">Produit</label>
                    <input class="my-2 form-control" type="text" name="produitCommandeToUpdate" id="idProduitToUpdate" autocomplete="off" required>
                </div>
                <div class="d-flex flex-column">
                    <label class="my-2 form-label" for="quantiteToUpdate">Quantité</label>
                    <input class="my-2 form-control" type="number" name="quantiteToUpdate" id="quantiteToUpdate" autocomplete="off" min="1" required>
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-between">
                <button class="btn btn-outline-danger" data-bs-target="#modalDelete" data-bs-toggle="modal">Supprimer</button>
                <div class="d-flex">
                    <button class="me-2 btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close" onclick="alertHide()">Annuler</button>
                    <button class="ms-2 btn btn-primary" onclick="updateCommande()">Modifier</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="modalDelete" aria-hidden="true" aria-labelledby="modalLabelDelete" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-dark">
            <div class="modal-header">
                <h5 class="modal-title text-success" id="modalLabelDelete">Suppression</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Voulez-vous vraiment supprimer cette ligne ?
            </div>
            <div class="modal-footer">
                <button class="me-2 btn btn-outline-secondary" data-bs-target="#modalUpdate" data-bs-toggle="modal" onclick="alertHide()">Annuler</button>
                <button class="ms-2 btn btn-danger" data-bs-dismiss="modal" aria-label="Close" onclick="deleteCommande()">Supprimer</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modalFacture" aria-hidden="true" aria-labelledby="modalLabelUpdate" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content text-dark">
            <div class="modal-header">
                <h5 class="modal-title text-success" id="modalLabelFacture">Details de la facture</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="alertHide()"></button>
            </div>
            <div class="modal-body">
                <div id="alertUpdate"></div>
                <div class="d-flex flex-column">
                    <label class="my-0 form-label" for="idCommandeFacture">Identification de la commande</label>
                    <input class="my-2 form-control" type="text" name="idCommandeFacture" id="idCommandeFacture" disabled readonly>
                </div>
                <div class="my-2">N° CLIENT : <span id="idClientFacture"></span> </div>
                <div class="my-2">NOM : <span id="nomClientFacture"></span> </div>

                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">DESIGNATION</th>
                            <th class="text-end" scope="col">PRIX UNITAIRE</th>
                            <th class="text-end" scope="col">QUANTITE</th>
                            <th class="text-end" scope="col">MONTANT</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row" id="designProduitFacture"></th>
                            <td class="text-end" id="prixUniFacture"></td>
                            <td class="text-end" id="quantiteFacture"></td>
                            <td class="text-end fw-bold" id="montantFacture"></td>
                        </tr>
                    </tbody>
                </table>
                <div>Arretée la presente facture à la somme de : <span id="montantLettreFacture" class="fw-bold"></span> </div>

            </div>
            <div class="modal-footer d-flex justify-content-between">
                <div class="d-flex">
                    <button class="me-2 btn btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close" onclick="alertHide()">Fermer</button>
                    <button class="ms-2 btn btn-primary" onclick="downloadFacture()">Télécharger</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div class="toast align-items-center text-dark bg-danger border-0" id="toastUpdateError" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Impossible d'afficher les details de la commande selectionnée !
            </div>
            <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div class="toast align-items-center text-dark bg-primary border-0" id="toastDelete" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Suppression réussie !
            </div>
            <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div class="toast align-items-center text-light bg-danger border-0" id="toastDeleteError" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Suppression impossible, veuillez reessayer !
            </div>
            <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script>
    function alertHide() {
        $("#alertUpdateContent").remove();
    }

    function selectCommande(idCommande) {
        $(document).ready(function () {
            $.ajax({
                url: "liste-commande",
                type: "GET",
                dataType: "json",
                data: {
                    action: "Selectionner",
                    idCommande: idCommande
                },
                success: function (result) {
                    console.table(result);
                    $("#modalLabelUpdate").html("Modification de la commande " + result.idCommande);
                    $("#modalLabelDelete").html("Suppression de la commande " + result.idCommande);
                    $("#idCommandeToUpdate").val(result.idCommande);
                    $("#idProduitToUpdate").val(result.idProduit);
                    $("#quantiteToUpdate").val(result.quantite);
                    $("#idCommandeFacture").val(result.idCommande);
                    // $("#idClientFacture").val(result.idClient);
                    $('#idClientFacture').html(result.idClient);
                    // $("#nomClientFacture").val(result.nomClient);
                    $('#nomClientFacture').html(result.nomClient);
                    $("#idProduitFacture").val(result.idProduit);
                    $("#designProduitFacture").html(result.designProduit);
                    $("#quantiteFacture").html(result.quantite);
                    $("#prixUniFacture").html(result.prixUniProduit + " Ar");
                    $("#montantFacture").html(result.montant + " Ar");
                    $("#montantLettreFacture").html(result.montantLettre.toUpperCase() + " AR");
                },
                error: function () {
                    $("#toastUpdateError").toast("show");
                    $("#modalUpdate").modal("hide");
                }
            });
        });
    }

    function updateCommande() {
        $(document).ready(function () {
            $.ajax({
                url: "commande",
                type: "POST",
                data: {
                    submit: "Modifier",
                    idCommande: $("#idCommandeToUpdate").val(),
                    idProduit: $("#idProduitToUpdate").val(),
                    quantite: $("#quantiteToUpdate").val()
                },
                success: function () {
                    $(document).ready(function () {
                        $("#alertUpdate").html('<div class="alert alert-success" id="alertUpdateContent" role="alert">Modification réussie</div>');
                    });
                },
                error: function () {
                    $("#alertUpdate").html('<div class="alert alert-danger" id="alertUpdateContent" role="alert">Erreur lors de la modification</div>');
                }
            });
        });
    }

    function deleteCommande() {
        $(document).ready(function () {
            $.ajax({
                url: "commande",
                type: "POST",
                data: {
                    submit: "Supprimer",
                    idCommande: $("#idCommandeToUpdate").val()
                },
                success: function () {
                    $(document).ready(function () {
                        $("#toastDelete").toast("show");
                    });
                },
                error: function () {
                    $("#toastDeleteError").toast("show");
                }
            });
        });
    }
</script>
