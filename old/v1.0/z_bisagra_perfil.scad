anchop = 44;	// anchura del perfil
fondop = 22;	// fondo del perfil
altop = 20;		// altura del hueco donde va encajado el perfil
pared = 6;		// espesor de la pared del hueco
hbase = 10;		// altura de la base de fijación
abase = 7;		// anchura de la base respecto del borde externo del hueco
NEMA14 = 34;	// ancho y alto del NEMA 14 de la huxley.
espesor = 7;
lanclaje = 115;	// largo de la base de anclaje


// pieza inicial a partir de la que se hace el resto de partes
module proforma(altura, ancho, fondo, pared=2.7){
	difference(){
		union(){
			hull(){
				translate([0,0,0])cylinder(h=altura, r=pared, $fn=90);
				translate([ancho,0,0])cylinder(h=altura, r=pared, $fn=90);
				translate([ancho,fondo,0])cylinder(h=altura, r=pared, $fn=90);
				translate([0,fondo,0])cylinder(h=altura, r=pared, $fn=90);
			}
		}
		// hueco del perfil de alumino ranurado a usar
		translate([-0.1,-0.1,-1])cube([ancho+0.2,fondo+0.2,altura+2]);
	}
}


// lugar donde se encajan los perfiles de alumino
module anclaje(){

	hull(){
		translate([-abase,-abase,0])cylinder(h=hbase, r=3, $fn=60);
		translate([lanclaje+abase,-abase,0])cylinder(h=hbase, r=3, $fn=60);
		translate([lanclaje+abase,fondop+abase,0])
			cylinder(h=hbase, r=3, $fn=60);
		translate([-abase,fondop+abase,0])cylinder(h=hbase, r=3, $fn=60);
	}
	// para amarrar una cadena portacables
	translate([70,30,0])hull(){
		cylinder(h=hbase, r=8, $fn=90);
		translate([0,5,0])cylinder(h=hbase, r=8, $fn=90);
	}
}


// una bisagra sobre la que pivota el marco de alumino
// igual para la parte superior e inferior de la bisagra
module bisagra(altura,anchura){	
		translate([0,-1.5,0])difference(){
			union(){
				cylinder(h=anchura, r=5, $fn=50);
				translate([0,-5,0])cube([altura,10,anchura]);
			}		
			translate([0,0,-1])cylinder(h=anchura+2, r=1.6, $fn=30);
			translate([0,0,-2])cylinder(h=5, r=3.16, $fn=6);
		}
}


// para amarrar el eje Y al marco de alumino
module amarra(){

	color("orange")translate([-5,0,0])difference(){
		translate([-35-abase,-abase,hbase])cube([20,fondop+2*abase,17.5-hbase]);
		translate([0,0,-1])union(){
		translate([-35,-8,18.5])cube([6.1,fondop+2*abase+2,10]);
		translate([-32,fondop+abase+1,18])rotate([90,0,0])cylinder(h=fondop+2*abase+2, r=3.05, $fn=60);
		// esquinas redondeadas	
		/*translate([-25,-10,15.5])difference(){
			cube([5,50,5]);
			translate([0,-3,0])rotate([-90,0,0])cylinder(h=55, r=3, $fn=50);
			}*/
		translate([-39,-10,15.5])rotate([0,-90,0])difference(){
			cube([5,50,5]);
			translate([0,-3,0])rotate([-90,0,0])cylinder(h=55, r=3, $fn=50);
			}
		}
	}
	color("red"){
		translate([-23.55,5,17.45])rotate([0,90,90])
			bisagra(altura=17.5-hbase, anchura=(fondop+2*abase)/3);
	}
}


module presilla_eje_y(){

	difference(){
		color("pink")union(){
			translate([-45-abase,-abase,17.5])
				cube([25,fondop+2*abase,5]);
			translate([-23.5,5,17.5])rotate([90,-90,0])
				bisagra(altura=5, anchura=(fondop+2*abase)/3);
			translate([-23.5,29,17.5])rotate([90,-90,0])
				bisagra(altura=5, anchura=(fondop+2*abase)/3);
	
			difference(){
				hull(){
					translate([-45-abase,-abase,hbase])
						cube([10,fondop+2*abase,22.5-hbase]);
					translate([-50-abase,(fondop)/2,hbase])
						cylinder(h=22.5-hbase, r=10, $fn=80);
				}
				translate([-44,-10,14.5])hull(){
					translate([-3,-3,-5])cube([15,50,1]);
					translate([12,-3,-5])cube([1,50,8]);
					translate([0,-3,0])rotate([-90,0,0])
						cylinder(h=50, r=3, $fn=50);
				}
			}
		}
		// muesca para la varilla roscada
		translate([-37,fondop+abase+1,16.75])rotate([90,0,0])
			cylinder(h=fondop+2*abase+2, r=3.05, $fn=60);
		// hueco para el tornillo fijador M5 de cabeza hexagonal
		translate([-50-abase,(fondop)/2,-hbase])
			cylinder(h=50, r=2.5, $fn=80);
		// rebaje para la ruleta de apriete del tornillo fijador M5
		translate([-50-abase,(fondop)/2,hbase+8])
			cylinder(h=10, r=13.5, $fn=120);
	}
}


module rosca_presilla_eje_y(altura=5, radio=12, paso=15, metrica=5){

color("orange")difference(){
	union(){
		cylinder(h=altura/2, r=radio, $fn=radio*10);
		translate([0,0,altura/2])
			cylinder(h=altura/2, r1=radio, r2=radio-(radio*0.25), $fn=90);
	}
	if (metrica == 3){
		translate([0,0,-1])cylinder(h=4, r=3.2, $fn=6);
	}else
		{
		translate([0,0,-1])cylinder(h=4, r=4.6, $fn=6);
		}
	translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
for (ang=[0:paso:360]){
	rotate([0,0,ang])translate([radio,0,0])
		cylinder(h=altura/2, r=1.5, $fn=60);
	}
}


// para estabilidad del marco con los perfiles
module peana(alto=25){
	union(){
	difference(){
		union(){
			proforma(altura=alto, ancho=anchop, fondo=fondop, pared=2.5); 
			difference(){
				color("lightblue")anclaje();
				// vano central
				translate([51,1,0])hull(){
					translate([0,0,-2])cylinder(h=15, r=3, $fn=30);
					translate([15,0,-2])cylinder(h=15, r=3, $fn=30);
					translate([0,20,-2])cylinder(h=15, r=3, $fn=30);
					translate([15,20,-2])cylinder(h=15, r=3, $fn=30);
				}
				// hueco para el tornillo fijador M5...
				translate([76,(fondop)/2,-2])
					cylinder(h=50, r=2.5, $fn=80);
				// ... y la tuerca.
				translate([76,(fondop)/2,-1])
					cylinder(h=7, r=4.6, $fn=6); // hueco para tuerca M5.
				// bocado en los extremos de la peana
				translate([-22,fondop/2,-2])cylinder(h=15, r=20, $fn=200);
				//translate([128,fondop/2,-2])cylinder(h=15, r=20, $fn=200);
			}
		}
		// hueco para tornillos de fijacion al perfil
		#translate([-8,11,alto/2])rotate([0,90,0])
			cylinder(h=anchop+2*pared+6,r=2.1,$fn=30);
		// vano en el anclaje
		translate([-0.1,-0.1,-5])cube([anchop,fondop,50]);
	}
	//color("red"){translate([2,-pared-2.49,hbase+15])rotate([0,90,0])
	//	bisagra(altura=25,anchura=10);
	//translate([32,-pared-2.49,hbase+15])rotate([0,90,0])
	//	bisagra(altura=25,anchura=10);
	/*translate([anchop-5.8,(fondop-8)/2,0])
		presilla_perfil(largo=13, hole=false);
	mirror([1,0,0])translate([-5.6,(fondop-8)/2,0])
		presilla_perfil(largo=13, hole=false);*/
	}
	translate([133,0,0])amarra();
	//}
}


// para estabilidad del marco con los perfiles
module peana_02(alto=48, pared=2.7, perfil=22,mtor=3){

	difference(){
		union(){
			proforma(altura=alto, ancho=anchop, fondo=fondop, pared=pared); 

			color("pink")translate([anchop+2.1,-perfil,0])
				cube([perfil+pared,3*perfil,12]);

			color("cyan")translate([anchop+2.1,-perfil,0])
				cube([pared,3*perfil,alto]);

			color("red")translate([anchop+0.1,-2.7,0])
				cube([pared,perfil+5.4,alto]);
		}
		// hueco para tornillos de fijacion al perfil vertical
		translate([-1.5*pared,11,alto/2])rotate([0,90,0])
			cylinder(h=60,r=(mtor/2)+0.1,$fn=30);
		// rebaje para hacer las patas del asiento del perfil horizontal
		translate([anchop+(perfil/2)+pared+2,60,-1])rotate([90,0,0])hull(){
			cylinder(h=100,r=perfil/3, $fn=6);
			translate([0,perfil/3,0])
				cylinder(h=100,r=perfil/6, $fn=6);
		}
		// rebaje en la base de asiento del perfil
		translate([55,-7,-10])hull(){
			translate([0,0,0])cylinder(h=alto, r=pared, $fn=90);
			translate([20,0,0])cylinder(h=alto, r=pared, $fn=90);
			translate([20,36,0])cylinder(h=alto, r=pared, $fn=90);
			translate([0,36,0])cylinder(h=alto, r=pared, $fn=90);
		}
		// taladros para los tornillos fijadores del perfil horizontal
		translate([anchop+(perfil/2)+pared+2,perfil+15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		// hueco para la cabeza del tornillo
		translate([anchop+(perfil/2)+pared+2,perfil+15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		// tornillos horizontales
		translate([anchop-1,-15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		translate([anchop-1,perfil+15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		// bisel lateral en la pared del perfil horizontal
		translate([anchop-2,-26,25])rotate([45,0,0])cube([10,50,50]);
		translate([anchop-2,13,60])rotate([-45,0,0])cube([10,50,50]);
		// tornillos fijadores de la caja de conexiones
		translate([11,-5,35])rotate([-90,0,0])
			cylinder(h=alto, r=1.6, $fn=90);
		translate([33,-5,35])rotate([-90,0,0])
			cylinder(h=alto, r=1.6, $fn=90);
	}
}



// parte superior del juego de bisagras que pliega el marco de
// aluminio y que soporta el motor y la varilla lisa del eje Z
module cierre(altura, ancho, fondo){

	proforma(altura, ancho=anchop, fondo=fondop);
	translate([12,-pared-2.49,altura])rotate([0,90,0])bisagra(altura,20);
	translate([anchop-5.8,(fondop-8)/2,0])
		presilla_perfil(largo=5, hole=false);
	mirror([1,0,0])translate([-5.6,(fondop-8)/2,0])
		presilla_perfil(largo=5, hole=false);
}


module portamotor_Z(esp=5){
	difference(){
		union(){
			translate([NEMA14-4,fondop+pared+6.9,0])rotate([0,0,90])
				portamotor(espesor=esp);
			translate([17+25,fondop+(pared/2)+23,esp])
				cylinder(h=5, r1=6.5, r2=4.5, $fn=50);
			translate([17+25,fondop+(pared/2)+23,0])
				cylinder(h=esp, r=6.5, $fn=50);
		}
		union(){
		// hueco para la barra lisa
		translate([17+25,fondop+(pared/2)+23,esp+2])
			cylinder(h=15,r=3.08,$fn=50);
		//translate([40,45.5,-1])cube([30,1,10]);
			// esquina redondeada
			translate([anchop-1,NEMA14+fondop+pared-1,-3])difference(){
				cube([5,5,esp+5]);
				translate([0,0,-3])cylinder(h=20,r=4,$fn=50);
			}
		}
	}
	// separacion del hueco del perfil
	#translate([0,(fondop+pared/2)-2,0])cube([NEMA14+13.1,8,esp]);
	// porta final de carrera
	translate([anchop+2,3*NEMA14/4,0])difference(){
			hull(){
				cube([7,26,esp]);
				translate([14,3,0])cylinder(h=esp, r=3, $fn=50);
				translate([14,23,0])cylinder(h=esp, r=3, $fn=50);
			}
			// hueco para el final de carrera
			translate([7.2,3,-1])cube([7,20.15,esp+2]);
		}
	// agujero para los tornillos laterales de fijacion al perfil
	difference(){
		proforma(altura=10,ancho=anchop, fondo=fondop);
		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
}


module portamotor(espesor=5){
	difference(){
		union(){
			difference(){
				// proforma
				translate([-4,-4,0])cube([NEMA14,NEMA14,espesor]);
		
				union(){
					// taladros para tornillos
					translate([0,0,-3])cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([26,0,-3])cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([0,26,-3])cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([26,26,-3])cylinder(h=espesor+5, r=1.6, $fn=30);
					// muesca lateral
					translate([6,6,-3])cube([30,50,espesor+5]);
					//translate([6,-6,-5])cube([30,50,15]);
				}
			}
			// extremos redondeados
			translate([5.5,26.36,0])cylinder(h=espesor, r=3.65, $fn=50);
			translate([26.36,5.5,0])cylinder(h=espesor, r=3.65, $fn=50);
			//translate([5.9,-0.358,0])cylinder(h=espesor, r=3.65, $fn=50);
		}
			// hueco central

			translate([13,13,-2])cylinder(h=espesor+5, r=12, $fn=60);						%translate([13,13,-2])cylinder(h=espesor+5, r=2.6, $fn=50);
			%translate([-2.5,13,-2])cylinder(h=espesor+5, r=3.2, $fn=50);
			%translate([13,-2.5,-2])cylinder(h=espesor+5, r=3.2, $fn=50);
	}
	// porta barra lisa
	//translate([-4,-17.1,0])cube([NEMA14,13.1,espesor]);
	//translate([13,13,-2])cylinder(h=10, r=2.5, $fn=60);
}


module clip_superior(espesor){

	translate([1,-2,0])difference(){
		union(){
			difference(){
				// proforma
				translate([8,-4,0])cube([NEMA14+10,0.8*NEMA14,espesor]);
		
				union(){
					// hueco para la barra lisa
					#translate([41.5,14,-2])cylinder(h=espesor+5, r=3, $fn=50);
					// tornillo fijador de la barra lisa
					translate([47,3,espesor/2])rotate([-90,0,0])
						cylinder(h=20, r=1.6, $fn=50);
					// hueco para la tuerca fijadora
					translate([44.25,8,-2])cube([5.5,3.2,espesor+5]);
				}
			}
		}
			// hueco central para el rodamiento centrador...
			translate([16,13,espesor-5])cylinder(h=6, r=5.58, $fn=60);
			// ... y la varilla roscada
			translate([16,13,-2])cylinder(h=espesor+5, r=2.55, $fn=60);
			// extremos redondeados
			translate([5.95,20.2,-2])difference(){
				cube([5,5,espesor+5]);
				translate([5,0,-2])cylinder(h=espesor+5, r=3, $fn=50);
			}
			translate([41,20.25,-2])difference(){
				cube([4,4,espesor+5]);
				translate([0,0,-2])cylinder(h=espesor+5, r=3, $fn=50);
			}
			translate([48,14,-2])difference(){
				cube([5,5,espesor+5]);
				translate([0,0,-2])cylinder(h=espesor+5, r=4, $fn=50);
			}
			translate([48,6,-2])rotate([0,0,-90])difference(){
				cube([5,5,espesor+5]);
				translate([0,0,-2])cylinder(h=espesor+5, r=4, $fn=50);
			}
			// muesca para cabeza de tornillo fijador
			translate([0,1,0])union(){
				translate([NEMA14+10,17,-2])cube([10,10,espesor+5]);
				translate([NEMA14+8,12.7,-2])cube([15,0.6,espesor+5]);
				translate([44,-15,-2])cube([10,16,espesor+5]);
			}
			// vano central
			translate([27,0,-2])hull(){
				cylinder(h=espesor+5, r=3, $fn=50);
				translate([0,18,0])cylinder(h=espesor+5, r=3, $fn=50);
				translate([5,18,0])cylinder(h=espesor+5, r=3, $fn=50);
				translate([5,0,0])cylinder(h=espesor+5, r=3, $fn=50);
			}
	}
	// espaciador
	#translate([9,-11,0])cube([NEMA14+2,5,espesor]);
}


module amarre_superior(al, la, an){

	difference(){
		proforma(altura=al, ancho=la, fondo=an);

		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
	translate([0,fondop+pared+8,0])clip_superior(espesor=7);

	translate([0,0,10])hull(){
		translate([0,0,0])cylinder(h=1.2, r=5, $fn=50);
		translate([la,0,0])cylinder(h=1.2, r=5, $fn=50);
		translate([la,an,0])cylinder(h=1.2, r=5, $fn=50);
		translate([0,an,0])cylinder(h=1.2, r=5, $fn=50);
	}
}


module upper_union(largo,ancho){

	difference(){
		cube([largo,ancho,7]);
		union(){
			translate([11,11,-2])cylinder(h=10,r=2.6,$fn=30);
			translate([11,11,3.5])cylinder(h=10,r=4.55,$fn=50);

			translate([33,11,-2])cylinder(h=10,r=2.6,$fn=30);
			translate([33,11,3.5])cylinder(h=10,r=4.55,$fn=50);

			translate([3.5,11,-2])cylinder(h=10,r=1.6,$fn=50);
			translate([40.5,11,-2])cylinder(h=10,r=1.6,$fn=50);
		}
	}
}


module extruder_holder(){

	difference(){	
		proforma(10, ancho=anchop, fondo=fondop);

		translate([-10,fondop/2,5])rotate([0,90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
	difference(){
		color("red")union(){
			translate([anchop,-5,0])cube([10,3,10]);
			translate([anchop+10,-2,5])rotate([90,0,0])
				cylinder(h=3, r=5, $fn=50);
		}
		translate([anchop+10,-10,5])rotate([-90,0,0])
				cylinder(h=10, r=1.6, $fn=50);
	}
}


module presilla_perfil(largo=10, hole=true){

	color("red")
	translate([0,0,largo])rotate([0,90,0])difference(){
		union(){
			cube([largo,8,4]);
			translate([0,1.5,4])cube([largo,5,1.7]);
		}
		if (hole){	
			translate([largo/2,4,-2])union(){
				cylinder(h=20,r=1.6,$fn=30);	// hueco para el tornillo...
				cylinder(h=5,r=3.2,$fn=6);		// ... y para la tuerca.
			}
		}
	}
}


module porta_final_carrera(dejes){

	difference(){
		// proforma
		union(){
			hull(){
			translate([0,0,0])cylinder(h=10, r=5, $fn=40);
			translate([-1,6,0])cube([5,3,10]);
			}
			hull(){
			translate([dejes,0,0])cylinder(h=10, r=5, $fn=40);
			translate([dejes-4,6,0])cube([5,3,10]);
			}
			translate([0,6,0])cube([dejes,3,10]);
		}
		// hueco para encajar en las barras lisas
		union(){
			translate([0,0,-5])cylinder(h=25, r=3, $fn=40);
			translate([dejes,0,-5])cylinder(h=25, r=3, $fn=40);
			translate([-10,-16.5,-2])cube([50,15,15]);
			//sitio para los tornillos de fijacion del final de carrera
			translate([(dejes-4)/3,0,5])rotate([-90,0,0]){
				translate([0,0,-5])cylinder(h=15, r=1.3, $fn=30);
				hull(){
					translate([7,0,-5])cylinder(h=15, r=1.3, $fn=30);
					translate([11,0,-5])cylinder(h=15, r=1.3, $fn=30);
				}
			}
		}
	}
}


module caja_ONOFF(alt=50,la=44,an=30,esp=1.5){

	difference(){
		proforma(altura=alt,ancho=la,fondo=an,pared=esp);
		
		
		//translate([-5,-8,-5])cube([60,10,60]);
		//translate([-5,-2,-5])cube([60,10,12]);
		
		#translate([-10,8,25])cube([30,13.5,18.5]);
		#translate([5,14.5,10])rotate([0,-90,0])
			cylinder(h=10, r=4.1, $fn=50);
	}
	difference(){
	union(){
		translate([esp,esp,0])cylinder(h=alt, r=4, $fn=90);
		translate([la-esp,esp,0])cylinder(h=alt, r=4, $fn=90);
		translate([la-esp,an-esp,0])cylinder(h=alt, r=4, $fn=90);
		translate([esp,an-esp,0])cylinder(h=alt, r=4, $fn=90);
	}
	translate([esp,esp,10])cylinder(h=alt, r=1.2, $fn=90);
	translate([la-esp,esp,10])cylinder(h=alt, r=1.2, $fn=90);
	translate([la-esp,an-esp,10])cylinder(h=alt, r=1.2, $fn=90);
	translate([esp,an-esp,10])cylinder(h=alt, r=1.2, $fn=90);
	}
}


module guardacable(longitud){

	color("red")cube([longitud,9,1.5]);
	translate([0,2,1.5])cube([longitud,5,1.7]);
}


module portainductivo_prusa(rosca=8){


difference(){
	hull(){
		translate([0,-rosca-7,0])
			cylinder(h=20, r=(rosca/2)+7, $fn=10*rosca);
		
		rotate([90,0,0])hull(){
				translate([-7,20,0])cylinder(h=5, r=4, $fn=50);
				translate([7,20,0])cylinder(h=5, r=4, $fn=50);
				translate([-12,0,0])cube([24,2,5]);
		
			}
	}
	union(){
		translate([0,-2,20])rotate([90,0,0])union(){
			translate([-7,0,-5])cylinder(h=15, r=1.6, $fn=30);
			translate([7,0,-5])cylinder(h=15, r=1.6, $fn=30);
		
			translate([-7,0,0])cylinder(h=10, r=3.2, $fn=6);
			translate([7,0,0])cylinder(h=10, r=3.2, $fn=6);
		}
	
		translate([0,-rosca-3,-10])cylinder(h=50, r=rosca/2, $fn=10*rosca);
		translate([-40,-45,8])cube([80,40,50]);

		#translate([-3.5,-1.5*rosca-12,-10])cube([7,6,30]);
		#translate([0,-rosca-5,4])rotate([90,0,0])
			cylinder(h=20, r=2, $fn=60);
		}
	}
}


module bearing_holder_y(){

union(){
	difference(){
		hull(){
			cylinder(h=14.5, r=5, $fn=90);
			translate([-5,0,0])cube([10,10,14.5]);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
		translate([-10,-12,4])cube([20,20,6.5]);
	}
	difference(){
		union(){
			translate([0,0,9.25])cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
			translate([0,0,4])cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
	}

	rotate([0,0,180])translate([0,-19.8,4.25])difference(){
		hull(){
			cylinder(h=6, r=5, $fn=90);
			translate([-5,0,0])cube([10,10,6]);
		}
		translate([0,0,-10])cylinder(h=20, r=3.1, $fn=90);
	}
}
}


module pata(perfil = 22){

	color("orange")difference(){
		
		cube([perfil+15,43,perfil+2.5]);
	
	
		translate([2.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		translate([perfil+5.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		// esquinas biseladas
		translate([-5,55,7])rotate([45,0,0])cube([45,45,45]);
		translate([2*perfil,-5,12])rotate([0,-50,0])cube([45,45,45]);	
		translate([2*perfil,1.2*perfil,-5])rotate([0,0,45])cube([45,45,45]);	
		// agujeros para los tornillos fijadores
		translate([(perfil/2)+2.5,43-(perfil+2.5)+15,-5])
			cylinder(h=10, r=1.6, $fn=50);
		translate([(perfil/2)+2.5,-5,(perfil/2)+2.5])rotate([-90,0,0])
			cylinder(h=10, r=1.6, $fn=50);
	}
	
	color("red")translate([perfil,(perfil/2)+2.5-2.4,2.5])
		cube([3,4.9,perfil]);
	difference(){
		color("red")translate([perfil+5,2.5,2.5])
			cube([(perfil+15)-(perfil+5),12,12]);
		// bisel en el apoyo de la pata
		translate([perfil+5,16,10])rotate([45,0,0])
			cube([(perfil+15)-(perfil+5),12,12]);
	}
	color("cyan")translate([perfil+5,16,0])rotate([45,0,0])
		cube([10,2,5]);
	color("cyan")translate([perfil+5,4,12])rotate([45,0,0])
		cube([10,2,5]);
}


module portamotor_y(espesor=7, perfil=22){

	portamotor(espesor);

	// perfil aluminio
	//translate([2,-26,0])color("grey")cube([22,22,10]);

	translate([-0.6,(-perfil/2)-4,espesor/2])rotate([0,90,0])
		difference(){
			hull(){
				translate([-espesor/2,0,0])cube([espesor,perfil/2,2.5]);
				cylinder(h=2.5, r=espesor/2, $fn=60);
			}
		translate([0,0,-2])cylinder(h=10, r=1.6, $fn=60);
	}
	translate([perfil-0.5+2.5,(-perfil/2)-4,espesor/2])rotate([0,90,0])
		difference(){
			hull(){
				translate([-espesor/2,0,0])cube([espesor,perfil/2,2.5]);
				cylinder(h=2.5, r=espesor/2, $fn=60);
			}
		translate([0,0,-2])cylinder(h=10, r=1.6, $fn=60);
	}
	color("cyan")translate([-0.46,-7.55,0])rotate([0,0,45])
		cube([3,5,espesor]);
	color("cyan")translate([perfil+2.35,-5.4,0])rotate([0,0,-45])
		cube([3,5,espesor]);

}


module bearing_holder_y_02(){

union(){
	difference(){
		hull(){
			cylinder(h=14.5, r=5, $fn=90);
			translate([-5,0,0])cube([10,10,14.5]);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
		translate([-10,-12,4])cube([20,20,6.5]);
	}
	difference(){
		union(){
			translate([0,0,9.25])cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
			translate([0,0,4])cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
	}
	translate([0,12,-3])rotate([90,0,0])difference(){
		hull(){
			cylinder(h=2.5, r=5, $fn=60);
			translate([0,20,0])cylinder(h=2.5, r=5, $fn=60);
		}
		translate([0,0,-5])cylinder(h=10, r=1.6, $fn=50);
		translate([0,20,-5])cylinder(h=10, r=1.6, $fn=50);
	}
}
}


module smooth_rod_holder(perfil=22){

	difference(){
		union(){
				cylinder(h=perfil+2.5, r=5, $fn=90);
			translate([0,-5,0])
				cube([(perfil/2)+5.1,10,perfil+2.5]);
			translate([(perfil/2)+5.1,0,0])
				cylinder(h=perfil+2.5, r=5, $fn=90);
		}
		// varilla lisa M6
		translate([0,0,perfil-2.5])cylinder(h=7, r=3.2, $fn=90);
		translate([5,-10,2.5])cube([50,50,50]);
		translate([(perfil/2)+5.1,0,-2])cylinder(h=7, r=1.6, $fn=90);
	}
	//color("lightgrey")translate([5,-15,2.5])cube([11,30,22]);
}


module portamotor_z_02(esp=5){

	difference(){
		union(){
			translate([NEMA14-4,fondop+pared+6.9,0])rotate([0,0,90])
				portamotor(espesor=esp);
			// separacion del hueco del perfil
			translate([0,(fondop+pared/2)-2,0])
				cube([NEMA14+4,8,esp]);
			translate([NEMA14,(fondop+pared/2)-2,0])
				cube([4,NEMA14+7.9,esp]);
		}
		translate([NEMA14-1.5,fondop+pared+19.9,-5])
			cylinder(h=70, r=3.2, $fn=30);
		translate([NEMA14-6,fondop+pared+19.4,-5])
			cube([5,1,30]);
		translate([NEMA14+0.1,NEMA14+fondop+pared-1,-3])difference(){
			cube([5,5,esp+5]);
			translate([0,0,-3])cylinder(h=20,r=4,$fn=50);
		}
	}
	// agujero para los tornillos laterales de fijacion al perfil
	translate([-2.5,0,0])difference(){
		proforma(altura=10,ancho=anchop, fondo=fondop);
		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
}


// ----------------------------------------------


// pieces for one side...
//peana_02();
//mirror([1,0,0])translate([20,-50,0])cierre(25, ancho=anchop, fondo=fondop);
//mirror([1,0,0])translate([-50,-50,0])portamotor_Z(esp=6);
//mirror([0,1,0])portamotor_z_02();
//mirror([1,0,0])translate([15,-50,0])
//		amarre_superior(al=10, la=anchop, an=fondop);
//upper_union(largo=44,ancho=22);
//extruder_holder();


// ... and for the other one
mirror([1,0,0])translate([-120,0,0])peana(alto=50);
//color("pink")translate([120,-5,0])rotate([0,0,180])caja_ONOFF(esp=2);
//cierre(25, ancho=anchop, fondo=fondop);
//portamotor_Z(esp=7);
//translate([-60,20,0])amarre_superior(al=10, la=anchop, an=fondop);
//rotate([0,-90,0])presilla_perfil(largo=10, hole=true);

//porta_final_carrera(dejes=25);

//translate([20,5,0])guardacable(longitud=30);

//rotate([180,0,0])presilla_eje_y();

//rosca_presilla_eje_y(altura=6);

//translate([30,0,0])rosca_presilla_eje_y(altura=6, radio=8, paso=24, metrica=3);

//color("pink")portainductivo_prusa(rosca=12);

//color("pink")rotate([0,90,0])bearing_holder_y_02();
/*pata();
translate([-5,0,0])mirror([1,0,0])pata();
translate([0,-5,0])mirror([0,1,0])pata();
translate([-5,-5,0])mirror([1,0,0])mirror([0,1,0])pata();
*/

//portamotor_y(espesor=10);

//smooth_rod_holder();


