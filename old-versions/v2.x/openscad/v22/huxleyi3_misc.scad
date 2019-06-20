//--------------------------------------------------------
//-- Library modules for Huxley i3 3D printer
//--------------------------------------------------------
// (c) 2016 Isidoro Gayo Vélez (isidoro.gayo@wanadoo.es)
// Credits:
//-- Some files have been taken from other authors:
// 		ReprapPRO (large and small gears)
//		ePoxi (https://www.thingiverse.com/thing:279973)
//		jmgiacalone (M6-Block.stl)
//		rowokii (https://www.thingiverse.com/thing:767317)
//--------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//--------------------------------------------------------


module ramps_holder(){

	difference(){
		union(){
			cylinder(h=3,r=4,$fn=80);
			translate([0,-4,0])cube([11,8,3]);
		}
		translate([0,0,-5])cylinder(h=10,r=1.6,$fn=50);
		
	}
	
	translate([8,0,11])rotate([0,90,0])difference(){
		union(){
			cylinder(h=3,r=4,$fn=80);
			translate([0,-4,0])cube([11,8,3]);
		}
		translate([0,0,-5])cylinder(h=10,r=1.6,$fn=50);
		
	}
}



module psu_holder(){

	difference(){
		// Proform
		cube([PSU_footprint_width,PSU_footprint_height,height_from_base],
			center=true);
	
		// Hole for IEC connector
		translate([-2,0,-20]){
			cube([PSU_footprint_width-2,IEC_width,IEC_heigth],center=true);
			cube([PSU_footprint_width-6,IEC_width,IEC_heigth+4],center=true);
		}
		// Hole for switch
		translate([(PSU_footprint_width/2)-switch_width,0,-20]){
			cube([switch_width,PSU_footprint_height+10,switch_height],
				center=true);
			cube([switch_width+4,PSU_footprint_height-2,switch_height],
				center=true);
		}
		// Hollow for wiring
		cube([PSU_footprint_width-2*wall_thickness,
			PSU_footprint_height-2*wall_thickness,height_from_base+10],
				center=true);
		// removing some parts...
		#translate([-(PSU_footprint_width/2)+6,(PSU_footprint_height/2)-1,
			(height_from_base/2)-3])cube([8,4,14],center=true);
		#translate([(PSU_footprint_width/2)-1,(PSU_footprint_height/2)-3.5,
			(height_from_base/2)-3])cube([4,3,14],center=true);
	}


}



module spool_holder_cross(perfil = 22){

	color("pink")difference(){
		
		cube([perfil+30,43,perfil+2.5]);
	
		translate([13,0,0]){
			translate([2.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
			translate([perfil+5.5,perfil+5,2.5])
				cube([perfil+0.2,45,perfil+5]);
			translate([-perfil-0.5,perfil+5,2.5])
				cube([perfil+0.2,45,perfil+5]);
			translate([-perfil,2.5,2.5])cube([3*perfil,perfil+0.2,perfil+5]);
			// esquinas biseladas
			translate([-5,55,7])rotate([45,0,0])cube([45,45,45]);
			translate([2*perfil,1.2*perfil,-5])rotate([0,0,45])
				cube([45,45,45]);	
			translate([-2.35*perfil,55,-5])rotate([0,0,-45])
				cube([45,45,45]);	
			// agujeros para los tornillos fijadores
			translate([(perfil/2)+2.5,43-(perfil+2.5)+15,-5])
				cylinder(h=10, r=1.6, $fn=50);
			translate([(perfil/2)+2.5,-5,(perfil/2)+2.5])rotate([-90,0,0])
				cylinder(h=10, r=1.6, $fn=50);
			translate([perfil+10,20,(perfil/2)+2.5])rotate([-90,0,0])
				cylinder(h=10, r=1.6, $fn=50);
			translate([-6,20,(perfil/2)+2.5])rotate([-90,0,0])
				cylinder(h=10, r=1.6, $fn=50);
		}
	}
}



module spool_upper_crown(perfil = 22){

	color("pink")difference(){
		
		hull(){
			cube([perfil+5,perfil+2.5,perfil+2.5]);
			translate([(perfil/2)+2.5,0,0])
				cylinder(h=perfil+2.5, r=10, $fn=90);
		}
		// hueco para el perfil de alumino
		translate([2.5,2.5,2.5])cube([perfil+0.2,1.2*perfil,perfil+5]);
		// esquinas biseladas
		translate([-5,35,7])rotate([45,0,0])cube([45,45,45]);
		// agujeros para el tornillo fijador
		translate([(perfil/2)+2.5,perfil/2,-5])
			cylinder(h=10, r=1.6, $fn=50);
		// hendidura para la barra de soporte de la bobina
		color("red")translate([(perfil/2)+2.5,-5,5])
			cylinder(h=1.5*perfil, r=4, $fn=90);
		// bisel para introducir la barra de soporte
		translate([0,-perfil-6.5,-5])cube([2*perfil,perfil,1.5*perfil]);
	}
}



module psufastener(){

	color("lightgray")difference(){
		union(){
			cube([40,7,10],center=true);
			translate([20,-3.5,-5])cube([7,25,10]);
		}
		translate([-13,-10,0])rotate([-90,0,0])cylinder(h=30,r=1.6,$fn=70);
		translate([9,-10,0])rotate([-90,0,0])cylinder(h=30,r=1.6,$fn=70);
		translate([-13,-1,0])rotate([-90,0,0])cylinder(h=10,r=3.5,$fn=70);
		translate([9,-1,0])rotate([-90,0,0])cylinder(h=10,r=3.5,$fn=70);
		translate([15,12,0])rotate([0,90,0])hull(){
			cylinder(h=20,r=1.6,$fn=70);
			translate([0,3,0])cylinder(h=20,r=1.6,$fn=70);
		}
		translate([22,1.5,-15])rotate([0,0,-90])rounded_corner();

		translate([10,16.5,0])rotate([0,90,0])rounded_corner();
		translate([40,16.5,0])rotate([0,-90,0])rounded_corner();

		translate([-15,20,0])rotate([90,-90,0])rounded_corner();
		translate([-15,20,0])rotate([90,180,0])rounded_corner();
	}
}


/*
module porta_final_carrera(dejes=25){

	difference(){
		// preform
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
*/


module guardacable(longitud){

	color("red")cube([longitud,9,0.9]);
	translate([0,2,0])cube([longitud,5,2.1]);
}



// largo = length
module slot_clamp(largo=10, hole=true){

	difference(){
		union(){
			cube([largo,8,4]);
			translate([0,1.5,4])cube([largo,5,1.7]);
		}
		if (hole){	
			translate([largo/2,4,-2])union(){
				cylinder(h=20,r=1.6,$fn=30);	// M3 screw drill...
				cylinder(h=5,r=3.2,$fn=6);		// ... and hole for nut.
			}
		}
	}
}



// altura = height
// radio = radius
// paso = pitch
// metrica = metric; M3 = 3, M4 = 4, and so...
// adjustement piece for end stops (piece 2)
module endstop_head_adj(altura=5, radio=6, paso=25, metrica=3){

	difference(){
		union(){
			cylinder(h=altura/2, r=radio, $fn=radio*10);
			translate([0,0,altura/2])
				cylinder(h=altura/2, r1=radio, r2=radio-(radio*0.25), $fn=90);
		}
		if (metrica == 5){
			translate([0,0,(altura/2)+1])cylinder(h=20, r=4.6, $fn=6);
			translate([0,0,-2.5])cylinder(h=4, r=4.6, $fn=90);
		}else
			{
			translate([0,0,(altura/2)+1])cylinder(h=20, r=3.2, $fn=6);
			translate([0,0,-2.5])cylinder(h=4, r=3.2, $fn=90);
			}
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
		}
	for (ang=[0:paso:360]){
		rotate([0,0,ang])translate([radio,0,0])
			cylinder(h=altura/2, r=1.5, $fn=60);
		}
}


