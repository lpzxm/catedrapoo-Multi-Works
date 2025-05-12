<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Cotizaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Cotizaciones</h2>
    <a href="cotizaciones?action=new" class="btn btn-primary mb-3">Nueva Cotización</a>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>#</th>
            <th>Cliente</th>
            <th>Fecha Inicio</th>
            <th>Fecha Fin</th>
            <th>Estado</th>
            <th>Total</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cotizacion" items="${listaCotizaciones}">
            <tr>
                <td>${cotizacion.id}</td>
                <td>${cotizacion.cliente.nombre}</td>
                <td>${cotizacion.fechaTentativaInicio}</td>
                <td>${cotizacion.fechaTentativaFin}</td>
                <td>
                        <span class="badge ${cotizacion.estado == 'Finalizada' ? 'bg-success' : 'bg-warning text-dark'}">
                                ${cotizacion.estado}
                        </span>
                </td>
                <td>$${cotizacion.getTotal()}</td>
                <td>
                    <a href="cotizaciones?action=view&id=${cotizacion.id}" class="btn btn-sm btn-info">Ver</a>
                    <a href="cotizaciones?action=edit&id=${cotizacion.id}" class="btn btn-sm btn-warning">Editar</a>
                    <c:if test="${cotizacion.estado != 'Finalizada'}">
                        <a href="cotizaciones?action=finalizar&id=${cotizacion.id}" class="btn btn-sm btn-success">Finalizar</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>