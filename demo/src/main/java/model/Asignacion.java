package model;

import java.util.Date;
import java.util.List;

public class Asignacion {
    private String id;
    private String cotizacionId;
    private String titulo;
    private Empleado trabajador;
    private String areaAsignada;
    private double costoPorHora;
    private Date fechaHoraInicio;
    private Date fechaHoraFin;
    private double horasAproximadas;
    private double incrementoExtra; // %
    private List<Subtarea> subtareas;

    // Constructor vacío
    public Asignacion() {
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCotizacionId() {
        return cotizacionId;
    }

    public void setCotizacionId(String cotizacionId) {
        this.cotizacionId = cotizacionId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Empleado getTrabajador() {
        return trabajador;
    }

    public void setTrabajador(Empleado trabajador) {
        this.trabajador = trabajador;
    }

    public String getAreaAsignada() {
        return areaAsignada;
    }

    public void setAreaAsignada(String areaAsignada) {
        this.areaAsignada = areaAsignada;
    }

    public double getCostoPorHora() {
        return costoPorHora;
    }

    public void setCostoPorHora(double costoPorHora) {
        this.costoPorHora = costoPorHora;
    }

    public Date getFechaHoraInicio() {
        return fechaHoraInicio;
    }

    public void setFechaHoraInicio(Date fechaHoraInicio) {
        this.fechaHoraInicio = fechaHoraInicio;
    }

    public Date getFechaHoraFin() {
        return fechaHoraFin;
    }

    public void setFechaHoraFin(Date fechaHoraFin) {
        this.fechaHoraFin = fechaHoraFin;
    }

    public double getHorasAproximadas() {
        return horasAproximadas;
    }

    public void setHorasAproximadas(double horasAproximadas) {
        this.horasAproximadas = horasAproximadas;
    }

    public double getIncrementoExtra() {
        return incrementoExtra;
    }

    public void setIncrementoExtra(double incrementoExtra) {
        this.incrementoExtra = incrementoExtra;
    }

    public List<Subtarea> getSubtareas() {
        return subtareas;
    }

    public void setSubtareas(List<Subtarea> subtareas) {
        this.subtareas = subtareas;
    }

    // Método para calcular el total de la asignación
    public double getTotal() {
        double costoBase = horasAproximadas * costoPorHora;
        return costoBase * (1 + incrementoExtra / 100);
    }

    @Override
    public String toString() {
        return "Asignacion{" +
                "id='" + id + '\'' +
                ", cotizacionId='" + cotizacionId + '\'' +
                ", titulo='" + titulo + '\'' +
                ", trabajador=" + trabajador +
                ", areaAsignada='" + areaAsignada + '\'' +
                ", costoPorHora=" + costoPorHora +
                ", fechaHoraInicio=" + fechaHoraInicio +
                ", fechaHoraFin=" + fechaHoraFin +
                ", horasAproximadas=" + horasAproximadas +
                ", incrementoExtra=" + incrementoExtra +
                '}';
    }
}