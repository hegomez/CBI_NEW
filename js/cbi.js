"use strict";

//Declaración de variables
var archivoValidacion = "http://192.168.1.66/cbi/process.php?jsoncallback=?";
var IdMentor, IdGroup, NameMentor, uID, IdAsist=1, TotalAsist, i, PosSegConv, url,DataUser,OPT,aBARRIOS;

//Funciones

var i_log = 0;
function mkLog(text)
{
	var txt = "log HG (" + i_log + ") -> " + text;
	i_log++;
	console.log(txt);
	//$("#RecLog").html('<p>' + txt + '</p>');
}

function CargarBarrios()
{
	$.getJSON( archivoValidacion, { ChargeTown:'SET'})
	.done(function(D) {
		aBARRIOS=D.barrios;
	});
}

function Msg1(txt='')
{
	$(".msgPopUp1").text(txt);
	$("#popupLoginMsg").popup( "open" );
}
function Cargando(txt='Cargando...')
{
	$.mobile.loading( "show", {
		text: txt,
		textVisible: true
	});
}

function onBodyLoad(){
	document.addEventListener("deviceready", onDeviceReady, false);
	CargarBarrios();
}
function onDeviceReady(){
	uID = device.uuid;
}

function CargarOpciones(Modulos)
{
	var Cnt='',f;
	mkLog("Cargar los modulos de : " + Modulos);
	if(Modulos==1)
	{
		mkLog("Seleccionado Modulo de Mentores NRO");
		OPT=['convertidos','asistentes','asistencias','seguimiento'];
		f=4;
		mkLog(OPT);
	}

	/*var Cnt='',f;
	/*switch(Modulos)
	{
		case 1:
			
			$("#MenuOpt").append("<h1>Cnt</h1>");
			f=4;
		break;
	}*/
	$(".MenuOpciones").html('');
	for(i=0;i<f;i++)
	{
		mkLog(i);
		Cnt = Cnt + '<li><a href="#" id="opt-' + OPT[i] + '">';
		Cnt = Cnt + '<img src="img/' + OPT[i] + '.png" alt="" title=""><span>' + OPT[i] + '</span>';
		Cnt = Cnt + '</a></li>';
	}
	mkLog(Cnt);
	$(".MenuOpciones").append(Cnt);
}

//Inicio de Sesion
$(document).on("click","#btnLogin",function(){
	if($("#txtUserName").val()=='' || $("#txtUserPass").val()=='')
	{
		$(".msgPopUp1").text("Error, Todos los datos son necesarios");
		$("#popupLoginMsg").popup( "open" );
	}
	else
	{
		mkLog(archivoValidacion);
		Cargando();
		var user=$("#txtUserName").val();
		var pass=$("#txtUserPass").val();
		var LoginPrc='set';
		$.getJSON( archivoValidacion, { LoginPrc:LoginPrc,user:user,pass:pass})
		.done(function(D) {
			$.mobile.loading( "hide" );
			if(D.Rta=='ErrLogin')
			{
				$(".msgPopUp1").text("Error, Usuario o Contraseña Errados");
				$("#popupLoginMsg").popup( "open" );
			}
			if(D.Rta=='ErrSrchUser')
			{
				$(".msgPopUp1").text("Error al buscar Usuario en Tabla, Comuniquese con un Administrador");
				$("#popupLoginMsg").popup( "open" );
			}
			if(D.Rta=='ErrSrchUser')
			{
				$(".msgPopUp1").text("Error al buscar Usuario en Tabla, Comuniquese con un Administrador");
				$("#popupLoginMsg").popup( "open" );
			}
			if(D.Rta=='loginOK')
			{
				//Verificar si la sesion existe
				//DataUser=window.localStorage.getItem("DataUser");
				window.localStorage.clear();
				window.localStorage.setItem('IdMentor',D.IdMentor);
				window.localStorage.setItem('NameMentor',D.NameMentor);
				window.localStorage.setItem('IdGroup',D.IdGroup);
				window.localStorage.setItem('modulo',D.modulo);
				//Cargamos el Mudulo de Mentores
				$.mobile.changePage('#MainPrc', { transition: "slideup"});
				var modulos = window.localStorage.getItem('modulo');
				mkLog(modulos);
				CargarOpciones(modulos);
			}
		});
	}
});

//Opiones de los Botones de Mentor
$(document).on("click","#opt-convertidos",function(){
	$("#txtBarrioCnv").autocomplete({
		source: aBARRIOS
		});
	$("#ConvertidosMentor").popup("open",{transition:"pop"});
});


$(document).on("click","#opt-asistentes",function(){
	//Cargar los asistentes desde la bd
	IdGroup=window.localStorage.getItem("IdGroup");
	$.getJSON( archivoValidacion, { ChargeAsistentes:'SET',IdGroup:IdGroup})
	.done(function(D) {
		$("#tblDatosAsistenesGV tbody").html('');
		var C='';
		for(i=0;i<D.F;i++)
		{
			C = C + '<tr>';
			C = C + '<td>' + D.DATA[i].nombre + '</td>';
			C = C + '<td><a ';
			C = C + 'id="ViewAsist_' + (i+1) + '" ';
			C = C + 'data-id="' + (i+1) + '" ';
			C = C + 'data-nombre="'+D.DATA[i].nombre+'" ';
			C = C + 'data-telefono="'+D.DATA[i].telefono+'" ';
			C = C + 'data-direccion="'+D.DATA[i].direccion+'" ';
			C = C + 'data-barrio="'+D.DATA[i].barrio+'" ';
			C = C + 'data-edad="'+D.DATA[i].edad+'" ';
			C = C + 'data-cumple="'+D.DATA[i].cumple+'" ';
			C = C + ' href="#" class="chargeAsistenteS btn"><i class="far fa-eye"></i></a></td>';
			C = C + '</tr>';
		}
		
		TotalAsist=D.F;
		
		$("#tblDatosAsistenesGV tbody").append(C);
		$.mobile.changePage("#AsistentesProc",{
 			transition: "pop"
		});
		
		/*$.mobile.changePage("#AsistentesProc",{
			role: "dialog",
 			transition: "slidedown"
		});*/
	});
});

$(document).on("click",".chargeAsistenteS",function(){
	IdAsist=$(this).attr('data-id');
	$("#ViewAsisNom").text($(this).attr("data-nombre"));
	$("#ViewAsisTel").text($(this).attr("data-telefono"));
	$("#ViewAsisDir").text($(this).attr("data-direccion"));
	$("#ViewAsisBar").text($(this).attr("data-barrio"));
	$("#ViewAsisEda").text($(this).attr("data-edad")+' Años');
	$("#ViewAsisCum").text($(this).attr("data-cumple"));

	$.mobile.changePage("#dlgAsistentes",{
		role: "dialog",
		transition: "slidedown"
	});

});

$(document).on("click","#AsistPrev",function(){
	if(IdAsist>1)
	{
		IdAsist--;
		$("#ViewAsisNom").text($("#ViewAsist_"+IdAsist).attr("data-nombre"));
		$("#ViewAsisTel").text($("#ViewAsist_"+IdAsist).attr("data-telefono"));
		$("#ViewAsisDir").text($("#ViewAsist_"+IdAsist).attr("data-direccion"));
		$("#ViewAsisBar").text($("#ViewAsist_"+IdAsist).attr("data-barrio"));
		$("#ViewAsisEda").text($("#ViewAsist_"+IdAsist).attr("data-edad")+' Años');
		$("#ViewAsisCum").text($("#ViewAsist_"+IdAsist).attr("data-cumple"));
	}
});

$(document).on("click","#AsistNext",function(){
	if(IdAsist<TotalAsist)
	{
		IdAsist++;
		$("#ViewAsisNom").text($("#ViewAsist_"+IdAsist).attr("data-nombre"));
		$("#ViewAsisTel").text($("#ViewAsist_"+IdAsist).attr("data-telefono"));
		$("#ViewAsisDir").text($("#ViewAsist_"+IdAsist).attr("data-direccion"));
		$("#ViewAsisBar").text($("#ViewAsist_"+IdAsist).attr("data-barrio"));
		$("#ViewAsisEda").text($("#ViewAsist_"+IdAsist).attr("data-edad")+' Años');
		$("#ViewAsisCum").text($("#ViewAsist_"+IdAsist).attr("data-cumple"));
	}
});

//Intento de llamada numero 1

$(document).on("click","#AsistCall",function(){
	document.location.href = 'tel:+1-800-555-1234';
});
//Creacion de Convertido Consolidacion
$(document).on("click","#btnAddConvertidoMentor",function(){
	var nombre=$("#txtNombreCnv").val();
	var telefono=$("#txtTelCnv").val();
	var direccion=$("#txtDirCnv").val();
	var barrio=$("#txtBarrioCnv").val();
	var cumple=$("#txtNacCnv").val();
	if(nombre=="" || direccion=="" || barrio=="" || cumple=="" || telefono=="")
	{
		$("#popupConsoMsg1 .msg-urgene").text( "Todos los Datos son Necesarios" );
		$("#popupConsoMsg1 .msg-info").html("");
		$("#popupConsoMsg1").popup( "open" );
	}
	else
	{
		var CrearConvetidoMentor='OK';
		IdGroup=window.localStorage.getItem("IdGroup");
		
		var idB=barrio.split('-');
		
		$.getJSON( archivoValidacion, { CrearConvetidoMentor:CrearConvetidoMentor,IdGroup:IdGroup,nombre:nombre,direccion:direccion,barrio:idB[1],telefono:telefono,cumple:cumple})
		.done(function(D) {
			if(D.Rta=='SI')
			{
				$("#ConvertidosMentor").popup( "close" );
				setTimeout(function(){
					$("#popupConsoMsg1 .msg-info").html("");
					$("#popupConsoMsg1 .msg-urgene").text("");
					$("#popupConsoMsg1 .msg-info").html(D.Det);
					$("#popupConsoMsg1").popup( "open" );
					$("#txtNombreCnv").val('');
					$("#txtTelCnv").val('');
					$("#txtDirCnv").val('');
					$("#txtBarrioCnv").val('');
					$("#txtNacCnv").val('');
				}, 250);
			}
			else
			{
				$("#popupConsoMsg1 .msg-urgene").text("Error al Procesar Datos");
				$("#popupConsoMsg1 .msg-info").html("");
				$("#popupConsoMsg1").popup( "open" );
			}
		});	
	}
});

//Cargar los Seguimientos de Convertidos 
$(document).on("click","#menuseguimientoConsol",function(){
	$.mobile.loading( "show", {
		text: "Cargando...",
		textVisible: true
	});
	var ChargeListSeguimiento='OK';
	$.getJSON( archivoValidacion, { ChargeListSeguimiento:ChargeListSeguimiento })
	.done(function(D) {
		$("#tblListadoSeguimientos tbody").html('');
		$("#tblListadoSeguimientos tbody").append(D.tbody);
	});
	$.mobile.loading( "hide" );
	$.mobile.changePage("#seguimiento-consol");
});

//Cargar los datos de un Convertido Para Seguimiento
$(document).on("click",".ItemListadoSeg",function(){
	$.mobile.loading( "show", {
		text: "Cargando...",
		textVisible: true
	});
	PosSegConv=$(this).attr('data-id');
	var Dt=$("#Data-"+PosSegConv).val().split("|");

	$("#NameAsist").val(Dt[6]);
	var CallTel="tel:"+Dt[1];
	$(".AccessToCall").attr("href", CallTel);
	$("#TelAsist").val(Dt[1]);
	$("#DirAsist").val(Dt[2]);
	$("#BarrioAsist").val(Dt[3]);
	$("#AgeAsist").val(Dt[5]);
	$("#NacAsist").val(Dt[4]);
	$("#txtIdCnv").attr('data-id',PosSegConv);
	$("#txtIdCnv").attr('data-id-bd',Dt[0]);

	$.mobile.loading( "hide" );
	$.mobile.changePage("#dlgDatosAsistente");
});

//Carga del convertido anterior
$(document).on("click","#at-cnv",function(){
	if(PosSegConv>1)
	{
		PosSegConv--;
		var Dt=$("#Data-"+PosSegConv).val().split("|");

		$("#NameAsist").val(Dt[6]);
		var CallTel="tel:"+Dt[1];
		$(".AccessToCall").attr("href", CallTel);
		$("#TelAsist").val(Dt[1]);
		$("#DirAsist").val(Dt[2]);
		$("#BarrioAsist").val(Dt[3]);
		$("#AgeAsist").val(Dt[5]);
		$("#NacAsist").val(Dt[4]);
		$("#txtIdCnv").attr('data-id',PosSegConv);
		$("#txtIdCnv").attr('data-id-bd',Dt[0]);
	}
});

//Carga del convertido siguiente
$(document).on("click","#ad-cnv",function(){
	var CntMax=$(".ItemListadoSeg").length;
	if(PosSegConv<CntMax)
	{
		PosSegConv++;
		var Dt=$("#Data-"+PosSegConv).val().split("|");

		$("#NameAsist").val(Dt[6]);
		var CallTel="tel:"+Dt[1];
		$(".AccessToCall").attr("href", CallTel);
		$("#TelAsist").val(Dt[1]);
		$("#DirAsist").val(Dt[2]);
		$("#BarrioAsist").val(Dt[3]);
		$("#AgeAsist").val(Dt[5]);
		$("#NacAsist").val(Dt[4]);
		$("#txtIdCnv").attr('data-id',PosSegConv);
		$("#txtIdCnv").attr('data-id-bd',Dt[0]);
	}
});

//Agregar el detalle del seguimiento
$(document).on("click","#btnAddSegConsol",function(){
	var idBd=$("#txtIdCnv").attr('data-id-bd');
	var id=$("#txtIdCnv").attr('data-id');
	var txtDetalleSeg=$("#txtDetalleSeg").val();
	alert($("#SegAlert").val());
});