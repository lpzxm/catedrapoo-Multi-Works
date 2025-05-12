<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detalle de Asignación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-0">Detalle de Asignación</h2>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Información General</h5>
                    <p><strong>ID:</strong> ${asignacion.id}</p>
                    <p><strong>Título:</strong> ${asignacion.titulo}</p>
                    <p><strong>Área Asignada:</strong> ${asignacion.areaAsignada}</p>
                    <p><strong>Cotización:</strong>
                        <a href="cotizaciones?action=view&id=${asignacion.cotizacionId}">${asignacion.cotizacionId}</a>
                    </p>
                </div>
                <div class="col-md-6">
                    <h5>Detalles de Tiempo</h5>
                    <p><strong>Fecha/Hora Inicio:</strong> ${asignacion.fechaHoraInicio}</p>
                    <p><strong>Fecha/Hora Fin:</strong> ${asignacion.fechaHoraFin}</p>
                    <p><strong>Horas Aproximadas:</strong> ${asignacion.horasAproximadas}</p>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Información del Trabajador</h5>
                    <p><strong>Nombre:</strong> ${asignacion.trabajador.nombre}</p>
                    <p><strong>Tipo:</strong> ${asignacion.trabajador.tipoPersona}</p>
                    <p><strong>Contratación:</strong> ${asignacion.trabajador.tipoContratacion}</p>
                    <p><strong>Contacto:</strong> ${asignacion.trabajador.telefono} | ${asignacion.trabajador.email}</p>
                </div>
                <div class="col-md-6">
                    <h5>Información Económica</h5>
                    <p><strong>Costo por Hora:</strong> $${asignacion.costoPorHora}</p>
                    <p><strong>Incremento Extra:</strong> ${asignacion.incrementoExtra}%</p>
                    <p><strong>Subtotal:</strong> $${asignacion.horasAproximadas * asignacion.costoPorHora}</p>
                    <p><strong>Total:</strong> $${asignacion.getTotal()}</p>
                </div>
            </div>

            <div class="mt-4">
                <h5>Subtareas</h5>
                <c:choose>
                    <c:when test="${not empty asignacion.subtareas}">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Título</th>
                                    <th>Descripción</th>
                                    <th>Estado</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="subtarea" items="${asignacion.subtareas}">
                                    <tr>
                                        <td>${subtarea.titulo}</td>
                                        <td>${subtarea.descripcion}</td>
                                        <td>
                                                <span class="badge ${subtarea.completada ? 'bg-success' : 'bg-warning'}">
                                                        ${subtarea.completada ? 'Completada' : 'Pendiente'}
                                                </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">Esta asignación no tiene subtareas registradas.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="card-footer">
            <a href="cotizaciones?action=view&id=${asignacion.cotizacionId}" class="btn btn-secondary">Volver a
                Cotización</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>