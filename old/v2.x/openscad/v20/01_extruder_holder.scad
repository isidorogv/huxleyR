include <modules.lib>


module cabeza_hotend(){

	import("merlin_hotend.stl");
	translate([-8.25,-20,41.6])cube([16.5,20,5]);
	translate([0,0,41.6])cylinder(h=5, r=8.25, $fn=90);
	translate([-6.25,-20,37.2])cube([12.5,20,5]);
	translate([0,0,37.2])cylinder(h=5, r=6.25, $fn=90);
	translate([0,0,30])cylinder(h=10, r=5.5, $fn=90);
	translate([-8.25,-20,32.5])cube([16.5,20,5]);
	//translate([0,0,32.5])cylinder(h=14, r=8.25, $fn=90);
}


module extruder_01(){
	union(){
		difference(){
			translate([19,23.5,0])rotate([0,0,180]){
				union(){
					import("M6-Block.stl");
					color("cyan")translate([55,23.5,5])
						cylinder(r=5,h=0.3);
					color("black")translate([68.25,8.5,11.3])
						cylinder(r=2,h=0.3,$fn=12);
					// tapamos huecos anteriores para abrir los nuevos
					color("pink")translate([53,4,0])cube([10,5,28]);
					translate([58.4,5,15.5])rotate([90,0,0])
						cylinder(h=5, r=3.5, $fn=60);
					// parte donde se acopla el hotend
					color("orange")translate([46,-10,0])cube([25,12,28]);
					// enganche para un ventilador
					translate([74,-5,12])rotate([0,0,90])difference(){
						hull(){
							cylinder(h=5 ,r=4, $fn=90);
							translate([-5,3,0])cube([10,1,5]);
						}
						translate([0,0,-3])cylinder(h=10 ,r=1.6, $fn=60);
					}
					color("black")translate([74.25,-5,12])
						cylinder(r=2,h=0.3,$fn=12);
				}
			}
				// hueco para el hilo...
				translate([-39.4,50,15])rotate([90,0,0])
					cylinder(h=90, r=1.1, $fn=60);
				// ... y el pneufit M5
				//translate([-39.4,27.5,15.5])rotate([90,0,0])
				//	cylinder(h=8, r=2.5, $fn=60);
				// Cortamos el saliente izquierdo del viejo extrusor
				translate([-82,-6,-5])cube([30,30,50]);
				translate([-39.5,-12,15])rotate([-90,0,0])	
					translate([0,0,32.5])cylinder(h=15, r=8.25, $fn=90);
				// tornillos fijadores transversales
				translate([-54.5,0,-28])rotate([0,90,0])union(){
				translate([-20,28,7.2])rotate([0,-90,0])
					cylinder(h=40, r=1.5, $fn=30);
				translate([-20,28,22.8])rotate([0,-90,0])
					cylinder(h=40, r=1.5, $fn=30);
				// hueco para las tuercas 
				translate([-20,28,7.2])rotate([0,-90,0])
					cylinder(h=12, r=3.1, $fn=6);
				translate([-20,28,22.8])rotate([0,-90,0])
					cylinder(h=12, r=3.1, $fn=6);
				}
		}
	}
}


module extruder(){
	
	// Rueda grande
/*	%translate([23,-26.5,-5]){
	cylinder(r=31,h=3, $fn=120);
	#cylinder(r=1,h=5, $fn=120);
	}
	translate([-1,1,0])union(){
			// pequerueda
		translate([0,0,-12]){
			translate([0,0,6])cylinder(r=7,h=6, $fn=60);
			cylinder(r=9,h=6, $fn=60);
		}
		translate([0,0,23])rotate([180,0,0])NEMA14();
	}*/

	difference(){
		union(){
			translate([-31.5,-56.5,0])difference(){
				translate([20,30,0])rotate([0,0,180])extruder_01();
				translate([-8.4,0,-5])cube([50,60,50]);
			}
			color("pink")translate([13,-13,0])rotate([0,0,90])
				portamotor_14();
			translate([22,-2,0])rotate([0,0,180])rounded_corner(lg=5);
			translate([2,-25,0])rounded_corner(rd=8, lg=5);
		}
			translate([-0.5,25.5,-5])hull(){
				translate([10.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
				translate([13.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
			}
			translate([-0.5,-0.5,-5])hull(){
				translate([10.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
				translate([13.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
			}
			translate([-26,-0.5,-5])hull(){
				translate([11.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
				translate([14.5,-12.5,0])cylinder(h=15, r=1.6, $fn=60);
			}
			translate([14,14,-1])rounded_corner(rd=3, lg=7);
			translate([-14,-14,-1])rotate([0,0,180])
				rounded_corner(rd=3, lg=7);
	}

	difference(){
		// pletina fijadora al carro eje x.
		translate([0,-25,0])union(){
			color("cyan")translate([-5,-45.5,0])cube([5,42,35]);
			color("lightgreen")translate([-4,-30,0])cube([20,5,28]);
			color("lightgreen")translate([-4,-8.5,0])cube([18,5,28]);
			/*color("cyan")translate([-5,-18,0])cube([5,27.5,5]);
			color("cyan")translate([0,-25,13])cube([12,14,5]);
			translate([0,-15,30])rotate([0,-90,0])
				cylinder(h=5, r=4.5, $fn=50);
			translate([0,-46,30])rotate([0,-90,0])
				cylinder(h=5, r=4.5, $fn=50);
			translate([-5,-50.5,25.5])cube([5,40,4.5]);
			translate([-5,-45.5,25.5])cube([5,30,9]);
			translate([-5,9.5,25])rotate([-90,0,-90])
				rounded_corner(rd=20, lg=5);*/
		}	
		translate([0,-15,0])union(){
			// tornillos y tuercas fijadores inferiores
			translate([2,-49,5])rotate([0,-90,0])
				cylinder(h=5, r=3.2, $fn=6);
			translate([2,-49,5])rotate([0,-90,0])
				cylinder(h=15, r=1.5, $fn=30);
			translate([2,-49,30])rotate([0,-90,0])
				cylinder(h=5, r=3.2, $fn=6);
			translate([2,-49,30])rotate([0,-90,0])
				cylinder(h=15, r=1.5, $fn=30);
			// tornillos y tuercas fijadores superiores
			translate([2,-22,5])rotate([0,-90,0])
				cylinder(h=5, r=3.2, $fn=6);
			translate([2,-22,5])rotate([0,-90,0])
				cylinder(h=15, r=1.5, $fn=30);
			translate([2,-22,30])rotate([0,-90,0])
				cylinder(h=5, r=3.2, $fn=6);
			translate([2,-22,30])rotate([0,-90,0])
				cylinder(h=15, r=1.5, $fn=30);
			// some rounded corners
			translate([5,-18.5,30])rotate([0,-90,0])
				rounded_corner(rd=5, lg=15);
			translate([-10,-50.5,30])rotate([180,-90,0])
				rounded_corner(rd=5, lg=15);
		}
		// hole for wiring...
		#translate([2,-60,23])cube([4,15,12]);
		translate([12,-52.5,18])cylinder(h=15,r=1.2,$fn=50);
		// ... and for a zip tie
		translate([2,-60,3])cube([4,35,2]);
	}
}


module x_motor_holder(){

	difference(){
		// Proform
		union(){
			translate([48.95,7.8,0])cube([16.5,8,42]);
			translate([59,1,0])cube([21,14,8]);
			translate([38,1,0])cube([21,14,4]);
			translate([12,1,0])cube([26,26,4]);
			translate([4,14.5,0])cube([76,12.5,42]);
			translate([57.45,7.85,0])cylinder(h=42, r=8, $fn=90);
		}
		// Smooth rods
		#translate([50,19.38,36.9])rotate([0,90,0])union(){
			translate([0,0,15])cylinder(h=35, r=3.1, $fn=90);
			translate([31.95,0,15])cylinder(h=35, r=3.1, $fn=90);
		}
		// LM6UU bearings
		#translate([57.45,7.85,-5])cylinder(h=60, r=6.1, $fn=90);
		#translate([57,-3,-5])cube([0.5,10,60]);
		// M5 threaded rod
		#translate([72.95,7.85,-5])cylinder(h=20, r=2.6, $fn=70);
		#translate([72.95,7.85,4])cylinder(h=7, r=4.65, $fn=6);
		
		// Room for belt
		//#translate([20,15.4,12])cube([70,7.9,18]);
		translate([20,15.5,28])rotate([0,90,0])hull(){
			rotate([0,0,45])cube([5.5,5.5,70]);
			translate([14,0,0])rotate([0,0,45])cube([5.5,5.5,70]);
		}
		// Rounded internal corner on bearing left side
		hull(){
			translate([0,0,4])cube([40,22,50]);
			translate([44.5,17,4])cylinder(h=50, r=5, $fn=90);
			translate([44.5,0,4])cylinder(h=50, r=5, $fn=90);
		}
		// Left bevel for motor hollow
		translate([-15.5,-2.3,-5])rotate([0,0,-23.3])cube([100,30,20]);
		// NEMA14 motor shape
		translate([38,27,8])rotate([0,-90,90])union(){
			// screw holes
			hull(){
				translate([0,0,-3])cylinder(h=15, r=1.6, $fn=30);
				translate([-2.5,-2.5,-3])cylinder(h=15, r=1.6, $fn=30);
			}
			hull(){
				translate([26,0,-3])cylinder(h=15, r=1.6, $fn=30);
				translate([28.5,-2.5,-3])cylinder(h=15, r=1.6, $fn=30);
			}
			hull(){
				translate([0,26,-3])cylinder(h=15, r=1.6, $fn=30);
				translate([-2.5,28.5,-3])cylinder(h=15, r=1.6, $fn=30);
			}
			/*hull(){
				translate([26,26,-3])cylinder(h=15, r=1.6, $fn=30);
				translate([28.5,28.5,-3])cylinder(h=15, r=1.6, $fn=30);
			}*/
			// Hollow for head screws
			//translate([28.5,-2.5,5])cylinder(h=30, r=3, $fn=30);
			translate([-2.5,-2.5,5])cylinder(h=30, r=3, $fn=30);
			translate([-2.5,28.5,5])cylinder(h=30, r=3, $fn=30);
			// Central hole
			translate([13,13,-2])cylinder(h=15, r=12, $fn=60);
			// Bevel in the NEMA upper left corner
			translate([6,6,-3])cube([30,50,15]);
		}
		// Some rounded corners
		translate([75,6,-1])rotate([0,0,-90])rounded_corner(lg=10);

		translate([9,30,9])rotate([90,-90,0])rounded_corner(lg=10);
		translate([37,30,37])rotate([90,-90,0])rounded_corner(lg=10);
		//#translate([0,0,5])cube([100,50,100]);
	}
	// Rounded corner on bearing right side
	translate([70.4,9.5,8])rotate([0,0,90])rounded_corner(lg=34);
}


module x_motor_idler(){

	difference(){
		// Proform
		union(){
			translate([56,7.8,0])cube([9.5,8,42]);
			translate([59,1,0])cube([21,14,8]);
			translate([56,14.5,0])cube([24,12.5,42]);
			translate([57.45,7.85,0])cylinder(h=42, r=8, $fn=90);
		}
		// Smooth rods
		translate([60,19.38,36.9])rotate([0,90,0])union(){
			translate([0,0,10])cylinder(h=30, r=3.1, $fn=90);
			translate([31.95,0,10])cylinder(h=30, r=3.1, $fn=90);
			// holes for adjustement screws...
			translate([0,0,-20])cylinder(h=30, r=1.6, $fn=50);
			translate([31.95,0,-20])cylinder(h=30, r=1.6, $fn=50);
			/// ... and for the nuts
			//#translate([0,0,0])rotate([0,0,0])cylinder(h=3, r=3.1, $fn=6);
			translate([3.2,-2.8,0])rotate([0,-90,0])cube([3.2,5.6,15]);
			//#translate([32,0,0])cylinder(h=3, r=3.1, $fn=6);
			#translate([43.8,-2.8,0])rotate([0,-90,0])cube([3.2,5.6,15]);
		}
		// LM6UU bearings
		translate([57.45,7.85,-5])cylinder(h=60, r=6.05, $fn=90);
		translate([57,-3,-5])cube([0.5,10,60]);
		// M5 threaded rod
		translate([72.95,7.85,-5])cylinder(h=20, r=2.6, $fn=70);
		translate([72.95,7.85,4])cylinder(h=7, r=4.65, $fn=6);
		
		// Room for belt
		translate([60,15.5,28])rotate([0,90,0])hull(){
			rotate([0,0,45])cube([5.5,5.5,30]);
			translate([14,0,0])rotate([0,0,45])cube([5.5,5.5,30]);
		}
		// Some rounded corners
		translate([75,6,-1])rotate([0,0,-90])rounded_corner(lg=10);
		// Rounded corner on back side
		translate([61,22,-1])rotate([0,0,90])rounded_corner(lg=44);
		// Bevel for belt tensioner
		translate([73,0,21])rotate([0,45,0])cube([20,40,20]);
		// Hole for tensioner screw
		color("grey")translate([30,19.5,21])rotate([0,90,0])
			cylinder(h=150, r=1.6, $fn=80);
		//#translate([0,-5,5])cube([100,50,100]);
	}
	// Rounded corner on bearing right side
	translate([70.4,9.5,8])rotate([0,0,90])rounded_corner(lg=34);
}


module x_belt_tensioner(){

union(){
	difference(){
		hull(){
			cylinder(h=14.5, r=5, $fn=90);
			translate([-5,0,0])cube([10,10,14.5]);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
		translate([-10,-12,4.25])cube([20,20,6]);
		// para estrechar el ancho del portarodamiento
		translate([-12,-9,-3])cube([20,20,6.5]);
		translate([-12,-9,11])cube([20,20,6.5]);
	}
	difference(){
		union(){
			translate([0,0,9.25])cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
			translate([0,0,4])cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
		}
		translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
	}

	rotate([0,0,180])translate([0,-19.8,4.25])difference(){
		translate([-5,0,0])cube([10,11,6]);
		
		translate([0,20,3])rotate([90,0,0])cylinder(h=30, r=1.6, $fn=60);
		translate([-2.75,3,-2])cube([5.5,2.5,10]);
	}
}
}





/* ---------------------------------------------------------------------- */



//mirror([1,0,0])extruder();

//translate([-55,45,21])rotate([90,0,0])NEMA17();

translate([-80,0,0])x_motor_holder();

//mirror([1,0,0])translate([-100,0,0])x_motor_idler();

//color("pink")translate([20,-15,5])rotate([0,90,90])x_belt_tensioner();

