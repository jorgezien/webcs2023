package Modelo;

import java.sql.Date;

public class Marcaje {
    int id;
    Date fecha;
    char tipo_marcaje;
    int id_usuario;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public char getTipo_marcaje() {
        return tipo_marcaje;
    }

    public void setTipo_marcaje(char tipo_marcaje) {
        this.tipo_marcaje = tipo_marcaje;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public Marcaje(int id, Date fecha, char tipo_marcaje, int id_usuario) {
        this.id = id;
        this.fecha = fecha;
        this.tipo_marcaje = tipo_marcaje;
        this.id_usuario = id_usuario;
    }
    
    
}
