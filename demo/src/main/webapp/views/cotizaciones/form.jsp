<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty cotizacion.id ? 'Nueva' : 'Editar'} Cotización</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>${empty cotizacion.id ? 'Nueva' : 'Editar'} Cotización</h2>

    <form action="cotizaciones" method="post">
        <input type="hidden" name="action" value="${empty cotizacion.id ? 'insert' : 'update'}">
        <c:if test="${not empty cotizacion.id}">
            <input type="hidden" name="id" value="${cotizacion.id}">
        </c:if>

        <div class="mb-3">
            <label for="clienteId" class="form-label">Cliente</label>
            <select class="form-select" id="clienteId" name="clienteId" required>
                <option value="">Seleccione un cliente</option>
                <c:forEach var="cliente" items="${clientes}">
                    <option value="${cliente.id}" ${cotizacion.cliente.id == cliente.id ? 'selected' : ''}>
                            ${cliente.nombre}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="fechaTentativaInicio" class="form-label">Fecha Tentativa de Inicio</label>
                <input type="date" class="form-control" id="fechaTentativaInicio" name="fechaTentativaInicio"
                       value="${cotizacion.fechaTentativaInicio}" required>
            </div>
            <div class="col-md-6">
                <label for="fechaTentativaFin" class="form-label">Fecha Tentativa de Fin</label>
                <input type="date" class="form-control" id="fechaTentativaFin" name="fechaTentativaFin"
                       value="${cotizacion.fechaTentativaFin}" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="costosAdicionales" class="form-label">Costos Adicionales ($)</label>
            <input type="number" step="0.01" class="form-control" id="costosAdicionales" name="costosAdicionales"
                   value="${cotizacion.costosAdicionales}" required>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="cotizaciones" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const fechaInicio = document.getElementById('fechaTentativaInicio');
        const fechaFin = document.getElementById('fechaTentativaFin');

        // Establecer el mínimo de fecha de inicio como hoy
        const today = new Date().toISOString().split('T')[0];
        fechaInicio.setAttribute('min', today);

        // Crear contenedor para el mensaje de validación
        const alerta = document.createElement('div');
        alerta.className = 'alert alert-danger mt-2';
        alerta.style.display = 'none';
        fechaFin.parentElement.appendChild(alerta);

        // Validar fechas
        function validarFechas() {
            const inicio = new Date(fechaInicio.value);
            const fin = new Date(fechaFin.value);

            if (fechaInicio.value && fechaFin.value && fin <= inicio) {
                alerta.textContent = 'La fecha de fin debe ser mayor que la fecha de inicio.';
                alerta.style.display = 'block';
                fechaFin.setCustomValidity('La fecha de fin debe ser mayor.');
            } else {
                alerta.style.display = 'none';
                fechaFin.setCustomValidity('');
            }
        }

        fechaInicio.addEventListener('change', function () {
            // También actualizamos el mínimo de fecha de fin
            if (fechaInicio.value) {
                fechaFin.setAttribute('min', fechaInicio.value);
            } else {
                fechaFin.removeAttribute('min');
            }
            validarFechas();
        });

        fechaFin.addEventListener('change', validarFechas);
    });
</script>

</body>
</html>