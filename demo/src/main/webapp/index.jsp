<%--<jsp:useBean id="totalClientesActivos" scope="request" type=""/>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sistema Multi-Works Group</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .welcome-section {
            background: linear-gradient(135deg, #6e8efb, #a777e3);
            color: white;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <!-- Encabezado -->
    <div class="welcome-section p-5 mb-5 text-center">
        <h1 class="display-4">Bienvenido a Multi-Works Group</h1>
        <p class="lead">Sistema de gestión de clientes, empleados y cotizaciones</p>
    </div>

    <!-- Tarjetas de módulos -->
    <div class="row g-4">
        <!-- Módulo Clientes -->
        <div class="col-md-4">
            <div class="card card-hover h-100">
                <div class="card-body text-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#6e8efb"
                         class="bi bi-people-fill mb-3" viewBox="0 0 16 16">
                        <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
                        <path fill-rule="evenodd"
                              d="M5.216 14A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216z"/>
                        <path d="M4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z"/>
                    </svg>
                    <h3 class="card-title">Clientes</h3>
                    <p class="card-text">Gestión de clientes naturales y jurídicos</p>
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-primary">Acceder</a>
                </div>
            </div>
        </div>

        <!-- Módulo Empleados -->
        <div class="col-md-4">
            <div class="card card-hover h-100">
                <div class="card-body text-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#a777e3"
                         class="bi bi-person-badge-fill mb-3" viewBox="0 0 16 16">
                        <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2zm4.5 0a.5.5 0 0 0 0 1h3a.5.5 0 0 0 0-1h-3zM8 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm5 2.755C12.146 12.825 10.623 12 8 12s-4.146.826-5 1.755V14a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-.245z"/>
                    </svg>
                    <h3 class="card-title">Empleados</h3>
                    <p class="card-text">Administración de personal permanente y por horas</p>
                    <a href="${pageContext.request.contextPath}/empleados" class="btn btn-primary">Acceder</a>
                </div>
            </div>
        </div>

        <!-- Módulo Cotizaciones -->
        <div class="col-md-4">
            <div class="card card-hover h-100">
                <div class="card-body text-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#4ecca3"
                         class="bi bi-file-earmark-text-fill mb-3" viewBox="0 0 16 16">
                        <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0zM9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1zM4.5 9a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM4 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 1 0-1h4a.5.5 0 0 1 0 1h-4z"/>
                    </svg>
                    <h3 class="card-title">Cotizaciones</h3>
                    <p class="card-text">Creación y seguimiento de proyectos y cotizaciones</p>
                    <a href="${pageContext.request.contextPath}/cotizaciones" class="btn btn-primary">Acceder</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Sección de información rápida -->
    <div class="row mt-5">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5>Accesos Rápidos</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/clientes?action=new"
                               class="text-decoration-none">Nuevo Cliente</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/empleados?action=new"
                               class="text-decoration-none">Nuevo Empleado</a>
                        </li>
                        <li class="list-group-item">
                            <a href="${pageContext.request.contextPath}/cotizaciones?action=new"
                               class="text-decoration-none">Nueva Cotización</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5>Estadísticas Recientes</h5>
                </div>
                <div class="card-body">
                    <p class="card-text">Total Clientes Activos: <span
                            class="badge bg-success">${totalClientesActivos}</span></p>
                    <p class="card-text">Total Empleados: <span class="badge bg-primary">${totalEmpleados}</span></p>
                    <p class="card-text">Cotizaciones en Proceso: <span
                            class="badge bg-warning text-dark">${cotizacionesEnProceso}</span></p>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <div class="container">
        <p class="mb-0">Sistema Multi-Works Group &copy; <%= java.time.Year.now().getValue() %></p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>