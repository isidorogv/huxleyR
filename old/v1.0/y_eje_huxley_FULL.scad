M6 = 3.1;		// Radio para barras M6
HUX_Y = 270;	// Longitud barras lisas eje Y de la Huxley.
d = 0;			// Distancia desplazada.
HUX_BED = 140;	// Ancho y largo de la bandeja de la huxley.
M3 = 1.6;		// Radio tornillos M3
M3_nut = 3.1;	// Radio tuerca M3
NEMA14 = 34;	// ancho y alto del NEMA 14 de la huxley.
ancho_pata=12;  // ancho de la pata del eje Y
redondez=3;     // radio de redondez de las esquinas en mm


module base(){
color("pink"){
	// bisel izquierdo
	difference(){
		cube([10,HUX_Y+10,10]);
	
		translate([0,-5,0])rotate([0,-45,0])cube([20,300,20]);
	}
	// bisel derecho
	translate([HUX_BED+10,0,10])rotate([0,90,0])difference(){
		cube([10,HUX_Y+10,10]);
	
		translate([0,-5,0])rotate([0,-45,0])cube([20,300,20]);
	}
	// base
	translate([10,10,0])cube([HUX_BED,HUX_Y-10,10]);
	}
}


module barras_lisas(){
	color("grey"){
		rotate([-90,0,0])cylinder(h=HUX_Y, r=M6, $fn=50);
		translate([105,0,0])rotate([-90,0,0])cylinder(h=HUX_Y, r=M6, $fn=50);
	}
}


module hot_bed(){
	// aluminio
	cube([140,140,3]);
	// pcb
	color("red"){
		translate([0,0,3])cube([HUX_BED,HUX_BED,2]);	// circuito impreso
		translate([-10,44,3])cube([10,52,2]);	// orejeta izquierda
		translate([HUX_BED,44,3])cube([16,52,2]);	// orejeta derecha
	}
	// contrachapado
	translate([0,0,5])cube([HUX_BED,HUX_BED,3]);
	// porta-rodamientos
	color("orange"){
		translate([9,23,-20])cube([16,95,20]);
		translate([114,23,-20])cube([16,95,20]);
	}
	// frog
	color("lightgreen")translate([3.5,44,-22])cube([133,52,5]);
	// enganches (belt holders)
	translate([72,46,-27])color("cyan"){
		cube([25,10,5]);
		translate([0,38,0])cube([25,10,5]);
	}
}


module pletina(){
	hull(){
		translate([10,0,0])cube([HUX_BED,10,32]);
		translate([13,0,32])rotate([-90,0,0])cylinder(h=10, r=3, $fn=30);
		translate([HUX_BED+7,0,32])rotate([-90,0,0])cylinder(h=10, r=3, $fn=30);
	}
}

module nema14(){
	// cuerpo
	color("black")cube([36,34,34]);
	// collar
	color("grey"){
		rotate([0,90,0])translate([-17,17,36])cylinder(h=1, r=11, $fn=80);
		// eje
		rotate([0,90,0])translate([-17,17,-10])cylinder(h=66, r=2.5, $fn=30);
		// polea
		rotate([0,90,0])translate([-17,17,38])cylinder(h=16, r=8, $fn=30);
	}
}


module correa(){
	color("lightblue")rotate([0,90,0]){
		hull(){
		cylinder(h=5, r=9, $fn=30);
		//translate([-9,0,0])cube([18,HUX_Y-40,5]);
		translate([0,HUX_Y-40,0])cylinder(h=5, r=9, $fn=30);
		}
	}
}


module portamotor(espesor){

difference(){
	union(){
	translate([0,10,0])difference(){
			union(){
				difference(){
				// proforma
				translate([-4,-4,0])cube([NEMA14,NEMA14,espesor]);
		
				union(){
					// taladros para tornillos
					translate([0,0,-5])cylinder(h=35, r=1.6, $fn=30);
					translate([26,0,-5])cylinder(h=35, r=1.6, $fn=30);
					translate([0,26,-5])cylinder(h=35, r=1.6, $fn=30);
					//translate([26,26,-5])cylinder(h=35, r=1.6, $fn=30);
					// muesca lateral
					translate([6,6,-10])cube([30,50,35]);
					//translate([6,-6,-10])cube([30,50,35]);
				}
			}
			// extremos redondeados
			translate([5.5,26.36,0])cylinder(h=espesor, r=3.65, $fn=50);
			translate([5.9,-0.358,0])cylinder(h=espesor, r=3.65, $fn=50);
			translate([26.36,5.5,0])cylinder(h=espesor, r=3.65, $fn=50);
		}
			// hueco central
			translate([13,13,-2])cylinder(h=30, r=12, $fn=60);
	}

	difference(){
			hull(){
				translate([-14,-4,0])cube([10.5,NEMA14,espesor]);
				translate([-16,-2,0])cylinder(h=espesor, r=2, $fn=30);
				translate([-16,NEMA14-6,0])cylinder(h=espesor, r=2, $fn=30);
			}
			// barras roscadas laterales
			translate([-12,5,0])union(){
				translate([0,0,-10])cylinder(h=30, r=M6, $fn=50);
				translate([0,15,-10])cylinder(h=30, r=M6, $fn=50);
			}
	}
	// Vertices redondeados
	translate([-13.9,39.9,0])rotate([0,0,-90])difference(){
	
			cube([10,10,espesor]);
			translate([0,0,-5])cylinder(h=espesor+10, r=10, $fn=50);
		}
	translate([5.9,-3.9,0])rotate([0,0,90])difference(){
	
			cube([10,10,espesor]);
			translate([0,0,-5])cylinder(h=espesor+10, r=10, $fn=50);
		}
	}
translate([0,35.1,-2])rotate([0,0,90])difference(){

		translate([0,-0.25,0])cube([5,5,espesor+4]);
		translate([0,0,-5])cylinder(h=espesor+10, r=5, $fn=50);
	}
translate([-8.2,1,-2])rotate([0,0,-90])difference(){

		translate([0.15,-0.25,0])cube([5,5,espesor+4]);
		translate([0,0,-5])cylinder(h=espesor+10, r=5, $fn=50);
	}

translate([25.1,10.9,-2])rotate([0,0,-90])difference(){

		cube([5,5,espesor+4]);
		translate([0,0,-5])cylinder(h=espesor+10, r=5, $fn=50);
	}
}
}


module contrapunto_correa(espesor){
	// Y belt holder for 623ZZ bearing
	difference(){
		union(){
			difference(){
				hull(){
					translate([20,3,0])cylinder(h=espesor+5, r=2, $fn=30);
					translate([20,-3,0])cylinder(h=espesor+5, r=2, $fn=30);
					translate([0,0,0])cylinder(h=espesor+5, r=5, $fn=90);
				}	
				// barra roscada lateral
				translate([16,0,0])union(){
					translate([0,0,-1])cylinder(h=30, r=M6, $fn=50);
					translate([-34,-20,(espesor+5-6)/2])cube([25,50,6]);
					translate([-6,-12,((espesor+5-6)/2)-25])cube([25,25,25]);	
					translate([-6,-12,((espesor+5-6)/2)+6])cube([25,25,25]);	
				}
			}
			translate([0,0,(espesor+5-6)/2])cylinder(h=1, r1=4, r2=3, $fn=30);
			translate([0,0,((espesor+5-6)/2)+5])cylinder(h=1, r1=3, r2=4, $fn=30);
			}
		// eje del rodamiento
		translate([0,0,-1])cylinder(h=25, r=1.6, $fn=30);
	}
}


// -------- Patas al estilo Prusa i3 ---------

/*
ancho_pata = anchura de la pata de forma cuadrada
alto_pata = altura de la pata
redondez = radio de la esquina redondeada
espesor = altura de la presilla superior de amarre 
*/

h_nut_M3 = 3;


module pata(ancho_pata,alto_pata,redondez){
	difference(){
		hull(){
			cylinder(h=alto_pata, r=redondez/2, $fn=10*redondez);
			translate([0,ancho_pata-redondez,0])cylinder(h=alto_pata, r=redondez/2, $fn=10*redondez);
			translate([ancho_pata-redondez,ancho_pata-redondez,0])cylinder(h=alto_pata, r=redondez/2, $fn=10*redondez);
			translate([ancho_pata-redondez,0,0])cylinder(h=alto_pata, r=redondez/2, $fn=10*redondez);
			cube([ancho_pata-redondez,ancho_pata-redondez,alto_pata]);
		}
		union(){
			// hueco para la barra lisa
			translate([(ancho_pata-redondez)/2,(ancho_pata-2*redondez)/2,alto_pata])rotate([-90,0,0])cylinder(h=100, r=3.1, $fn=50);
			// barras roscadas laterales
			translate([0,0,-2])union(){
			translate([-50,(ancho_pata-redondez)/2,(alto_pata-ancho_pata)/2])rotate([0,90,0])cylinder(h=100, r=M6, $fn=50);
			translate([-50,(ancho_pata-redondez)/2,(alto_pata-ancho_pata)/2+15])rotate([0,90,0])cylinder(h=100, r=M6, $fn=50);
			#translate([(ancho_pata-redondez)/2,50,((alto_pata-ancho_pata)/2)+7.5])rotate([90,0,0])cylinder(h=100, r=M6, $fn=50);
			}
			// tornillos superiores
			union(){
			translate([1,(ancho_pata-redondez)/2,alto_pata-6])cylinder(h=15, r=M3, $fn=20*M3);
			translate([1,(ancho_pata-redondez)/2,alto_pata-6])rotate([0,0,90])cylinder(h=h_nut_M3, r=M3_nut, $fn=6);
			translate([-9,((ancho_pata-redondez)/2)-M3_nut,alto_pata-6])cube([10,2*M3_nut,h_nut_M3]);
			
			translate([ancho_pata-redondez-1,(ancho_pata-redondez)/2,alto_pata-6])cylinder(h=15, r=M3, $fn=20*M3);
			translate([ancho_pata-redondez-1,(ancho_pata-redondez)/2,alto_pata-6])rotate([0,0,90])cylinder(h=h_nut_M3, r=M3_nut, $fn=6);
			translate([ancho_pata-redondez-1,((ancho_pata-redondez)/2)-M3_nut,alto_pata-6])cube([10,2*M3_nut,h_nut_M3]);
			}
		}
	}
}


module presilla_pata(ancho_pata,redondez,espesor){

	difference(){
		hull(){
			cylinder(h=espesor, r=redondez/2, $fn=10*redondez);
			translate([0,ancho_pata-redondez,0])cylinder(h=espesor, r=redondez/2, $fn=30);
			translate([ancho_pata-redondez,ancho_pata-redondez,0])cylinder(h=espesor, r=redondez/2, $fn=30);
			translate([ancho_pata-redondez,0,0])cylinder(h=espesor, r=redondez/2, $fn=30);
			cube([ancho_pata-redondez,ancho_pata-redondez,espesor]);
		}			
		union(){
			// hueco para la barra lisa
			translate([(ancho_pata-redondez)/2,(ancho_pata-2*redondez)/2,espesor])rotate([-90,0,0])cylinder(h=20, r=M6, $fn=20*M6);
			// tornillos superiores
			translate([1,(ancho_pata-redondez)/2,-2])cylinder(h=1.5*espesor, r=M3, $fn=20*M3);			
			translate([ancho_pata-redondez-1,(ancho_pata-redondez)/2,-2])cylinder(h=1.5*espesor, r=M3, $fn=20*M3);
		}
	}
}

vano_marco = 195;		// Espacio por el pasa el carro Y
ancho_perfil = 40;		// ancho del perfil de alumino usado
fondo_perfil = 20;		// espesor del perfil ranurado de aluminio
travesal = 20;			// barra de aluminio transversal que una la estructura
HUX_Z = 235;			// largo de varilla lisa del eje Z


module marco(){

// perfil lateral + motor + varillas
color("lightgrey")cube([ancho_perfil,fondo_perfil,270]);
translate([NEMA14+(ancho_perfil-NEMA14)/2,-NEMA14-5,12])rotate([0,-90,0])nema14();
translate([ancho_perfil/2,-(NEMA14/2)-5,66])cylinder(h=HUX_Z-20, r=2.5, $fn=30);
translate([ancho_perfil/2-25,-(NEMA14/2)-5,46])cylinder(h=HUX_Z, r=M6, $fn=30);

// perfil lateral derecho + motor
translate([vano_marco+ancho_perfil,0,0]){
color("lightgrey")cube([ancho_perfil,fondo_perfil,270]);
translate([NEMA14+(ancho_perfil-NEMA14)/2,-NEMA14-5,12])rotate([0,-90,0])nema14();
translate([ancho_perfil/2,-(NEMA14/2)-5,66])cylinder(h=HUX_Z-20, r=2.5, $fn=30);
translate([ancho_perfil/2+25,-(NEMA14/2)-5,46])cylinder(h=HUX_Z, r=M6, $fn=30);
}

// barra transversal que da rigidez al conjunto
color("lightgrey")translate([ancho_perfil,0,270-travesal])cube([vano_marco,travesal,travesal]);


}

// Eje Y completo - Whole Y axis

//base();
translate([10,0,46]){
	translate([17,5,-9.5])barras_lisas();
	translate([0,d,0])hot_bed();
}
//pletina();
//translate([0,HUX_Y,0])pletina();
translate([48,10,0.5])nema14();
translate([90,27,17.5])correa();

//color("orange")translate([84,18.5,5.5])rotate([90,0,90])portamotor(10);

//color("orange")translate([100,HUX_Y-18,13])rotate([-90,0,90])contrapunto_correa(10);

translate([20.5,0,0]){
	pata(18,42,6);

	translate([105,0,0])pata();
	translate([ancho_pata-redondez,0,0]){
	translate([0,HUX_Y+10,0])rotate([0,0,180])pata();
	translate([105,HUX_Y+10,0])rotate([0,0,180])pata();
	}
}
presilla_pata(18,6,6);

translate([-55,160,0])marco();

color("black")translate([0,160,0])cube([10,320,10]);

//pata(18,42,6);
//translate([30,0,0])presilla_pata(18,6,6);
