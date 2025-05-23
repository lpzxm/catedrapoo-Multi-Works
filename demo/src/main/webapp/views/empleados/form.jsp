<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty empleado.id ? 'Nuevo' : 'Editar'} Empleado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>${empty empleado.id ? 'Nuevo' : 'Editar'} Empleado</h2>

    <form action="empleados" method="post">
        <input type="hidden" name="action" value="${empty empleado.id ? 'insert' : 'update'}">
        <c:if test="${not empty empleado.id}">
            <input type="hidden" name="id" value="${empleado.id}">
        </c:if>

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="${empleado.nombre}" required>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="documento" class="form-label">Documento</label>
                <input type="text" class="form-control" id="documento" name="documento" value="${empleado.documento}"
                       required>
            </div>
            <div class="col-md-6">
                <label for="tipoPersona" class="form-label">Tipo de Persona</label>
                <select class="form-select" id="tipoPersona" name="tipoPersona" required>
                    <option value="Natural" ${empleado.tipoPersona == 'Natural' ? 'selected' : ''}>Natural</option>
                    <option value="Juridica" ${empleado.tipoPersona == 'Juridica' ? 'selected' : ''}>Jurídica</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="tipoContratacion" class="form-label">Tipo de Contratación</label>
                <select class="form-select" id="tipoContratacion" name="tipoContratacion" required>
                    <option value="Permanente" ${empleado.tipoContratacion == 'Permanente' ? 'selected' : ''}>
                        Permanente
                    </option>
                    <option value="Por Horas" ${empleado.tipoContratacion == 'Por Horas' ? 'selected' : ''}>Por Horas
                    </option>
                </select>
            </div>
            <div class="col-md-6">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="tel" class="form-control" id="telefono" name="telefono" value="${empleado.telefono}">
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${empleado.email}">
            </div>
            <div class="col-md-6">
                <label for="estado" class="form-label">Estado</label>
                <select class="form-select" id="estado" name="estado" required>
                    <option value="Activo" ${empleado.estado == 'Activo' ? 'selected' : ''}>Activo</option>
                    <option value="Inactivo" ${empleado.estado == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label for="direccion" class="form-label">Dirección</label>
            <textarea class="form-control" id="direccion" name="direccion">${empleado.direccion}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="empleados" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Validar campo Nombre: solo letras y espacios
    document.getElementById('nombre').addEventListener('input', function (e) {
        e.target.value = e.target.value.replace(/[^a-zA-ZÁÉÍÓÚáéíóúÑñ\s]/g, '');
    });

    // Validar campo Documento: solo números y formato ########-#
    const docInput = document.getElementById('documento');
    docInput.addEventListener('input', function (e) {
        let value = e.target.value.replace(/\D/g, ''); // Solo dígitos
        value = value.slice(0, 9); // Máximo 9 dígitos
        if (value.length > 8) {
            value = value.slice(0, 8) + '-' + value.slice(8);
        }
        e.target.value = value;
    });
    docInput.addEventListener('blur', function (e) {
        if (!/^\d{8}-\d$/.test(e.target.value)) {
            alert('El formato del DUI debe ser ########-#');
            e.target.focus();
        }
    });

    // Validar campo Teléfono: solo números
    document.getElementById('telefono').addEventListener('input', function (e) {
        e.target.value = e.target.value.replace(/\D/g, '');
    });
</script>

</body>
</html>