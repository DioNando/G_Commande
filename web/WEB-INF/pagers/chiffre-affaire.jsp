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
<main class="container-fluid" onload="showChart()">
    <section class="d-flex no-wrap justify-content-evenly mt-5">
        <div class="d-flex align-items-center justify-content-center">
            <div style="width: 650px">
                <canvas id="myChart2"></canvas>
            </div>
        </div>
        <div class="d-flex align-items-center justify-content-center">
            <div style="width: 650px">
                <canvas id="myChart"></canvas>
            </div>
        </div>
    </section>

    <div class="p-5">
        <section class="col-12 col-lg-4 p-lg-4 p-2 pe-lg-3 d-none">
            <h2 class="text-primary mb-3" >Chiffres d'affaires par client</h2>
            <form class="bg-light text-dark rounded p-4 mb-4">
                <label for="nomClientToSearch" class="form-label fs-5 text-success">Choisir année</label>
                <div class="d-flex">
                    <input type="date" id="nomClientToSearch" class="form-control" onkeyup="searchClient()">
                    <input type="submit" id="submit" value="Chercher" name="submit" class="flex-fill btn btn-success ms-3">
                </div>
            </form>
        </section>
        <section class="col-12 col-lg-12 p-lg-4 p-2 ps-lg-2">

            <table class="table table-responsive table-hover table-striped w-100">
                <thead class="bg-primary">
                <th>ID</th>
                <th>Nom</th>
                <th class="text-end">Montant</th>
                </thead>
                <tbody class="align-middle">
                    <c:forEach var="client" items="${ listClient }">
                        <tr>
                            <th scope="row"><c:out value="${ client.idClient }" /></th>
                            <td><c:out value="${ client.nomClient }" /></td>
                            <td class="text-end fw-bold"><c:out value="${ client.total } Ar" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                <div class='d-flex justify-content-between align-items-center fs-4 fw-bold mb-2'>
                    <div class="text-primary" >Chiffres d'affaires par client</div>
                    <div class="text-primary" >TOTAL : <c:out value="${ total }"/> Ar</div>
                </div>
                </tfoot>
            </table>


        </section>

    </div>


</main>
<%@include file="../templates/footer.jsp" %>

<script>
    function chartDisplay(result) {
        let labels = result.map(function (e) {
            return e.nomClient;
        });
        let data = result.map(function (e) {
            return e.total;
        });
        new Chart(document.getElementById('myChart'), {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                        label: "Chiffre d'affaire",
                        backgroundColor: ["#0788D9", "#3b3b3b", "#048ABF", "#ff9500", "#283e51", "#ff5f6d", "#ffc371", "#4b79a1"],
                        data: data,
                        borderWidth: false,
                    }],
            },
            options: {
                responsive: true,
                title: {
                    display: false,
                    text: 'Montant total'
                },
                legend: {
                    display: true,
                    position: 'top',
                    align: 'start',
                    labels: {
                        boxWidth: 50,
                        usePointStyle: true,
                        pointStyle: 'cross',
                    }
                },
            }
        });
        new Chart(document.getElementById('myChart2'), {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                        label: "Montant total",
                        backgroundColor: ["#0788D9", "#3b3b3b", "#048ABF", "#ff9500", "#283e51", "#ff5f6d", "#ffc371", "#4b79a1"],
                        data: data,
                        borderWidth: false,
                    }],
            },
            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Chiffre d\'affaires des clients'
                },
                legend: {
                    display: true,
                    position: 'top',
                    align: 'start',
                    labels: {
                        boxWidth: 50,
                        usePointStyle: true,
                        pointStyle: 'cross',
                    }
                },
            }
        });
    }
</script>

<script>
    $(document).ready(function () {
    });
    $(window).on("load", function () {
        $.ajax({
            url: 'client',
            type: 'post',
            dataType: 'JSON',
            data: {
                submit: "Chart",
            },
            success: function (result) {
                $(document).ready(function () {
                    chartDisplay(result);
                    console.log(result);
                });
            }
        })
    });
</script>

