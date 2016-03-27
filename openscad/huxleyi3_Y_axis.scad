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


// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
module foot(perfil = fondop){

	color("orange")difference(){
		
		cube([perfil+15,43,perfil+2.5]);
	
	
		translate([2.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		translate([perfil+5.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		// beveled corners
		translate([-5,55,7])rotate([45,0,0])cube([45,45,45]);
		translate([2*perfil,-5,12])rotate([0,-50,0])cube([45,45,45]);	
		translate([2*perfil,1.2*perfil,-5])rotate([0,0,45])cube([45,45,45]);	
		// drills for fixing screws
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
		// soem bevel on foot base
		translate([perfil+5,16,10])rotate([45,0,0])
			cube([(perfil+15)-(perfil+5),12,12]);
	}
	color("cyan")translate([perfil+5,16,0])rotate([45,0,0])
		cube([10,2,5]);
	color("cyan")translate([perfil+5,4,12])rotate([45,0,0])
		cube([10,2,5]);
}



// espesor = piece height (here we have no wall thickness)
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
module y_motor_holder(espesor=7, perfil=fondop){

	portamotor_14(ht=espesor);

	// fake aluminum slot
	// translate([2,-26,0])color("grey")cube([fondop,fondop,10]);

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


// bearing 623ZZ idler for Y axis
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



// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
module y_smooth_rod_holder(perfil=fondop){

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




// adjustement piece for Y end stop (piece 1)
module y_endstop_adj(){

	difference(){
		rotate([90,0,0])union(){
			difference(){
				union(){
					cylinder(h=5, r=4, $fn=80);
					translate([-5.5,-4,0])cube([5.5,8,5]);
				}			
				translate([0,0,-3])cylinder(h=10, r=1.6, $fn=50);
			}		
			translate([-15.5,-4,-13])cube([10,8,18]);
			translate([-5.5,0,-13])rotate([0,-90,0])
				cylinder(h=10,r=4,$fn=80);
		}	
		translate([0,13,0])rotate([0,-90,0])
			cylinder(h=20,r=1.6,$fn=80);
		translate([-12,10.25,-7])cube([3,10,15]);
		translate([-10.5,0,-5])rotate([0,0,180])rounded_corner();
	}

}




module y_bearing_holder(){

	difference(){
		union(){			
			translate([0,0,-2])hull(){
				translate([0,0,-7.7])cube([13.5,16.5,5]);
				translate([12.15,22.25,-7.7])cylinder(h=5,r=5,$fn=60);
			}
			
			translate([0,0,-2])hull(){
				translate([54.8,0,-7.7])cube([13.5,16.5,5]);
				translate([56.15,22.25,-7.7])cylinder(h=5,r=5,$fn=60);
			}
			
			color("cyan")translate([0,-1.50,-7]){
				translate([0,-1,-2.7])cube([68.3,18.5,5]);
			}
			// LM6UU bearing clamps
			color("orange")translate([3.3,-2.5,-4.7])cube([15,18.5,4.75]);
			color("orange")translate([49.8,-2.5,-4.7])cube([15,18.5,4.75]);
		}

		translate([78.3,15.25,0])union(){
			// M3 fixing screws and nuts 
			translate([-66.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-66.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			translate([-22.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-22.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			// bearings and smooth rod
			translate([-58,-8.5,-1])rotate([0,-90,0])
				cylinder(h=19,r=6.1,$fn=60);
			#translate([-11.5,-8.5,-1])rotate([0,-90,0])
				cylinder(h=19,r=6.1,$fn=60);
			translate([-100,-2.25,-2.95])difference(){
				cube([100,4,4]);	
				color("pink")translate([-2,0,0])rotate([0,90,0])
					cylinder(h=105, r=3, $fn=50);
			}
			translate([0,-14.7,-2.95])rotate([0,0,180])difference(){
				cube([100,4,4]);	
				color("pink")translate([-2,0,0])rotate([0,90,0])
					cylinder(h=105, r=3, $fn=50);
			}
			// cut for filament saving
			translate([-49.3,-65,0])hull(){
				translate([0,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([0,20,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,20,-15])cylinder(h=20,r=5,$fn=50);
	
			}
			translate([-49.3,-25,0])hull(){
				translate([0,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([0,10,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,10,-15])cylinder(h=20,r=5,$fn=50);
			}
		}
	}
}


module heatbed_wire_fastener(){

	difference(){
		hull(){
			cylinder(h=18,r=5,$fn=60);
			translate([0,-5,0])cube([20,10,18]);
		}
		translate([0,0,-1])cylinder(h=3,r=3.2,$fn=6);	
		translate([0,0,-5])cylinder(h=25,r=1.6,$fn=50);
		translate([17.5,0,-5])cylinder(h=25,r=3,$fn=80);
		translate([-10,-10,11])cube([20,20,4.1]);
		//translate([17,0,-5])rounded_corner();
		//translate([17,0,-5])rotate([0,0,-90])rounded_corner();
		translate([17.5,-10,-10])cube([20,20,50]);
		// zip ties
		translate([18,0,3])difference(){
			cylinder(h=3,r=6,$fn=80);
			translate([0,0,-1])cylinder(h=7,r=4,$fn=80);
			translate([0,-15,-4])cube([20,30,10]);
		}
		translate([18,0,13])difference(){
			cylinder(h=3,r=6,$fn=80);
			translate([0,0,-1])cylinder(h=7,r=4,$fn=80);
			translate([0,-15,-4])cube([20,30,10]);
		}
	}

}

