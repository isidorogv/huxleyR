
include <modules.scad>





// pitch = distance between theeth; T2.5 = 2.5, GT2 = 2
// wbelt = belt thickness
// dejes = distance between smooth rods
module x_carriage(pitch = 2.5, wbelt = 0.8, dejes=32){

	// LM6UU bearing and smooth rod (lower)
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
	// LM6UU bearing and smooth rod (upper)
	//%translate([0,38,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	//%translate([-20,38,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);

	difference(){
		union(){
			difference(){
				// old huxley carriage, by ReprapPRO team
				import("x-carriage-1off.stl");
			
				translate([-10,16.7-wbelt,4])cube([60,2,15]);
				translate([-10,dejes+2,-5])cube([60,60,35]);
			}
			color("pink")for (i=[0:15]) {
		    	translate([0+pitch*i, 16.7, 3]) cube([1, 1.5, 12]);  
			}
			translate([40,dejes+16,0])rotate([0,0,180])
				carriage_bearing_holder();
			color("orange")translate([0,dejes+14.1,0])cube([40,7,15]);
		}
		translate([0,dejes-32,0]){
			// upper M3 screw holes
			// screw holes
			translate([7.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
			translate([32.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
			// holes for screw heads
			translate([7.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
			translate([32.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
			// Some rounded corners
			translate([35,48.1,-10])rounded_corner();
			translate([5,48.1,-10])rotate([0,0,90])rounded_corner();
			}
		// lower M3 screw drills
		// screw holes
		translate([7.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		translate([32.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		// holes for screw heads
		translate([7.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
		translate([32.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
	}
}




module carriage_bearing_holder(){

	difference(){
		// old huxley carriage, by ReprapPRO team
		import("x-carriage-1off.stl");
	
		translate([-10,16.2,-4]) cube([60,60,25]);
	}
	// LM6UU bearing and smooth rod
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
}




module idler(){
    
    difference(){
        import("idler.stl");
        
        translate([0,10,7])difference(){
            #cylinder(h=10,r=7.5,$fn=60);            
            translate([0,0,-2])cylinder(h=20,r=2.05,$fn=60);
        }
        //#translate([0,-3.5,0])rotate([0,0,45])cube([20,20,20]);
        translate([0,10,-5])cylinder(h=20,r=2.1,$fn=60); 
    }
    difference(){
        color("red")translate([0,10,5])cylinder(h=2.4,r=3,$fn=60); 
        translate([0,10,0])cylinder(h=20,r=2.1,$fn=60); 
    }
}





module soporte_portaextrusor(erods=false){
    
    // if erods -> smooth rods distance = 30+offset else 30
    offset=erods?2:0;
    
    difference(){
        union(){
            translate([0,11,0])cube([40,40,5]);
            translate([0,35,0])cube([40,18,25]);
        }
        // M3 drill fixing holes
        translate([7.5,24-offset,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([32.5,24-offset,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([7.5,48.5,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([32.5,48.5,-5])cylinder(h=25,r=1.6,$fn=60);
        // M3 nut holes for fixing the motor holder to the carriage
        translate([7.5,24-offset,2])rotate([0,0,30])
            cylinder(h=5,r=3.2,$fn=6);
        translate([32.5,24-offset,2])rotate([0,0,30])
            cylinder(h=5,r=3.2,$fn=6);
        translate([7.5,48.5,2])rotate([0,0,30])
            cylinder(h=3,r=3.2,$fn=6);
        translate([32.5,48.5,2])rotate([0,0,30])
            cylinder(h=3,r=3.2,$fn=6);
        translate([4.8,48,2])cube([5.5,10,3]);
        translate([29.8,48,2])cube([5.5,10,3]);
        // M3 nut holes for hotend
        translate([7.5,38,20])rotate([0,0,0])union(){
            translate([0,0,-5])cylinder(h=25,r=1.6,$fn=60);
            translate([])rotate([0,0,30])
                cylinder(h=3,r=3.2,$fn=6);
            translate([-2.75,0,0])cube([5.5,20,3]);
        }
        translate([23.5,38,20])rotate([0,0,0])union(){        
            translate([0,0,-5])cylinder(h=25,r=1.6,$fn=60);
            translate([])rotate([0,0,30])
                cylinder(h=3,r=3.2,$fn=6);
            translate([-2.75,0,0])cube([5.5,20,3]);
        }
        // some rounded corners
        translate([35,48,-2])rounded_corner();
        translate([5,48,-2])rotate([0,0,90])rounded_corner();
        translate([-5,16,0])rotate([0,-90,180])rounded_corner(lg=50);
        // vaciado interno
        /*translate([20,23,-2])hull(){
            cylinder(h=50,r=5,$fn=50);
            translate([0,20,0])cylinder(h=50,r=5,$fn=50);
        }*/
    }
    //translate([25,28,12])rotate([0,90,0])rounded_corner(lg=15,rd=7);
    translate([0,28,12])rotate([0,90,0])rounded_corner(lg=40,rd=7);
}



module extruder(){
    difference(){
        union(){
            difference(){
                union(){
                    // porta-fusor
                    color("pink")translate([-1,35,40])
                        cube([NEMA17+2,24,14]);
                    // paso para el hilo através del hobbed
                    color("orange")translate([9.5,59,40])
                        cube([10,15,14]);
                    color("lightblue")translate([7.5,70,40])
                        cube([12,30,14]);
                }
                // rounded corner on filament pass
                translate([10.5,83.95,35])rotate([0,0,180])
                    rounded_corner(rd=3);
                translate([15.5,29.5,49])rotate([-90,180,0])
                    merlinhotendhead(vinsert=true);
                translate([(NEMA17/2)-1,74,40])nema17drills();
                translate([(NEMA17/2)-1,74,50])nema17drills(hg=3,dia=7);
                // M3 nut holes for hotend
                translate([3,40,35])rotate([0,0,90])union(){
                    translate([-2,-4.5,0])
                        cylinder(h=25,r=1.6,$fn=60);    
                    translate([-2,-20.5,0])
                        cylinder(h=25,r=1.6,$fn=60);
                }
                // M4 drill for spring
                translate([10,94.5,50])rotate([0,90,0])union(){ 
                    cylinder(h=3,r=4.2,$fn=6);
                    translate([0,0,-12])cylinder(h=15,r=2.1,$fn=50);
                    translate([-10,-3.55,0])cube([10,7.1,3]);
                }
            }
        }
        // biseles laterales en porta-fusor
        translate([-5,49,45])rotate([0,0,45])cube([20,20,20]);
        translate([45,51,45])rotate([0,0,50])cube([20,20,20]);
        translate([41,54.3,38])cube([2.5,5,20]);
        translate([43,52.65,38])rotate([0,0,50])cube([1.5,2.65,20]);
        // fijacion de tobera ventilador
        translate([39,48,50])rotate([0,90,0])union(){ 
            cylinder(h=3,r=3.2,$fn=6);
            translate([0,0,-5])cylinder(h=15,r=1.6,$fn=50);
            translate([0,-2.75,0])cube([15,5.5,3]);
        }
        // paso del hilo por el hobbed mk8
        translate([(NEMA17/2)-1,74,30])cylinder(h=50,r=5,$fn=50);
        // 624ZZ bearing
        translate([8.5,74,20])cylinder(h=50,r=7.2,$fn=70);
        // collar saliente del motor
        translate([(NEMA17/2)-1,74,39.5])cylinder(h=3,r=12.5,$fn=90);
    }
    // soporte para el motor
    difference(){
        translate([(NEMA17/2)-1,74,40])nema17collar();
    
        translate([4.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
        //translate([35.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
        //translate([35.5,58.5,43])cylinder(h=10,r=3.6,$fn=70);    
    }
}



module mount(){

    difference(){
        // hotend holder
        color("lightgrey")translate([-1,35,54])
                            cube([NEMA17+2,17.5,5]);
        // merlin hotend head
        translate([15.5,29.5,49])rotate([-90,0,0])
                        merlinhotendhead(vinsert=true);
        // M3 nut holes for fixing the hotend
        translate([3,40,45])rotate([0,0,90])union(){
            translate([-2,-4.5,0])cylinder(h=25,r=1.6,$fn=60);    
            translate([-2,-20.5,0])cylinder(h=25,r=1.6,$fn=60);
        }
        // Rounded corner
        translate([50,47.5,54])rotate([0,-90,0])rounded_corner(lg=60);
    }
}


// hefan = fan outlet for hotend cooling
module tobera(l=45,hefan=true){
    
    difference(){
        union(){
            // cuerpo principal
            difference(){
                difference(){
                    cube([14,19,l+5]);
                
                    translate([2,2,-5])cube([10,15,1.5*l]);
                    translate([0,16,2.75*l/1.8])rotate([0,90,0])
                        cylinder(h=35,r=25,$fn=90);
                }
                // borde de encaje en ventilador axial
                translate([0,0,l-5])difference(){
                    translate([-2,-3,0])cube([20,25,10]);
                
                    translate([1,1,-2])cube([12,17,15]);
                }
            }
            // tornillo fijador superior
            translate([0,9.5,l-10])rotate([0,90,0])
                cylinder(h=14,r=3.5,$fn=80);
            // Portainductivo
            translate([13.5,3.5,0])difference(){
                hull(){
                    cube([6,12,10]);
                    translate([6,6,0])cylinder(h=10,r=6,$fn=80);
                }
                translate([6,6,-2])cylinder(h=25,r=4.1,$fn=60);
                translate([6,5.5,-2])cube([12,1,25]);
            }
        }
        // taladro tornillo fijador superior
        translate([-5,9.5,l-10])rotate([0,90,0])
            cylinder(h=30,r=1.6,$fn=80);
        translate([12,9.5,l-10])rotate([0,90,0])
            cylinder(h=5,r=3.2,$fn=60);
        // taladro tornillo fijador inferior...
        translate([-5,9.5,3.5])rotate([0,90,0])
            cylinder(h=25,r=1.6,$fn=80);
        // ...contratuerca...
        translate([13.5,9.5,3.5])rotate([30,0,0])rotate([0,90,0])
            cylinder(h=5,r=3.2,$fn=6);
        // ...y cabeza del tornillo
        //translate([-2.5,9.5,3.5])rotate([0,90,0])
        //    cylinder(h=5,r=3.5,$fn=80);
        // rendija de ventilacion superior, solo si se necesita
        if (hefan) translate([-2,2,l-30])cube([10,15,2]);
        // test: plano de corte
        //color("red")translate([-20,-20,-l/2])cube([60,30,2*l]);
    }
    // plano de ventilacion superior
    if (hefan){
        translate([-2,19,l-22])rotate([90,0,0])difference(){
            cylinder(h=19,r=10,$fn=60);
        
            translate([0,0,-5])cylinder(h=40,r=9,$fn=60);
            translate([-15,0,-5])cube([30,20,30]);
            translate([-17.5,-15,-5])cube([20,30,30]);
        }
    }
}



module escape(){

    difference(){
        union(){
            translate([0,0,1.9])difference(){
                cube([10,15,7]);
                translate([1,1,-2])cube([8,13,15]);
            }
        // tornillo fijador
        translate([1,7.5,5.5])rotate([0,90,0])
            cylinder(h=8,r=2.6,$fn=80);
        }
        // taladro tornillo fijador
        translate([-5,7.5,5.5])rotate([0,90,0])
            cylinder(h=30,r=1.6,$fn=80);
    }
    difference(){
        color("grey")hull(){
            translate([-2,-2,0])difference(){
                cube([14,19,2]);
                translate([2,2,-2])cube([10,15,15]);
            }
            
            translate([-18,-2,-16])cube([5,19,1]);
        }
        hull(){
            translate([1,1,1])cube([8,13,1]);
                  
            translate([-16.6,1,-16])cube([1,13,1]);
        }
        translate([-18,-8,-20])rotate([0,-20,0])cube([5,30,10]);
        // test: plano de corte
        //color("crimson")translate([-40,-12,-18])cube([60,20,30]);
    }
}



// -----------------------------------------



//x_carriage();

//mirror()idler();
//translate([(NEMA17/2)-1,74,57])rotate([0,180,0])hobbed_mk8();
//mirror()
//translate([0,0,15])soporte_portaextrusor(erods=true);
//translate([(NEMA17/2)-1,74,21])NEMA17();
/*
mirror(){
    extruder();
    mount();
}*/

//translate([16,-2,50])rotate([-90,-90,0])import("merlin_hotend.stl");

/*
translate([41,13,59.5])rotate([-90,0,0])union(){

    translate([2,0,0])tobera();
    translate([4,2,-2])escape();
}*/

tobera();

