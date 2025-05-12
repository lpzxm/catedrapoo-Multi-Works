<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detalle del Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-0">Detalle del Cliente</h2>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Información Básica</h5>
                    <p><strong>ID:</strong> ${cliente.id}</p>
                    <p><strong>Nombre:</strong> ${cliente.nombre}</p>
                    <p><strong>Documento:</strong> ${cliente.documento}</p>
                    <p><strong>Tipo de Persona:</strong> ${cliente.tipoPersona}</p>
                </div>
                <div class="col-md-6">
                    <h5>Estado</h5>
                    <p><strong>Estado:</strong>
                        <span class="badge ${cliente.estado == 'Activo' ? 'bg-success' : 'bg-danger'}">
                            ${cliente.estado}
                        </span>
                    </p>
                    <p><strong>Fecha Creación:</strong> ${cliente.fechaCreacion}</p>
                    <p><strong>Última Actualización:</strong> ${cliente.fechaActualizacion}</p>
                    <c:if test="${cliente.estado == 'Inactivo'}">
                        <p><strong>Fecha Inactivación:</strong> ${cliente.fechaInactivacion}</p>
                    </c:if>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <h5>Información de Contacto</h5>
                    <p><strong>Teléfono:</strong> ${cliente.telefono}</p>
                    <p><strong>Email:</strong> ${cliente.email}</p>
                    <p><strong>Dirección:</strong> ${cliente.direccion}</p>
                </div>
                <div class="col-md-6">
                    <h5>Información Adicional</h5>
                    <p><strong>Creado Por:</strong> ${cliente.creadoPor}</p>
                </div>
            </div>

            <div class="mt-4">
                <h5>Cotizaciones Relacionadas</h5>
                <c:choose>
                    <c:when test="${not empty cotizaciones}">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                <tr>
                                    <th>ID Cotización</th>
                                    <th>Fecha Inicio</th>
                                    <th>Fecha Fin</th>
                                    <th>Estado</th>
                                    <th>Total</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cotizacion" items="${cotizaciones}">
                                    <tr>
                                        <td><a href="cotizaciones?action=view&id=${cotizacion.id}">${cotizacion.id}</a>
                                        </td>
                                        <td>${cotizacion.fechaTentativaInicio}</td>
                                        <td>${cotizacion.fechaTentativaFin}</td>
                                        <td>
                                                <span class="badge ${cotizacion.estado == 'Finalizada' ? 'bg-success' : 'bg-warning text-dark'}">
                                                        ${cotizacion.estado}
                                                </span>
                                        </td>
                                        <td>$${cotizacion.getTotal()}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">Este cliente no tiene cotizaciones registradas.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="card-footer">
            <a href="clientes?action=edit&id=${cliente.id}" class="btn btn-warning">Editar</a>
            <a href="clientes" class="btn btn-secondary">Volver</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>