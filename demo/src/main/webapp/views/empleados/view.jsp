<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detalle del Empleado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-0">Detalle del Empleado</h2>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Información Personal</h5>
                    <p><strong>ID:</strong> ${empleado.id}</p>
                    <p><strong>Nombre:</strong> ${empleado.nombre}</p>
                    <p><strong>Documento:</strong> ${empleado.documento}</p>
                    <p><strong>Tipo de Persona:</strong> ${empleado.tipoPersona}</p>
                </div>
                <div class="col-md-6">
                    <h5>Información Laboral</h5>
                    <p><strong>Tipo de Contratación:</strong> ${empleado.tipoContratacion}</p>
                    <p><strong>Estado:</strong>
                        <span class="badge ${empleado.estado == 'Activo' ? 'bg-success' : 'bg-danger'}">
                            ${empleado.estado}
                        </span>
                    </p>
                    <p><strong>Fecha Creación:</strong> ${empleado.fechaCreacion}</p>
                    <p><strong>Última Actualización:</strong> ${empleado.fechaActualizacion}</p>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Contacto</h5>
                    <p><strong>Teléfono:</strong> ${empleado.telefono}</p>
                    <p><strong>Email:</strong> ${empleado.email}</p>
                    <p><strong>Dirección:</strong> ${empleado.direccion}</p>
                </div>
                <div class="col-md-6">
                    <h5>Información Adicional</h5>
                    <p><strong>Creado Por:</strong> ${empleado.creadoPor}</p>
                    <c:if test="${empleado.estado == 'Inactivo'}">
                        <p><strong>Fecha Inactivación:</strong> ${empleado.fechaInactivacion}</p>
                    </c:if>
                </div>
            </div>

            <div class="mt-4">
                <h5>Asignaciones Recientes</h5>
                <c:choose>
                    <c:when test="${not empty asignaciones}">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>Cotización</th>
                                    <th>Título</th>
                                    <th>Área</th>
                                    <th>Horas</th>
                                    <th>Total</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="asignacion" items="${asignaciones}">
                                    <tr>
                                        <td>
                                            <a href="cotizaciones?action=view&id=${asignacion.cotizacionId}">${asignacion.cotizacionId}</a>
                                        </td>
                                        <td>${asignacion.titulo}</td>
                                        <td>${asignacion.areaAsignada}</td>
                                        <td>${asignacion.horasAproximadas}</td>
                                        <td>$${asignacion.getTotal()}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">Este empleado no tiene asignaciones recientes.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="card-footer">
            <a href="empleados?action=edit&id=${empleado.id}" class="btn btn-warning">Editar</a>
            <a href="empleados" class="btn btn-secondary">Volver</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>