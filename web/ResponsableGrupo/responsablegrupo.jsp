<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
    HttpSession objsesion = request.getSession(false);
    String id_usuario = (String) objsesion.getAttribute("id_usuario");
    String Descripcion_perfil = (String) objsesion.getAttribute("descripcion_perfil");
    if (id_usuario == null) {
        response.sendRedirect("login.jsp");
    } else {
        if (Descripcion_perfil.equals("COORDINADOR")
                || Descripcion_perfil.equals("JEFE")) {

        } else {
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
        <title>Responsable por Grupo</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="Resources/CSS/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="<c:url value="/Resources/CSS/style.css"/>"/>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.1/css/buttons.dataTables.min.css">
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.6.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.flash.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/1.6.1/js/buttons.print.min.js"></script>
        <script src="https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="Resources/JS/functions.js"></script>
    </head>
    <body>
        <%
            Modelos.ResponsableGrupo.clsResponsableGrupo obclsResponsableGrupo = new Modelos.ResponsableGrupo.clsResponsableGrupo();

            if (request.getAttribute("obclsResponsableGrupo") != null) {
                obclsResponsableGrupo = (Modelos.ResponsableGrupo.clsResponsableGrupo) request.getAttribute("obclsResponsableGrupo");
            }

            List<Modelos.ResponsableGrupo.clsResponsableGrupo> lstclsResponsableGrupo = new ArrayList<Modelos.ResponsableGrupo.clsResponsableGrupo>();

            if (request.getAttribute("lstclsResponsableGrupo") != null) {

                lstclsResponsableGrupo = (List<Modelos.ResponsableGrupo.clsResponsableGrupo>) request.getAttribute("lstclsResponsableGrupo");
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
        <header>
            <%--Barra de Navegación de Jefe--%>
            <%
                if (Descripcion_perfil.equals("JEFE")) {

            %>       

            <jsp:include page="../WEB-INF/jsp/menujefe.jsp"></jsp:include>

            <%        }
            %>


            <%--Barra de Navegación de Coordinador--%>
            <%
                if (Descripcion_perfil.equals("COORDINADOR")) {
            %>

            <jsp:include page="../WEB-INF/jsp/menucordi.jsp"></jsp:include>

            <%
                }
            %> 
        </header>  
        <div class="container mt-4">
            <h1 class="text-center">Responsable por Grupo</h1>
            <br>
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <form action="controlresponsablegrupo" method="post">
                        <div class="input-group">
                            <a href="nomina.htm" class="btn btn-secondary mr-2" data-toggle="tooltip" title="Haz clic para regresar al menú nómina"><i class="fas fa-arrow-left"></i></a>
                            <a href="controlresponsablegrupo?btnReGruAgregar=true" class="btn btn-secondary mr-2" data-toggle="tooltip" title="Haz clic para agregar un nuevo registro" title="Haz clic para agregar un registro" ><i class="fas fa-plus-circle"> <label class="coloriphonex tipoLetraLabel">Agregar</label></i></a>
                        </div>
                    </form>
                </div>
                <div class="card-body">
                    <table class="table table-fluid table table-bordered table-striped table-hover text-center table-responsive-sm" id="myTable">
                        <thead>
                            <tr>
                                <th class="align-middle">Grupo</th>
                                <th class="align-middle">Empleado</th>
                                <th class="align-middle">Usuario</th>
                                <th class="align-middle">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Modelos.ResponsableGrupo.clsResponsableGrupo elem : lstclsResponsableGrupo) {
                            %>
                            <tr>
                                <td class="align-middle"><%=elem.getObclsGrupo().getNombre()%></td>
                                <td class="align-middle">
                                    <%=elem.getObclsUsuario().getEmplPrimerNombre()%>
                                    <%=elem.getObclsUsuario().getEmplSegundoNombre()%>
                                    <%=elem.getObclsUsuario().getEmplPrimerApellido()%>
                                    <%=elem.getObclsUsuario().getEmplSegundoNombre()%>
                                </td>
                                <td class="align-middle"><%=elem.getObclsUsuario().getId_usuario()%></td>
                                <td class="align-middle">
                                    <div class="btn-group">
                                        <a class="btn btn-warning btn-sm mr-1 openBtn rounded" title="Haz clic para editar responsable por grupo" data-toggle="modal" data-target="#myModal" id="btnEmplModificar" 
                                           href="controlresponsablegrupo?stOpcion=M&codigoSeleccionado=<%=elem.getId_responsable()%>">
                                            <i class="fas fa-edit" style="font-size:15px;"></i>
                                        </a>
                                        <a class="btn btn-danger btn-sm openBtn rounded" title="Haz clic para eliminar" data-toggle="modal" data-target="#myModal" id="btnEmplEliminar"
                                           href="controlresponsablegrupo?stOpcion=E&codigoSeleccionado=<%=elem.getId_responsable()%>">
                                            <i class="fas fa-trash-alt" style="font-size:15px;"></i>
                                        </a>
                                    </div>                                
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        <tfoot>
                            <tr>
                                <th class="align-middle">Grupo</th>
                                <th class="align-middle">Empleado</th>
                                <th class="align-middle">Usuario</th>
                                <th class="align-middle">Acciones</th>
                            </tr>
                        </tfoot>
                        </tbody>
                    </table> 
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-lg">

                <!-- Modal content-->
                <div class="modal-content">  
                    <div class="modal-body">

                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript" language="JavaScript">
        main();
    </script>
</html>







