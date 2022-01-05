
// pitch = paso para los dientes de la polea T2.5 = 2.5, GT2 = 2


module x_carriage(pitch = 2.5){

	difference(){
		import("x-carriage-1off.stl");
	
		translate([-10,16.2,4])cube([60,1.5,15]);
	}
	color("pink")for (i=[0:15]) {
    	translate([0+pitch*i, 16.7, 3]) cube([1, 1.5, 12]);  
	}
}


module x_carriage_02(){

	difference(){
		import("x-carriage-1off.stl");
	
		translate([-10,16.2,4]) cube([60,15,15]);
		translate([20,24,-15])cylinder(h=40, r=1.6, $fn=30);
		translate([20,24,-2])cylinder(h=5, r=3.1, $fn=6);
		
		translate([7.5,22,-15])cylinder(h=40, r=1.6, $fn=30);
		translate([7.5,22,-2])cylinder(h=5, r=3.1, $fn=6);

		translate([32.5,22,-15])cylinder(h=40, r=1.6, $fn=30);
		translate([32.5,22,-2])cylinder(h=5, r=3.1, $fn=6);
	}
}


module belt_clamp(pitch = 2.5){
	difference(){	
		color("pink")hull(){
		
			translate([0,17.2,4])cube([40,7,11]);
			translate([20,24,4])cylinder(h=11, r=4, $fn=60);
		}
		union(){
		color("red")translate([20,24,-10])cylinder(h=40, r=1.6, $fn=30);
		color("orange")translate([20,24,13])cylinder(h=10, r=2.8, $fn=30);

		translate([7.5,22,-15])cylinder(h=40, r=1.6, $fn=30);
		translate([32.5,22,-15])cylinder(h=40, r=1.6, $fn=30);

		for (i=[0:20]) {
	    	translate([0+pitch*i, 16.3, 2]) cube([1.6, 1.5, 15]);  
		}
		translate([18,15,3])cube([4,5,15]);
		}
	}
}


module hotend_holder_01(){
	difference(){
		//difference(){
				union(){
					import("nozzle-mount-huxley.stl");
					translate([-20,-1,0])cube([40,12,12]);
				}
				union(){
					// canal central para el hilo y el racor pneufit.
					translate([0,-25,7.5])rotate([-90,0,0])
						cylinder(h=45, r=4.55, $fn=35);
					translate([-25,-8,4.5])cube([50,38,10]);
					//translate([-7.5,15,5])cube([15,15,10]);
				}
		//}
		// agujeros parte inferior.
		union(){
			translate([-12.5,2.9,-3])cylinder(h=10,r=1.6,$fn=30);
			translate([-12.5,2.9,0.8])cylinder(h=2.1,r1=1,r2=3.1,$fn=30);
			translate([-12.5,2.9,2.9])cylinder(h=5,r=3.1,$fn=30);
		
			translate([12.5,2.9,-3])cylinder(h=10,r=1.6,$fn=30);
			translate([12.5,2.9,0.8])cylinder(h=2.1,r1=1,r2=3.1,$fn=30);
			translate([12.5,2.9,2.9])cylinder(h=5,r=3.1,$fn=30);

		}
	}
	// collar para evitar sobreesfuerzos en el bowden.
/*	#difference(){
		translate([0,20,9])rotate([-90,0,0])
			cylinder(h=7.5, r=6.25, $fn=50);
		translate([0,18,9])rotate([-90,0,0])
			cylinder(h=15, r=2.1, $fn=50);
	}*/
	// tope para el final de carrera
/*	translate([16.8,15,-1])rotate([0,90,0])difference(){
		cylinder(h=3, r=10, $fn=80);
		translate([-5,-30,-2])cube([20,50,8]);
	}
	translate([-19.8,15,-1])rotate([0,90,0])difference(){
		cylinder(h=3, r=10, $fn=80);
		translate([-5,-30,-2])cube([20,50,8]);
	}*/
}


module hotend_holder_02(){
	difference(){
		difference(){
				union(){
					import("nozzle-mount-huxley.stl");
					translate([-20,-1,0])cube([40,12,12]);
				}
				union(){
					//translate([0,-5,7.5])rotate([-90,0,0])
						//cylinder(h=45, r=4.55, $fn=35);
					//translate([-25,8,4.5])cube([50,38,10]);
					//translate([-4.55,-10,7.55]) cube([9.1,20,7]);
					translate([-25,-10,4.5])cube([50,50,10]);
				}
		}
		/*union(){
			rotate([90,0,0])translate([7.5,8.15,-15])
				cylinder(h=25,r=1.65,$fn=30);
			rotate([90,0,0])translate([-7.5,8.15,-15])
				cylinder(h=25,r=1.65,$fn=30);
			translate([5.85,-10,8])cube([3.3,25,10]);
			translate([-9.15,-10,8])cube([3.3,25,10]);
			// huecos para amarrar el porta inductivo
			translate([-15,-1,8.5])rotate([0,-90,-90]){
				translate([0,0,-1])cylinder(h=12, r=1.6, $fn=30);
				translate([0,0,3])
					cylinder(h=3, r=3.2, $fn=6);
				translate([0,-2.75,3])
					cube([10,5.5,3]);
			}
			translate([15,-1,8.5])rotate([0,-90,-90]){
				translate([0,0,-1])cylinder(h=12, r=1.6, $fn=30);
				translate([0,0,3])
					cylinder(h=3, r=3.2, $fn=6);
				translate([0,-2.75,3])
					cube([10,5.5,3]);
			}*/
		//}
	}
}


module porta_inductivo_01(){

	difference(){
		union(){
			cylinder(h=3, r=7, $fn=80);
			translate([0,-7,0])cube([8,14,3]);
		}			
		translate([0,0,-1])cylinder(h=5, r=4.1, $fn=80);
	}
	difference(){
	translate([1,0,0])hull(){
		translate([11,0,12])rotate([0,-90,0])cylinder(h=5, r=5, $fn=80);
		translate([6,-7,0])cube([5,14,3]);
	}
	translate([14,0,12])rotate([0,-90,0])cylinder(h=8, r=1.6, $fn=40);
	translate([10,0,12])rotate([0,-90,0])cylinder(h=5, r=2.8, $fn=40);
	}
}


module porta_inductivo_02(diametro = 8){

	color("orange")difference(){
		union(){
			cylinder(h=25, r=1.5*diametro/2, $fn=80);
			translate([0,-3.5,0])cube([(1.5*diametro/2)+4.5,7,3]);
			translate([(1.5*diametro/2)+4.5,0,0])
				cylinder(h=3, r=3.5, $fn=80);
		}
	translate([0,0,-2])cylinder(h=50, r=diametro/2, $fn=80);
	translate([(1.5*diametro/2)+4.5,0,-2])cylinder(h=10, r=1.6, $fn=30);	
	translate([-7,-10,0])rotate([-90,0,0])cylinder(h=20, r=10, $fn=90);	
	}
}


module porta_inductivo(diametro = 8){

	color("orange")difference(){
		union(){
			cylinder(h=25, r=1.5*diametro/2, $fn=80);
			translate([0,-3.5,0])cube([(1.5*diametro/2)+5,7,3]);
			translate([(1.5*diametro/2)+5,0,0])
				cylinder(h=3, r=3.5, $fn=80);
		}
	#translate([0,0,-2])cylinder(h=50, r=(diametro/2)-0.1, $fn=80);
	translate([(1.5*diametro/2)+5,0,-2])cylinder(h=10, r=1.6, $fn=30);	
	translate([-32,-20,-5])cube([30,50,50]);	

	}
}


module hobbed_mk7(){

	difference(){
		union(){
			cylinder(h=9, r=6.7, $fn=50);
			translate([0,0,9])cylinder(h=1.5, r1=6.7, r2=5.2, $fn=50);
			translate([0,0,10.5])cylinder(h=1.5, r1=5.2, r2=6.7, $fn=50);
			translate([0,0,12])cylinder(h=2, r=6.7, $fn=50);
		}
		translate([0,0,-5])cylinder(h=20, r=2.5, $fn=50);
	}
}


module NEMA14(){

color("black")cube([34,34,36], center=true);
color("white")translate([0,0,18])cylinder(h=2, r=11, $fn=80);
color("gray")translate([0,0,-28])cylinder(h=66, r=2.5, $fn=80);

translate([0,0,21])hobbed_mk7();
}


module porta_inductivo_03(){
	difference(){
		union(){
			translate([0,-12,0])cube([12,24,5]);
			translate([0,0,0])cylinder(h=5, r=12, $fn=50);
		}
		translate([0,0,-5])cylinder(h=15, r=6.15, $fn=50);
	}
		
	difference(){
		
		hull(){
			translate([12,-12,0])cube([5,24,5]);
			
			translate([12,7.5,21])rotate([0,90,0])
				cylinder(h=5, r=4, $fn=30);
			translate([12,-7.50,21])rotate([0,90,0])
				cylinder(h=5, r=4, $fn=30);
		}	
		translate([10,7.5,20])rotate([0,90,0])
			cylinder(h=15, r=1.6, $fn=30);
		translate([10,-7.50,20])rotate([0,90,0])
			cylinder(h=15, r=1.6, $fn=30);
		translate([10,7.50,20])rotate([0,90,0])
			cylinder(h=5, r=3.2, $fn=6);
		translate([10,-7.50,20])rotate([0,90,0])
			cylinder(h=5, r=3.2, $fn=6);
	}
}


module porta_inductivo_04(diametro = 12){

	difference(){
		
		hull(){
			translate([12,-12,0])cube([5,24,5]);
			
			translate([12,7.5,21])rotate([0,90,0])
				cylinder(h=5, r=4, $fn=30);
			translate([12,-7.50,21])rotate([0,90,0])
				cylinder(h=5, r=4, $fn=30);
		}	
		translate([10,7.5,20])rotate([0,90,0])
			cylinder(h=15, r=1.6, $fn=30);
		translate([10,-7.50,20])rotate([0,90,0])
			cylinder(h=15, r=1.6, $fn=30);
		translate([10,7.50,20])rotate([0,90,0])
			cylinder(h=5, r=3.2, $fn=6);
		translate([10,-7.50,20])rotate([0,90,0])
			cylinder(h=5, r=3.2, $fn=6);
	}

	translate([5,0,0])difference(){

		cylinder(h=15, r=1.5*diametro/2, $fn=80);

		translate([0,0,-2])cylinder(h=50, r=(diametro/2)-0.1, $fn=80);
		translate([(1.5*diametro/2)+5,0,-2])cylinder(h=10, r=1.6, $fn=30);	
		translate([-32.5,-20,-5])cube([30,50,50]);	

	}
}

module sample_00(){
    difference(){
        difference(){
                union(){
                    import("nozzle-mount-huxley.stl");
                    translate([-20,-1,0])cube([40,12,12]);
                }
                union(){
                    rotate([-90,0,0]) translate([0,-7.5,-12]) cylinder(h=45, r=4.55, $fn=35);
                    translate([-25,8,4.5]) cube([50,50,10]);
                    translate([-7,9,8]) cube([14,2,7]);
                    translate([-4.55,-10,7.55]) cube([9.1,20,7]);
                }
        }
    
    
        union(){
        
        translate([12.5,2.9,-3])cylinder(h=20,r=1.7,$fn=30);
        //translate([12.5,2.9,3])cylinder(h=20,r=3,$fn=30);
    
        translate([-12.5,2.9,-3])cylinder(h=20,r=1.7,$fn=30);
        //translate([-12.5,2.9,3])cylinder(h=20,r=3,$fn=30);
    
        rotate([90,0,0])translate([7.5,8.15,-15])cylinder(h=25,r=1.65,$fn=30);
        rotate([90,0,0])translate([-7.5,8.15,-15])cylinder(h=25,r=1.65,$fn=30);
        translate([5.85,-10,8])cube([3.3,25,10]);
        translate([-9.15,-10,8])cube([3.3,25,10]);
        
        
        }
    }
}


module sample_01(){
    difference(){
        import("nozzle-mount-huxley.stl");
    
        union(){
            rotate([-90,0,0]) translate([0,-6.5,2]) 
                cylinder(h=28, r=4.55, $fn=35);
            translate([-10,10,5]) cube([20,20,10]);
            translate([-7,9,8]) cube([14,2,7]);
            translate([-4.55,-10,7.55]) cube([9.1,20,7]);
        }
    }
}


/* ------------------------------------------------ */

//sample_00();
//sample_01();

//translate([-6.5,35,39])rotate([180,0,0])NEMA14();

//x_carriage();
//translate([-50,-15,-4])belt_clamp(pitch = 2.5);
difference(){
	union(){
		hotend_holder_01();
		translate([-20,-15,0])cube([40,15,4.5]);
	}
	// canal central
		translate([0,0,-5])hull(){
		translate([0,20,0])cylinder(h=10, r=3.5, $fn=60);
		translate([0,0,0])cylinder(h=10, r=3.5, $fn=60);
	}
}
//translate([0,-23,0])hotend_holder_02();

//translate([-35,0,0])porta_inductivo(diametro=12);
//translate([-35,30,0])porta_inductivo_04();
difference(){
	union(){
		color("pink")translate([-25,-5.5,0])cube([7.8,11,15]);
		color("pink")translate([17.2,-5.5,0])cube([7.8,11,15]);
	}

	translate([6.5,-40,8.5])rotate([0,-90,-90])color("red")
	union(){
			// amarres laterales
			translate([-4,10.5,36])cube([16,5,8]);			
			translate([0,10.6,40])rotate([-90,0,0])union(){	
				cylinder(h=15, r=1.5, $fn=30);	
			}

			translate([-4,-28.5,36])cube([16,5,8]);			
			translate([0,-23.6,40])rotate([-90,0,180])union(){	
				cylinder(h=15, r=1.5, $fn=30);	
			}
	}
}