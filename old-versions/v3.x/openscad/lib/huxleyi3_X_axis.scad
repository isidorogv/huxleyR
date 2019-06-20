

module x_motor_holder(){

	difference(){
		// Preform
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
		// NEMA14-17 motor shape
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
            // Rounded corner on bearing right side
            translate([70.4,9.5,8])rotate([0,0,90])rounded_corner(lg=34);
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
			translate([43.8,-2.8,0])rotate([0,-90,0])cube([3.2,5.6,15]);
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
        translate([80,35,21])rotate([90,0,0])cylinder(h=30,r=13,$fn=6);
        //cube([20,40,20]);
		// Hole for tensioner screw
		color("grey")translate([30,19.5,21])rotate([0,90,0])
			cylinder(h=150, r=1.6, $fn=80);
		//#translate([0,-5,5])cube([100,50,100]);
	}
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
            //translate([-12,-9,-4])cube([20,20,6.5]);
            //translate([-12,-9,12])cube([20,20,6.5]);
        }
        // some rounded corners for frame reinforcement
        translate([5,13,1.5])rotate([90,0,-90])rounded_corner(rd=3,lg=10);
        translate([-5,13,13])rotate([-90,0,-90])rounded_corner(rd=3,lg=10);
        
        difference(){
            union(){
                translate([0,0,9.25])
                    cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
                translate([0,0,4])
                    cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
            }
            translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
        }
    
        rotate([0,0,180])translate([0,-19.8,4.25])difference(){
            translate([-5,0,0])cube([10,11,6]);
            
            translate([0,20,3])rotate([90,0,0])
                cylinder(h=30, r=1.6, $fn=60);
            translate([-2.75,3,-2])cube([5.5,2.5,10]);
        }
    }
}


//  dejes = distance between smooth rods
module x_endstop_adj(dejes=32){

	difference(){
		union(){
			hull(){
				// puente de union entre abrazaderas
				translate([10,0,0])cube([5,dejes,10]);
				// abrazaderas de la barra lisa
				union(){
					cylinder(h=10, r=5, $fn=90);
					translate([0,dejes,0])cylinder(h=10, r=5, $fn=90);
				}	
			}
			// orejeta para tuerca prisionera de ajuste
			translate([17,dejes/2,0])union(){
				cylinder(h=10,r=5,$fn=90);
				translate([-5,-5,0])cube([5,10,10]);
				// tuerca prisionera
				%translate([0,0,3.5])rotate([0,0,30])
					cylinder(h=3,r=3.2,$fn=6);
			}
		}
		// barras lisas
		translate([0,0,-5])union(){
			cylinder(h=20, r=3.05, $fn=90);
			translate([0,dejes,0])cylinder(h=20, r=3.05, $fn=90);
		}
	// rebaje para la correa
	translate([-11.5,-10,-5])cube([10,50,20]);
	translate([-9,5,-5])cube([20,dejes-10,20]);
	// hueco para la tuerca prisionera
	translate([17,dejes/2,-5])cylinder(h=20,r=1.6,$fn=60);
	translate([14,9,3.5])cube([8.5,12,3]);
	}
}



