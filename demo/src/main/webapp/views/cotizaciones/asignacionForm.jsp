<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Agregar Asignación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Agregar Asignación a Cotización #${cotizacionId}</h2>

    <form action="cotizaciones" method="post">
        <input type="hidden" name="action" value="addAsignacion">
        <input type="hidden" name="cotizacionId" value="${cotizacionId}">

        <div class="mb-3">
            <label for="titulo" class="form-label">Título de la Actividad</label>
            <input type="text" class="form-control" id="titulo" name="titulo" required>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="empleadoId" class="form-label">Empleado</label>
                <select class="form-select" id="empleadoId" name="empleadoId" required>
                    <option value="">Seleccione un empleado</option>
                    <c:forEach var="empleado" items="${empleados}">
                        <option value="${empleado.id}">
                                ${empleado.nombre} - ${empleado.tipoContratacion}
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6">
                <label for="areaAsignada" class="form-label">Área Asignada</label>
                <input type="text" class="form-control" id="areaAsignada" name="areaAsignada" required>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-4">
                <label for="fechaHoraInicio" class="form-label">Fecha/Hora Inicio</label>
                <input type="datetime-local" class="form-control" id="fechaHoraInicio" name="fechaHoraInicio" required>
            </div>
            <div class="col-md-4">
                <label for="fechaHoraFin" class="form-label">Fecha/Hora Fin</label>
                <input type="datetime-local" class="form-control" id="fechaHoraFin" name="fechaHoraFin" required>
            </div>
            <div class="col-md-4">
                <label for="horasAproximadas" class="form-label">Horas Aproximadas</label>
                <input type="number" step="0.5" class="form-control" id="horasAproximadas" name="horasAproximadas"
                       required>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="costoPorHora" class="form-label">Costo por Hora ($)</label>
                <input type="number" step="0.01" class="form-control" id="costoPorHora" name="costoPorHora" required>
            </div>
            <div class="col-md-6">
                <label for="incrementoExtra" class="form-label">Incremento Extra (%)</label>
                <input type="number" step="0.01" class="form-control" id="incrementoExtra" name="incrementoExtra"
                       value="0">
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Agregar Asignación</button>
        <a href="cotizaciones?action=view&id=${cotizacionId}" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>