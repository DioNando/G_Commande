<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--

<nav class="mt-4">
    <ul class="pagination justify-content-end">

<c:if test="${currentPage != 1}">
    <li class="page-item">
        <a href="${pageActive}?page=${currentPage - 1}" class="page-link">Précédent</a>
    </li>
</c:if>


<c:forEach begin="1" end="${noOfPages}" var="i">
    <c:choose>
        <c:when test="${currentPage eq i}">
            <li class="page-item active"><a class="page-link">${i}</a></li>
        </c:when>
        <c:otherwise>
        <li class="page-item"><a href="${pageActive}?page=${i}" class="page-link">${i}</a></li>
        </c:otherwise>
    </c:choose>
</c:forEach>


<c:if test="${currentPage lt noOfPages}">
    <li class="page-item">
        <a href="${pageActive}?page=${currentPage + 1}" class="page-link">Suivant</a>
    </li>
</c:if>

</ul>
</nav>

-->

<nav class="mt-4 d-flex align-items-center justify-content-between bg-light text-dark p-3 rounded">
    <div class="fs-3">Total : ${noOfRecords}</div>
    <ul class="m-0 pagination justify-content-end">

        <%--For displaying Previous link except for the 1st page --%>
        <c:if test="${currentPage != 1}">
            <li class="page-item">
                <a href="${pageActive}?page=1" class="page-link">Début</a>
            </li>
        </c:if>

        <%--For displaying Page numbers. 
        The when condition does not display a link for the current page--%>

        <c:if test="${currentPage != 1}">
            <li class="page-item"><a href="${pageActive}?page=${currentPage - 1}" class="page-link">${currentPage - 1}</a></li>
            </c:if>
        <li class="page-item active"><a href="${pageActive}?page=${currentPage}" class="page-link">${currentPage}</a></li>
            <c:if test="${currentPage lt noOfPages}">
            <li class="page-item"><a href="${pageActive}?page=${currentPage + 1}" class="page-link">${currentPage + 1}</a></li>
            </c:if>

        <%--For displaying Next link --%>
        <c:if test="${currentPage lt noOfPages}">
            <li class="page-item">
                <a href="${pageActive}?page=${noOfPages}" class="page-link">Fin</a>
            </li>
        </c:if>

    </ul>
</nav>
