<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Clientes</h2>
    <a href="clientes?action=new" class="btn btn-primary mb-3">Nuevo Cliente</a>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Teléfono</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="cliente" items="${listaClientes}">
            <tr>
                <td>${cliente.id}</td>
                <td>${cliente.nombre}</td>
                <td>${cliente.tipoPersona}</td>
                <td>${cliente.telefono}</td>
                <td>
                        <span class="badge ${cliente.estado == 'Activo' ? 'bg-success' : 'bg-danger'}">
                                ${cliente.estado}
                        </span>
                </td>
                <td>
                    <a href="clientes?action=edit&id=${cliente.id}" class="btn btn-sm btn-warning">Editar</a>
                    <a href="clientes?action=delete&id=${cliente.id}" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>