fondop = 20;		// slot width
anchop = 2*fondop;	// slot lenght
altop = 20;			// preform height
pared = 6;			// wall thikness
//hbase = 10;			// altura de la base de fijación
//abase = 7;			// anchura de la base respecto del borde externo del hueco
NEMA14 = 34;		// ancho y alto del NEMA 14 de la huxley.
//lanclaje = 115;	// largo de la base de anclaje
//espesor = 7;


// rd = radius
// lg = length
module rounded_corner(rd=5, lg=30){

	difference(){
		cube([rd+0.1, rd+0.1, lg]);
		translate([0,0,-2])cylinder(h=lg+4, r=rd, $fn=15*rd);
	}
}


// The begining. The main piece.
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
		// hollow for aluminun slot
		translate([-0.1,-0.1,-1])cube([ancho+0.2,fondo+0.2,altura+2]);
	}
}


// Where the vertical and horizontal slots are joined
module base(alto=48, pared=2.7, perfil=20,mtor=3){

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
		// holes for fixing screws (vertical slots)
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
		// holes for fixing screws (horizontal slots)
		translate([anchop+(perfil/2)+pared+2,perfil+15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		// holes for screw heads
		translate([anchop+(perfil/2)+pared+2,perfil+15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		// some screws for horizontal slots (reinforcement)
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


module upper_union(largo,ancho,espesor=7){

	difference(){
		cube([largo,ancho,espesor]);
		union(){
			translate([ancho/2,ancho/2,-2])cylinder(h=10,r=2.6,$fn=30);
			translate([ancho/2,ancho/2,3.5])cylinder(h=10,r=4.55,$fn=50);

			translate([3*ancho/2,ancho/2,-2])cylinder(h=10,r=2.6,$fn=30);
			translate([3*ancho/2,ancho/2,3.5])cylinder(h=10,r=4.55,$fn=50);

			translate([2.5,ancho/2,-2])cylinder(h=10,r=1.6,$fn=50);
			translate([largo-2.5,ancho/2,-2])cylinder(h=10,r=1.6,$fn=50);
		}
	}
}


module presilla_perfil(largo=10, hole=true){

	difference(){
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


module porta_final_carrera(dejes=25){

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

	color("red")cube([longitud,9,0.9]);
	translate([0,2,0])cube([longitud,5,2.1]);
}


module foot(perfil = 22){

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


module y_bearing_idler(){

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
		translate([0,12,-8])rotate([90,0,0])difference(){
			hull(){
				cylinder(h=2.5, r=5, $fn=60);
				translate([0,30,0])cylinder(h=2.5, r=5, $fn=60);
			}
			translate([0,0,-5])cylinder(h=10, r=1.6, $fn=50);
			translate([0,30,-5])cylinder(h=10, r=1.6, $fn=50);
		}
	}
}


module y_smooth_rod_holder(perfil=22){

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


module clip_superior(espesor=10){

	translate([1,-2,0])difference(){
		union(){
			difference(){
				union(){
					// proforma
					translate([8,-4,0])cube([NEMA14+1,0.72*NEMA14,espesor]);
					// espaciador
					translate([8,-10,0])cube([NEMA14+1,6,espesor]);
				}
				union(){
					// hueco para la barra lisa
					translate([34,13.9,-2])
						cylinder(h=espesor+5, r=3, $fn=50);
					translate([-8,0,0])union(){
						// tornillo fijador de la barra lisa
						translate([47,4,espesor/2])rotate([-90,0,0])
							cylinder(h=20, r=1.6, $fn=50);
						// hueco para la tuerca fijadora
						translate([44.25,7,-2])cube([5.5,3.2,espesor+5]);
					}
				}
			}
		}
			// hueco para el rodamiento centrador...
			translate([18.5,13.9,espesor-5])cylinder(h=6, r=5.58, $fn=60);
			// ... y la varilla roscada
			translate([18.5,13.9,-2])cylinder(h=espesor+5, r=2.55, $fn=60);
			// extremos redondeados
			translate([5.95,17.5,-2])difference(){
				cube([5,5,espesor+5]);
				translate([5,0,-2])cylinder(h=espesor+5, r=3, $fn=50);
			}
			translate([40,17.5,-2])difference(){
				cube([4,4,espesor+5]);
				translate([0,0,-2])cylinder(h=espesor+5, r=3, $fn=50);
			}
			translate([NEMA14,13.5,-2])cube([15,0.5,espesor+5]);
			// vano central
			translate([14,-3.5,-2])hull(){
				cylinder(h=espesor+5, r=3, $fn=50);
				translate([0,5,0])cylinder(h=espesor+5, r=3, $fn=50);
				translate([23,5,0])cylinder(h=espesor+5, r=3, $fn=50);
				translate([23,0,0])cylinder(h=espesor+5, r=3, $fn=50);
			}
	}
}


module z_rod_holder(al=10, la=anchop, an=fondop){

	difference(){
		proforma(altura=al, ancho=la, fondo=an);

		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
	translate([0,fondop+pared+8,0])clip_superior(espesor=7);
	// Upper cap
	translate([0,0,10])hull(){
		translate([0,0,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([la,0,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([la,an,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([0,an,0])cylinder(h=1.2, r=2.7, $fn=50);
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
			%translate([-2.5,13,-2])cylinder(h=espesor+5, r=3.1, $fn=50);
			//%translate([13,-2.5,-2])cylinder(h=espesor+5, r=3.1, $fn=50);
	}
	// porta barra lisa
	//translate([-4,-17.1,0])cube([NEMA14,13.1,espesor]);
	//translate([13,13,-2])cylinder(h=10, r=2.5, $fn=60);
}


module z_motor_holder(esp=5){

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
		// hole for smooth rod
		translate([NEMA14-1.5,fondop+pared+19.9,-5])
			cylinder(h=70, r=3.1, $fn=30);
		translate([NEMA14-6,fondop+pared+19.5,-5])
			cube([5,0.5,30]);
		// external rounded corner
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
	// reinforcement (rounded internal corner)
	translate([0,fondop+pared+1.5,10])rotate([-90,0,-90])rounded_corner(lg=38);
}


module ONOFF_box(alt=50,la=54,an=30,esp=2.7){

	difference(){
		proforma(altura=alt,ancho=la,fondo=an,pared=esp);
		
		
		//translate([-5,-8,-5])cube([60,10,60]);
		//translate([-5,-2,-5])cube([60,10,12]);
		
		#translate([-10,8,25])cube([30,13.5,18.5]);
		#translate([5,14.5,10])rotate([0,-90,0])
			cylinder(h=10, r=4.1, $fn=50);
		#translate([55,-7,10])rotate([0,0,90])union(){
			// taladros fijadores
			hull(){
				translate([11,-15,35])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
				translate([11,-15,40])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
			}
			hull(){
				translate([33,-15,35])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
				translate([33,-15,40])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
			}
			// agujeros para la cabeza del tornillo fijador
			translate([11,-15,40])rotate([-90,0,0])
				cylinder(h=30, r=2.8, $fn=50);
			translate([33,-15,40])rotate([-90,0,0])
				cylinder(h=30, r=2.8, $fn=50);
		}
		#translate([55,-7,-30])rotate([0,0,90])union(){
			// taladros fijadores
			hull(){
				translate([11,-15,35])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
				translate([11,-15,40])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
			}
			hull(){
				translate([33,-15,35])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
				translate([33,-15,40])rotate([-90,0,0])
					cylinder(h=30, r=1.6, $fn=50);
			}
			// agujeros para la cabeza del tornillo fijador
			translate([11,-15,40])rotate([-90,0,0])
				cylinder(h=30, r=2.8, $fn=50);
			translate([33,-15,40])rotate([-90,0,0])
				cylinder(h=30, r=2.8, $fn=50);
		}
		//#translate([la-5,an/2,0])rotate([0,90,0])
		//	cylinder(h=20, r=5, $fn=80);
		#union(){
			translate([(la/2)-10,an/2,5])rotate([90,0,0])
				cylinder(h=20, r=5, $fn=80);
			translate([(la/2)-15,-5,-1])
				cube([10,20,6]);
			translate([(la/2)+10,an/2,5])rotate([90,0,0])
				cylinder(h=20, r=5, $fn=80);
			translate([(la/2)+5,-5,-1])
				cube([10,20,6]);
		}
	}
	// agujeros para los tornillos de la tapa
	difference(){
		union(){
			translate([esp,esp,0])cylinder(h=alt, r=4, $fn=90);
			translate([la/2,esp,0])cylinder(h=alt, r=4, $fn=90);
			translate([la/2,an-esp,0])cylinder(h=alt, r=4, $fn=90);
			translate([esp,an-esp,0])cylinder(h=alt, r=4, $fn=90);
		}
		translate([esp,esp,10])cylinder(h=alt, r=1.2, $fn=90);
		translate([la/2,esp,10])cylinder(h=alt, r=1.2, $fn=90);
		translate([la/2,an-esp,10])cylinder(h=alt, r=1.2, $fn=90);
		translate([esp,an-esp,10])cylinder(h=alt, r=1.2, $fn=90);
		}
}


// ----------------------------------------------

//base();
//translate([0,10,0])z_motor_holder();
//mirror([0,1,0])z_motor_holder();
upper_union(largo=anchop,ancho=fondop);

//color("pink")ONOFF_box(esp=2);
//translate([10,0,0])z_rod_holder();
//mirror([1,0,0])z_rod_holder();
//presilla_perfil();

//porta_final_carrera(32);

//guardacable(longitud=30);



//color("pink")rotate([0,90,0])y_bearing_idler();
//foot();
//translate([-5,0,0])mirror([1,0,0])foot();
//translate([0,-5,0])mirror([0,1,0])foot();
//translate([-5,-5,0])mirror([1,0,0])mirror([0,1,0])foot();


//portamotor_y(espesor=10);

//y_smooth_rod_holder();

