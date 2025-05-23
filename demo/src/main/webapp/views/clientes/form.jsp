<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${empty cliente.id ? 'Nuevo' : 'Editar'} Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>${empty cliente.id ? 'Nuevo' : 'Editar'} Cliente</h2>

    <form action="clientes" method="post">
        <input type="hidden" name="action" value="${empty cliente.id ? 'insert' : 'update'}">
        <c:if test="${not empty cliente.id}">
            <input type="hidden" name="id" value="${cliente.id}">
        </c:if>

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="${cliente.nombre}" required>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="documento" class="form-label">Documento</label>
                <input type="text" class="form-control" id="documento" name="documento" value="${cliente.documento}"
                       required>
            </div>
            <div class="col-md-6">
                <label for="tipoPersona" class="form-label">Tipo de Persona</label>
                <select class="form-select" id="tipoPersona" name="tipoPersona" required>
                    <option value="Natural" ${cliente.tipoPersona == 'Natural' ? 'selected' : ''}>Natural</option>
                    <option value="Juridica" ${cliente.tipoPersona == 'Juridica' ? 'selected' : ''}>Jurídica</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="tel" class="form-control" id="telefono" name="telefono" value="${cliente.telefono}">
            </div>
            <div class="col-md-6">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="${cliente.email}">
            </div>
        </div>

        <div class="mb-3">
            <label for="direccion" class="form-label">Dirección</label>
            <textarea class="form-control" id="direccion" name="direccion">${cliente.direccion}</textarea>
        </div>

        <div class="mb-3">
            <label for="estado" class="form-label">Estado</label>
            <select class="form-select" id="estado" name="estado" required>
                <option value="Activo" ${cliente.estado == 'Activo' ? 'selected' : ''}>Activo</option>
                <option value="Inactivo" ${cliente.estado == 'Inactivo' ? 'selected' : ''}>Inactivo</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="clientes" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById('nombre').addEventListener('input', function (e) {
        // Solo permite letras y espacios (mayúsculas y minúsculas)
        const soloLetras = e.target.value.replace(/[^a-zA-ZÁÉÍÓÚáéíóúÑñ\s]/g, '');
        e.target.value = soloLetras;
    });

    const docInput = document.getElementById('documento');

    docInput.addEventListener('input', function (e) {
        // Elimina todo lo que no sea número
        let value = e.target.value.replace(/\D/g, '');

        // Limita a 9 dígitos
        value = value.slice(0, 9);

        // Formatea como ########-#
        if (value.length > 8) {
            value = value.slice(0, 8) + '-' + value.slice(8);
        }

        e.target.value = value;
    });

    document.getElementById('telefono').addEventListener('input', function (e) {
        // Elimina cualquier carácter que no sea número
        e.target.value = e.target.value.replace(/\D/g, '');
    });
</script>

</body>
</html>
