include <modules.lib>


PSU_footprint_width = 98;
PSU_footprint_height = 40;
height_from_base = 70;

IEC_width = 27;
IEC_heigth = 20;

switch_width = 19;
switch_height = 13;

wall_thickness = 2;




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



module psu_fastener(){

	difference(){
	hull(){
		translate([-10,0,0])cylinder(h=3, r=5, $fn=50);
		translate([10,0,0])cylinder(h=3, r=5, $fn=50);
		translate([0,30,0])cylinder(h=3, r=5, $fn=50);
	}

		translate([-10,0,-5])cylinder(h=10, r=1.6, $fn=50);
		translate([10,0,-5])cylinder(h=10, r=1.6, $fn=50);
		hull(){
			translate([0,30,-5])cylinder(h=10, r=1.6, $fn=50);
			translate([0,28,-5])cylinder(h=10, r=1.6, $fn=50);
		}
	}
}


module slot_holder_cross(perfil = 22){

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



module upper_crow(perfil = 22){

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



module ojal(){

	color("lightgray")
	difference(){
	
		union(){
			//translate([0,0,7])cylinder(h=10,r=5,$fn=90);
			translate([0,0,0])cube([64,2,10],center=true);
			translate([-32,0,-5])cube([20,30,10]);
		}
		translate([-27,4,-15])rotate([0,0,180])rounded_corner();
		translate([-27,25,-15])rotate([0,0,90])rounded_corner();
		translate([-22,4,-7])cylinder(h=15,r=1.6,$fn=90);
		translate([-23.6,-6,-7])cube([3.2,10,15]);
		hull(){
			translate([-20.5,17,-7])cylinder(h=15,r=1.6,$fn=90);
			translate([-23.5,17,-7])cylinder(h=15,r=1.6,$fn=90);
		}
		translate([-35.5,-5,-1.5])cube([20,40,10]);
		hull(){
			translate([25,-10,0])rotate([-90,0,0])
				cylinder(h=20,r=1.5,$fn=90);
			translate([27,-10,0])rotate([-90,0,0])
				cylinder(h=20,r=1.5,$fn=90);
		}
	
		translate([27,15,0])rotate([90,0,0])rounded_corner();
		translate([24.8,15,3])rotate([90,0,0])rounded_corner(rd=2);
		translate([24.8,15,3])rotate([90,90,0])rounded_corner(rd=2);
	
		translate([29.5,15,-2.5])rotate([90,90,0])rounded_corner(rd=2.5);
		
		translate([26.8,-5,0])cube([1.8,10,10]);

	}
	translate([17,30,-5])rotate([0,0,180])rounded_corner(rd=29,lg=10);
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



module guardacable(longitud){

	color("red")cube([longitud,9,0.9]);
	translate([0,2,0])cube([longitud,5,2.1]);
}




/* ---------------------------------------------------------------------- */

//mirror([1,0,0])
//rotate([180,0,0])
//ramps_holder();
//rotate([0,0,90])psu_holder();

//psu_fastener();
//translate([25,30,0])rotate([0,0,180])psu_fastener();

//slot_holder_cross();

//upper_crow();
//guardacable(longitud=30);
//rotate([90,0,0])ojal();

rotate([90,0,0])psufastener();

porta_final_carrera(32);