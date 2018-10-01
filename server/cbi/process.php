<?php
	//ConexionBD
	$bd = new MySQLi("localhost", "root", "", "grupos_vida");
	if (mysqli_connect_errno()) { printf("Connect failed: %s\n", mysqli_connect_error()); exit(); }
	//Funciones
	function prepare($theValue, $theType,$bd) 
	{
	  if (PHP_VERSION < 6) {
		$theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
	  }
	
	  $theValue = $bd->real_escape_string($theValue);
	
	  switch ($theType) {
		case "text":
		  $theValue = ($theValue != "") ? "'" . $theValue . "'" : "''";
		  break;    
		case "long":
		case "int":
		  $theValue = ($theValue != "") ? intval($theValue) : "0";
		  break;
		case "double":
		  $theValue = ($theValue != "") ? doubleval($theValue) : "0";
		  break;
		case "date":
		  $theValue = ($theValue != "") ? "'" . $theValue . "'" : " ";
		  break;
	  }
	  return $theValue;
	}
	function Fecha($date,$l='-')
	{
		$d=explode('-',$date);
		switch($d[1])
		{
			case'01':
			$m='Ene';
			break;
			case'02':
			$m='Feb';
			break;
			case'03':
			$m='Mar';
			break;
			case'04':
			$m='Abr';
			break;
			case'05':
			$m='May';
			break;
			case'06':
			$m='Jun';
			break;
			case'07':
			$m='Jul';
			break;
			case'08':
			$m='Ago';
			break;
			case'09':
			$m='Sep';
			break;
			case'10':
			$m='Oct';
			break;
			case'11':
			$m='Nov';
			break;
			case'12':
			$m='Dic';
			break;
		}
		$D=$d[2].$l.$m;
		return $D;
	}
	function Mes($m)
	{
		switch($m)
		{
			case'01':
			$mes='Ene';
			break;
			case'02':
			$mes='Feb';
			break;
			case'03':
			$mes='Mar';
			break;
			case'04':
			$mes='Abr';
			break;
			case'05':
			$mes='May';
			break;
			case'06':
			$mes='Jun';
			break;
			case'07':
			$mes='Jul';
			break;
			case'08':
			$mes='Ago';
			break;
			case'09':
			$mes='Sep';
			break;
			case'10':
			$mes='Oct';
			break;
			case'11':
			$mes='Nov';
			break;
			case'12':
			$mes='Dic';
			break;
		}
		return $mes;
	}
	function Edad($An)
	{
		$Aa=explode("-",date("Y-m-d"));
		$Edad=$Aa[0]-$An[0];
		if($Aa[1]<=$An[1])
		{
			if($Aa[2]<=$An[2])
			{
				$Edad--;
			}
		}
		return $Edad;
	}
?>
<?php
	//var_dump($_GET);
	if(isset($_GET['jsoncallback']) && !empty($_GET['jsoncallback']))
	{
		$array=array();
		//Inicio de Sesion
		if(isset($_GET['user']) && isset($_GET['pass']))
		{
			$user=prepare($_GET['user'],'text',$bd);
			$Pass=sha1($_GET['pass']);
			$pass=prepare($Pass,'text',$bd);
			$res=$bd->query("SELECT * FROM MENTOR_GRUPO WHERE `user`=$user AND `pass`=$pass");
			if($res->num_rows>0)
			{
				$UserData=$res->fetch_assoc();
				$array["IdMentor"]=$UserData['IdMentor'];		
				$array["NameMentor"]=$UserData['NameMentor'];	
				$array["IdGroup"]=$UserData['IdGroup'];	
				$array["modulo"]=$UserData['modulo'];	
				$array["Rta"]='loginOK';
				
			}
			else
			{
				$array["Rta"]='ErrLogin';
			}
		}
		//Creacion de Convertido por Iglesia
		if(isset($_GET['CrearConvetidoMentor']) && !empty($_GET['CrearConvetidoMentor']))
		{
			$array['Rta']='NO';
			$nombre=prepare($_GET['nombre'],'text',$bd);
			$telefono=prepare($_GET['telefono'],'text',$bd);
			$direccion=prepare($_GET['direccion'],'text',$bd);
			$barrio=prepare($_GET['barrio'],'int',$bd);
			$nacimiento=prepare($_GET['cumple'],'date',$bd);
			$grupo=prepare($_GET['IdGroup'],'int',$bd);
			
			$id=100;
			$RSt=$bd->query("SELECT COUNT(`id`) AS TA FROM `asistentes`"); $RWt=$RSt->fetch_assoc();
			$id+=$RWt['TA'];
			
			$bd->query("call NewSoul ($id,$nombre,$telefono,$direccion,$barrio,$grupo,$nacimiento)");

			if($bd->affected_rows>=1)
			{
				$array['Rta']='SI';
				$array['Det']='Asistente Creado Correctamente<br>';
			}
		}
		//Cargar los convertidos que aun no tienen grupo
		if(isset($_GET['ChargeListSeguimiento']) && !empty($_GET['ChargeListSeguimiento']))
		{
			$t='';
			$res=$bd->query("SELECT * FROM `souls` where IdGv=0 order by nombre");
			$id=1;
			while($Row_Souls=$res->fetch_array())
			{
				$C=explode("-", $Row_Souls['nacimiento']);
				$Cu=$C[2].'-'.Mes($C[1]);
				$E=Edad($C);
				$t.='<tr>';
				$t.='<td class="ItemListadoSeg" data-id="'.$id.'">';
				$t.=$Row_Souls['nombre'];
				$t.='<input type="hidden" id="Data-'.$id.'" value="'.$Row_Souls[0].'|'.$Row_Souls['telefono'].'|'.$Row_Souls['direccion'].'|'.$Row_Souls['barrio'].'|'.$Cu.'|'.$E.'|'.$Row_Souls['nombre'].'">';
				$t.='</td>';
				$t.='</tr>';
				$id++;
			}
			$array['tbody']=$t;
		}
		//Carga de los barrios
		if(isset($_GET['ChargeTown']))
		{
			$array['barrios']=array();
			$RS=$bd->query("SELECT CONCAT(`barrio`,'-',`id`) AS nombre FROM barrio ORDER BY barrio");
			while($RW=$RS->fetch_assoc())
			{
				$array['barrios'][]=$RW['nombre'];
			}
		}
		echo $_GET['jsoncallback'].'('.json_encode($array).')';
	}
?>