var tabla;

//Función que se ejecuta al inicio
function init() {
    listar();
    //Cargamos los items al select cliente
    $.post("../ajax/venta.php?op=selectCliente", function(r) {
        $("#idcliente").html(r);
        $('#idcliente').selectpicker('refresh');
    });
}


//Función Listar
function listar() {
    var fecha_inicio = $("#fecha_inicio").val();
    var fecha_fin = $("#fecha_fin").val();
    var idcliente = $("#idcliente").val();

    tabla = $('#tbllistado').dataTable({
        "aProcessing": true, //Activamos el procesamiento del datatables
        "aServerSide": true, //Paginación y filtrado realizados por el servidor
        dom: 'Bfrtip', //Definimos los elementos del control de tabla
        buttons: [
            //'copyHtml5',
            'excelHtml5',
            //'csvHtml5',
            'pdf'
        ],
        "ajax": {
            url: '../ajax/consultas.php?op=ventasfechacliente',
            data: { fecha_inicio: fecha_inicio, fecha_fin: fecha_fin, idcliente: idcliente },
            type: "get",
            dataType: "json",
            error: function(e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLength": 5, //Paginación
        "order": [
                [0, "desc"]
            ] //Ordenar (columna,orden)
    }).DataTable();
}


init();