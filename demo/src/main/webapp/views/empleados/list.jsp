<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Empleados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Empleados</h2>
    <a href="empleados?action=new" class="btn btn-primary mb-3">Nuevo Empleado</a>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Contratación</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="empleado" items="${listaEmpleados}">
            <tr>
                <td>${empleado.id}</td>
                <td>${empleado.nombre}</td>
                <td>${empleado.tipoPersona}</td>
                <td>${empleado.tipoContratacion}</td>
                <td>
                        <span class="badge ${empleado.estado == 'Activo' ? 'bg-success' : 'bg-danger'}">
                                ${empleado.estado}
                        </span>
                </td>
                <td>
                    <a href="empleados?action=edit&id=${empleado.id}" class="btn btn-sm btn-warning">Editar</a>
                    <a href="empleados?action=delete&id=${empleado.id}" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>