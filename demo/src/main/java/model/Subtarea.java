package model;

public class Subtarea {
    private String id;
    private String asignacionId;
    private String titulo;
    private String descripcion;
    private boolean completada;

    // Constructor vacío
    public Subtarea() {
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAsignacionId() {
        return asignacionId;
    }

    public void setAsignacionId(String asignacionId) {
        this.asignacionId = asignacionId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean isCompletada() {
        return completada;
    }

    public void setCompletada(boolean completada) {
        this.completada = completada;
    }

    @Override
    public String toString() {
        return "Subtarea{" +
                "id='" + id + '\'' +
                ", asignacionId='" + asignacionId + '\'' +
                ", titulo='" + titulo + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", completada=" + completada +
                '}';
    }
}