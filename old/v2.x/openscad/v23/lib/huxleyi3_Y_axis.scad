
/*
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
module foot(perfil = fondop){

	color("orange")difference(){
		
		cube([perfil+15,43,perfil+2.5]);
	
	
		translate([2.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		translate([perfil+5.5,2.5,2.5])cube([perfil+0.2,45,perfil+5]);
		// beveled corners
		translate([-5,55,7])rotate([45,0,0])cube([45,45,45]);
		translate([2*perfil,-5,12])rotate([0,-50,0])cube([45,45,45]);	
		translate([2*perfil,1.2*perfil,-5])rotate([0,0,45])
            cube([45,45,45]);	
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
*/


// hg = piece height (here we have no wall thickness)
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
module y_motor_holder(hg=7, perfil=fondop){

	portamotor_14(ht=hg);

	// fake aluminum slot
	// translate([2,-26,0])color("grey")cube([fondop,fondop,10]);

	translate([-0.6,(-perfil/2)-4,hg/2])rotate([0,90,0])
		difference(){
			hull(){
				translate([-hg/2,0,0])cube([hg,perfil/2,2.5]);
				cylinder(h=2.5, r=hg/2, $fn=60);
			}
		translate([0,0,-2])cylinder(h=10, r=1.6, $fn=60);
	}
	translate([perfil-0.5+2.5,(-perfil/2)-4,hg/2])rotate([0,90,0])
		difference(){
			hull(){
				translate([-hg/2,0,0])cube([hg,perfil/2,2.5]);
				cylinder(h=2.5, r=hg/2, $fn=60);
			}
		translate([0,0,-2])cylinder(h=10, r=1.6, $fn=60);
	}
	color("cyan")translate([-0.46,-7.55,0])rotate([0,0,45])
		cube([3,5,hg]);
	color("cyan")translate([perfil+2.35,-5.4,0])rotate([0,0,-45])
		cube([3,5,hg]);

}


// bearing 623ZZ idler for Y axis
module y_bearing_idler(){

    // bearing holder
	translate([1.75,0,0])union(){
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
				translate([0,0,9.25])
                    cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
				translate([0,0,4])
                    cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
			}
			translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
		}
    }
        // bearing holder fixing part
        translate([6-((altop+18)/2),10,14.5])rotate([0,90,0])difference(){
            translate([0,-2,-6])cube([14.5,2,altop+19.5]);
            
            translate([7.5,10,-1.25])rotate([90,0,0])cylinder(h=15,r=1.6,$fn=60);
            translate([7.5,10,28.75])rotate([90,0,0])cylinder(h=15,r=1.6,$fn=60);
        }
}



module y_slot_clamp(){
    
    // slot clamp
    color("maroon")translate([13,10,0])rotate([0,-90,0])difference(){
        union(){
            cube([14.5,fondop+10,altop+20]);
            //translate([0,0,altop+6])cube([14.5,5,3]);
            //translate([0,0,-3])cube([14.5,5,3]);
        }
        // slot hollow       
        translate([-2,-1,9])cube([20,fondop+5,altop+2]);
        // drills for tensioner screw
        #translate([7,fondop+2,(altop/2)+10])rotate([-90,0,0])union(){
            cylinder(h=14,r=1.6,$fn=60);
            cylinder(h=5,r=3.2,$fn=6);
        }
        translate([-2,0,-20])rotate([10,0,0])cube([20,2*fondop,20]);
        translate([-2,-5,40.5])rotate([-10,0,0])cube([20,2*fondop,20]);
        // drill holes for fixing the bearing holder
        translate([7,38,5])rotate([90,0,0])union(){
            cylinder(h=40,r=1.6,$fn=60);
            cylinder(h=35,r=3.2,$fn=6);
        }
        translate([7,38,35])rotate([90,0,0])union(){
            cylinder(h=40,r=1.6,$fn=60);
            cylinder(h=35,r=3.2,$fn=6);
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




module y_bearing_holder(){

	difference(){
		union(){			
			translate([0,0,-2])hull(){
				translate([0,0,-7.7])cube([13.5,16.5,5]);
				translate([12.15,22.25,-7.7])
                    cylinder(h=5,r=5,$fn=60);
			}
			
			translate([0,0,-2])hull(){
				translate([54.8,0,-7.7])cube([13.5,16.5,5]);
				translate([56.15,22.25,-7.7])
                    cylinder(h=5,r=5,$fn=60);
			}
			
			color("cyan")translate([0,-1.50,-7]){
				translate([0,-1,-2.7])cube([68.3,18.5,5]);
			}
			// LM6UU bearing clamps
			color("orange")translate([3.3,-2.5,-4.7])
                cube([15,18.5,4.75]);
			color("orange")translate([49.8,-2.5,-4.7])
                cube([15,18.5,4.75]);
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



// adjustement piece for Y end stop (piece 1)
module y_endstop_adj(){
    difference(){
        
        union(){
            cylinder(h=3,r=5,$fn=60);
            translate([0,-5,0])cube([14,10,3]);
        }
        hull(){
            
            translate([-1,0,-2])cylinder(h=10,r=1.6,$fn=60);
            translate([3,0,-2])cylinder(h=10,r=1.6,$fn=60);
            
        }
    }
    
    translate([14,0,-13])rotate([0,90,0])difference(){
        
        hg=16;
        
        union(){
            cylinder(h=hg,r=5,$fn=60);
            translate([-16,-5,0])cube([16,10,hg]);
        }
        
        translate([-6,-10,hg-6.5])cube([6,20,3]);
        translate([-3,0,-5])cylinder(h=2*hg,r=1.6,$fn=60);
        translate([-32,-10,18])rotate([0,45,0])cube([20,20,40]);
    }
}
