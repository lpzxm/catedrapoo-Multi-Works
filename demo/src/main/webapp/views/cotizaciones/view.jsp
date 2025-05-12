<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detalle de Cotización</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Cotización #${cotizacion.id}</h2>

    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Información General</h5>
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Cliente:</strong> ${cotizacion.cliente.nombre}</p>
                    <p><strong>Estado:</strong>
                        <span class="badge ${cotizacion.estado == 'Finalizada' ? 'bg-success' : 'bg-warning text-dark'}">
                            ${cotizacion.estado}
                        </span>
                    </p>
                </div>
                <div class="col-md-6">
                    <p><strong>Fecha Inicio:</strong> ${cotizacion.fechaTentativaInicio}</p>
                    <p><strong>Fecha Fin:</strong> ${cotizacion.fechaTentativaFin}</p>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between mb-3">
        <h4>Asignaciones</h4>
        <a href="cotizaciones?action=addAsignacion&cotizacionId=${cotizacion.id}" class="btn btn-primary">Agregar
            Asignación</a>
    </div>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Título</th>
            <th>Empleado</th>
            <th>Área</th>
            <th>Horas</th>
            <th>Costo/Hora</th>
            <th>Total</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="asignacion" items="${asignaciones}">
            <tr>
                <td>${asignacion.titulo}</td>
                <td>${asignacion.trabajador.nombre}</td>
                <td>${asignacion.areaAsignada}</td>
                <td>${asignacion.horasAproximadas}</td>
                <td>$${asignacion.costoPorHora}</td>
                <td>$${asignacion.getTotal()}</td>
                <td>
                    <a href="#" class="btn btn-sm btn-info">Ver</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Subtotal Asignaciones:</strong> $${cotizacion.getTotal() - cotizacion.costosAdicionales}
                    </p>
                    <p><strong>Costos Adicionales:</strong> $${cotizacion.costosAdicionales}</p>
                </div>
                <div class="col-md-6 text-end">
                    <h5><strong>Total:</strong> $${cotizacion.getTotal()}</h5>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-3">
        <a href="cotizaciones" class="btn btn-secondary">Volver</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>