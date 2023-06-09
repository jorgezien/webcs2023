package Modelo;

import java.sql.Date;

public class Usuario {
    int id_user;
    String username;
    String password;
    String dni;
    String nombre;
    String apellidos;
    String fecha_alta;
    String fecha_baja;
    String tipo_usuario;

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getFecha_alta() {
        return fecha_alta;
    }

    public void setFecha_alta(String fecha_alta) {
        this.fecha_alta = fecha_alta;
    }

    public String getFecha_baja() {
        return fecha_baja;
    }

    public void setFecha_baja(String fecha_baja) {
        this.fecha_baja = fecha_baja;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

    public Usuario(int id_user, String username, String password, String dni, String nombre, String apellidos, String fecha_alta, String fecha_baja, String tipo_usuario) {
        this.id_user = id_user;
        this.username = username;
        this.password = password;
        this.dni = dni;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.fecha_alta = fecha_alta;
        this.fecha_baja = fecha_baja;
        this.tipo_usuario = tipo_usuario;
    }
    
    
    
    
}
