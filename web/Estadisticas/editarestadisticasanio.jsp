<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="BL.clsConexion"%>
<%
    Connection conn = null;

    clsConexion obclsConexion = new clsConexion();
    conn = obclsConexion.getConexion();

    HttpSession objsesion = request.getSession(false);
    String id_usuario = (String) objsesion.getAttribute("id_usuario");
    String Descripcion_perfil = (String) objsesion.getAttribute("descripcion_perfil");

    char VistaEstadisticas = 'N';

    List<Modelos.Perfil.clsFiltroPerfil> lstclsFiltroPerfil = new ArrayList<Modelos.Perfil.clsFiltroPerfil>();
    try {
        ResultSet rs = null;
        PreparedStatement ps = conn.prepareStatement("{call spBuscarFiltroPerfil(?)}");
        ps.setString(1, id_usuario);
        rs = ps.executeQuery();

        while (rs.next()) {
            Modelos.Perfil.clsFiltroPerfil obclsFiltroPerfil = new Modelos.Perfil.clsFiltroPerfil();
            obclsFiltroPerfil.setVista_usuarios(rs.getString("Vista_usuarios").charAt(0));
            obclsFiltroPerfil.setVista_perfil(rs.getString("Vista_perfil").charAt(0));
            obclsFiltroPerfil.setVista_tiponovedades(rs.getString("Vista_tiponovedades").charAt(0));
            obclsFiltroPerfil.setVista_facturacion(rs.getString("Vista_facturacion").charAt(0));
            obclsFiltroPerfil.setVista_novedadesempleado(rs.getString("Vista_novedadesempleado").charAt(0));
            obclsFiltroPerfil.setVista_centrocostos(rs.getString("Vista_centrocostos").charAt(0));
            obclsFiltroPerfil.setVista_empleados(rs.getString("Vista_empleados").charAt(0));
            obclsFiltroPerfil.setVista_cargoempleado(rs.getString("Vista_cargoempleado").charAt(0));
            obclsFiltroPerfil.setVista_modulos(rs.getString("Vista_modulos").charAt(0));
            obclsFiltroPerfil.setVista_modulosperfil(rs.getString("Vista_modulosperfil").charAt(0));
            obclsFiltroPerfil.setVista_grupos(rs.getString("Vista_grupos").charAt(0));
            obclsFiltroPerfil.setVista_empleadosgrupo(rs.getString("Vista_empleadosgrupo").charAt(0));
            obclsFiltroPerfil.setVista_responsablegrupo(rs.getString("Vista_responsablegrupo").charAt(0));
            obclsFiltroPerfil.setVista_configuracion(rs.getString("Vista_configuracion").charAt(0));
            obclsFiltroPerfil.setVista_estadisticas(rs.getString("Vista_estadisticas").charAt(0));

            lstclsFiltroPerfil.add(obclsFiltroPerfil);
        }

    } catch (Exception ex) {

    }

    for (Modelos.Perfil.clsFiltroPerfil elem : lstclsFiltroPerfil) {

        VistaEstadisticas = elem.getVista_estadisticas();
    }

    if (id_usuario == null) {
        response.sendRedirect("logear?Login=true");
    } else {
        if (VistaEstadisticas != 'S') {
            response.sendRedirect("nomina.htm");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Editar Año</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="Resources/CSS/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="<c:url value="/Resources/CSS/style.css"/>"/>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="Resources/JS/functions.js"></script>
    </head>
    <body>
        <%
            Modelos.Estadisticas.clsEstadisticas obclsEstadisticas = new Modelos.Estadisticas.clsEstadisticas();

            if (request.getAttribute("obclsEstadisticas") != null) {
                obclsEstadisticas = (Modelos.Estadisticas.clsEstadisticas) request.getAttribute("obclsEstadisticas");
            }

            List<Modelos.Estadisticas.clsEstadisticas> lstclsEstadisticas = new ArrayList<Modelos.Estadisticas.clsEstadisticas>();

            if (request.getAttribute("lstclsEstadisticas") != null) {

                lstclsEstadisticas = (List<Modelos.Estadisticas.clsEstadisticas>) request.getAttribute("lstclsEstadisticas");
            }

            if (request.getAttribute("stMensaje") != null && request.getAttribute("stTipo") != null) {


        %>
        <input type="text" hidden="" id="txtMensaje" value="<%=request.getAttribute("stMensaje")%>"/>
        <input type="text" hidden="" id="txtTipo" value="<%=request.getAttribute("stTipo")%>"/>
        <script>
            var mensaje = document.getElementById("txtMensaje").value;
            var tipo = document.getElementById("txtTipo").value;

            swal.fire("Mensaje", mensaje, tipo);
        </script>
        <%
            }
        %>
        <div>    
            <div class="card border-dark ">

                <div class="card-header background-card border-dark text-white">                    
                    <div class="form-group">
                        <div class="form-group">
                            <div class="col-12 text-center">                                    
                                <h5 class="align-middle mt-1"> 
                                    <b>
                                        <%=obclsEstadisticas.getObEmpleado().getEmplPrimerNombre() != null ? obclsEstadisticas.getObEmpleado().getEmplPrimerNombre() : ""%>
                                        <%=obclsEstadisticas.getObEmpleado().getEmplSegundoNombre() != null ? obclsEstadisticas.getObEmpleado().getEmplSegundoNombre() : ""%>
                                        <%=obclsEstadisticas.getObEmpleado().getEmplPrimerApellido() != null ? obclsEstadisticas.getObEmpleado().getEmplPrimerApellido() : ""%>
                                        <%=obclsEstadisticas.getObEmpleado().getEmplSegundoApellido() != null ? obclsEstadisticas.getObEmpleado().getEmplSegundoApellido() : ""%>
                                    </b>
                                </h5>                                         
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <form action="estadisticas" method="POST">                           
                        <!--FILA 1-->
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-12">
                                    <label for="lblAnio"><b>A&ntilde;o</b></label>
                                    <select class="form-control" name="ddlAnio">
                                        <%
                                            List<Modelos.Estadisticas.clsAnio> lstclsAnio = new ArrayList<Modelos.Estadisticas.clsAnio>();

                                            if (request.getAttribute("lstclsAnio") != null) {
                                                lstclsAnio = (List<Modelos.Estadisticas.clsAnio>) request.getAttribute("lstclsAnio");
                                            }

                                            for (Modelos.Estadisticas.clsAnio elem : lstclsAnio) {
                                        %>
                                        <option value="<%=elem.getId_anio()%>"
                                                <%=obclsEstadisticas.getObAnio()!= null ? obclsEstadisticas.getObAnio().getId_anio()== elem.getId_anio()? "selected" : "" : ""%>>
                                            <%=elem.getNombreAnio()%>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>  
                        </div>                        
                        <!--FILA 11-->   
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-12">
                                    <input type="submit" value="Guardar" class="btn background-button" name="btnEditarEstaAnio"/>
                                    <input type="text" name="IdModificar" id="IdModificar" value="<%=obclsEstadisticas.getId_estadistica()%>" hidden=""/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
