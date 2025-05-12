package model;

import java.util.Date;
import java.util.List;

public class Cotizacion {
    private String id;
    private Cliente cliente;
    private Date fechaCreacion;
    private Date fechaTentativaInicio;
    private Date fechaTentativaFin;
    private double costosAdicionales;
    private String estado; // En proceso/Finalizada
    private List<Asignacion> asignaciones;

    // Constructor vacío
    public Cotizacion() {
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Date getFechaTentativaInicio() {
        return fechaTentativaInicio;
    }

    public void setFechaTentativaInicio(Date fechaTentativaInicio) {
        this.fechaTentativaInicio = fechaTentativaInicio;
    }

    public Date getFechaTentativaFin() {
        return fechaTentativaFin;
    }

    public void setFechaTentativaFin(Date fechaTentativaFin) {
        this.fechaTentativaFin = fechaTentativaFin;
    }

    public double getCostosAdicionales() {
        return costosAdicionales;
    }

    public void setCostosAdicionales(double costosAdicionales) {
        this.costosAdicionales = costosAdicionales;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public List<Asignacion> getAsignaciones() {
        return asignaciones;
    }

    public void setAsignaciones(List<Asignacion> asignaciones) {
        this.asignaciones = asignaciones;
    }

    // Método para calcular el total de la cotización
    public double getTotal() {
        double totalAsignaciones = 0;
        if (asignaciones != null) {
            for (Asignacion asignacion : asignaciones) {
                totalAsignaciones += asignacion.getTotal();
            }
        }
        return totalAsignaciones + costosAdicionales;
    }

    @Override
    public String toString() {
        return "Cotizacion{" +
                "id='" + id + '\'' +
                ", cliente=" + cliente +
                ", fechaTentativaInicio=" + fechaTentativaInicio +
                ", fechaTentativaFin=" + fechaTentativaFin +
                ", costosAdicionales=" + costosAdicionales +
                ", estado='" + estado + '\'' +
                '}';
    }
}
