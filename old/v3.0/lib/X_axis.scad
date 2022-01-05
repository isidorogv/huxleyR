//------------------------------------------------------------
//-- X axis modules for Huxley i3 3D printer
//------------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module x_carriage(wbelt=0.8,daxis=30,wd=40,th=15,rbearing=rlm6){

// wbelt = belt thickness
// daxis = distance between smooth rods in mm
// wd = carriage lenght form left to right in mm
// th = carriage thickness in mm
    
    // fake bearings and rods, just for reference
    %union(){
        // LM6UU bearing and smooth rod (upper)
        translate([0,8,9])
        rotate([0,90,0])
            cylinder(h=wd,r=6.1);
        translate([-20,8,9])
        rotate([0,90,0])
            cylinder(h=2*wd,r=3);
        // LM6UU bearing and smooth rod (lower)
        translate([0,daxis+8,9])
        rotate([0,90,0])
            cylinder(h=wd,r=6.1);
        translate([-20,daxis+8,9])
        rotate([0,90,0])
            cylinder(h=2*wd,r=3);
	}
    
    difference(){
        // base
        cube([wd,daxis+21,th]);
        
        // bearing clamps
        for(offset=[0,daxis]){
            translate([-1,offset+8,9])
            rotate([0,90,0])
                cylinder(h=wd+2,r=6.1);
            translate([-1,offset-2,9])
                cube([wd+2,14,rbearing+1]);
        }
        // belt room
        translate([-1,25.5,5])
            cube([wd+2,6.5,th+2]);
        // belt clamps
        for(feat=[[0,0],[12,1]]){
            translate([feat[0]+14,20,5])
            mirror([feat[1],0,0])
                x_belt_clamp(wb=wbelt);
        }
        // M3 fixing extruder screw drills
        // screw drill + screw head hole recess
        for(pos=[[8.5,48.5,-3],
                [31.5,48.5,-3],
                [14,20,-3],
                [26,20,-3]]){
            translate(pos){
                cylinder(h=25,r=1.6);
                cylinder(h=5,r=3.4);
            }
        }
        // x endstop drills
        for(x=[5,35]){
            translate([x,22,12])
                cylinder(h=15,r=1.2);
        }
        // Upper rounded corners
        translate([35,daxis+16.1,-10])
            rounded_corner();
        translate([5,daxis+16.1,-10])
        rotate([0,0,90])
            rounded_corner();
    }
    // these parts are for avoiding loose LM bearings
    for(x=[15,24]){
        for(y=[0,30]){
            translate([x,y,0])
                cube([1,2.5*rbearing,3.5]);
        }
    }
}


module x_belt_clamp(wb=1.1){

// Auxiliar module, not directly used.
    
// wb = belt thickness
    
    // main body
    union(){
        hull(){
            cylinder(h=15,r=4,$fn=30);
            translate([-5,-3,0])
                cylinder(h=15,r=1,$fn=30);
        }
        translate([-20,-4,0])
            cube([20,2.5*wb,15]);
    }
    // screw drill
    translate([0,0,-6])
        cylinder(h=30,r=1.6,$fn=30);
    // bevel for ease belt placement
    // in slot zone...
    translate([0,-3,10])
    rotate([0,-90,0])
        cylinder(h=16,r=2,$fn=4);
    // ... and in pivot zone
    translate([0,0,5.5])
        cylinder(h=6,r1=2,r2=6);    
}


module slot_clamp(profile=wslot,h=NEMA17,ssize=5){

// Auxiliar module for motor holder and idler, 
    // DO NOT print it!
    
    // angle base
    difference(){
        cube([profile+thwall,profile+thwall,h]);
        translate([thwall-ease/2,thwall-ease/2,-1])
            cube([profile+ease,profile+ease,h+2]);
    }
    // slot pieces
    translate([thwall-ease,(profile-ssize)/2+thwall,0])
        cube([3.5,ssize,h]);
    translate([(profile-ssize)/2+thwall,thwall-ease,0])
        cube([ssize,3.5,h]);
    // fake profile for reference
    %translate([thwall,thwall,-10])
        cube([profile,profile,100]);
}


module x_bearing_holder(span=13){
    
    // main body
    difference(){
        // base preform
        translate([-4,-3.4,0])
        linear_extrude(height=span)
        offset(delta=2,chamfer=true)
            square([16,7]);
        
        // room for synchronic bearing
        translate([-12,-10,(span-9)/2])
            cube([20,20,9]);
        // M3 axis drill
        translate([0,0,-1])
            cylinder(h=span+2,r=1.4);
        // drill for M3 belt tensioner screw (head+thread)
        translate([7,0,span/2])
        rotate([0,90,0])
        union(){
            rotate([0,0,30])
                cylinder(h=3,r=3.5,$fn=6);
            cylinder(h=10,r=1.6);
        }
    }
    // fake synchronic bearing
    %translate([0,0,(span-9)/2])
    union(){
        cylinder(h=1,d=14);
        cylinder(h=9,d=10);
        translate([0,0,8])
            cylinder(h=1,d=14);
    }
}


module x_motor_holder(th=12){

// th = motor plate thickness in mm
    
	difference(){
		// Preform
        union(){
            // base
            x_motor_idler(idler=false);
            translate([28,31,NEMA17/2])
            rotate([-90,180,0])
            mirror([0,0,1])
                motor_plate(stepper=17,
                            notch=true,
                            chamcor=false,
                            thick=th);
            // reinforcement
            translate([48,25,0])
                cube([9,6,42]);
            translate([47,16,0])
                rounded_corner(lg=NEMA17,rd=9);
            //translate([45.5,13.5,0])
              //  cube([4,12,42]);
		}
        // Smooth rods
		translate([48,19.5,21])
        rotate([0,90,0])
        for(x=[-16,16]){
			translate([x,0,10])
                cylinder(h=30,r=3.1);
		}
		// Room for belt
		translate([25,19.5,21])
        rotate([0,90,0])
        hull(){
            for(x=[-5.5,5.5]){
                translate([x,0,0])
                    cylinder(h=70,r=6.6,$fn=4);
            }
		}
        // fixing nuts recess for wire fastener
        translate([28,28,0])
        rotate([0,0,90])
        for(y=[-8,8]){
            translate([0,y,4]){
                cylinder(h=10,r=1.6,center=true);
                cube([th+2,5.2,3],center=true);
            }
        }
        // rounded corner
        translate([60,13.5,-1])
        rotate([0,0,180])
            rounded_corner(lg=NEMA17+2,rd=4);
	}
}


module x_motor_idler(idler=true){

// idler = if this module is going to be used
// in the motor holder or not. By default is NOT USED.
    
	difference(){
		// Proform
		//translate([0,0,0])
        union(){
            // base
			translate([56,9.5,0])
                cube([24,18,42]);
            translate([64,0,0])
                cube([16,11,42]);
            // Rounded internal corner on slot clamp-idler
            translate([51,25,0])
                rounded_corner(lg=42);
            translate([60,5.5,0])
                rounded_corner(lg=42,rd=4);
		}
		// Smooth rods
		#translate([50,19.5,21])
        rotate([0,90,0])
        for(x=[-16,16]){
			translate([x,0,10])
                cylinder(h=30,r=3.1);
		}
        // M5 threaded rod and nut drills
        #translate([71.95,4,4])
        union(){
            // M5 threaded rod
            translate([0,0,-5])
                cylinder(h=50,d=5.5);
            // room for M5 nut
            translate([-4-ease/2,-8,0])
                cube([8+ease,16,5.2]);
        }
		// Room for belt
		translate([60,19.5,21])
        rotate([0,90,0])
        hull(){
            for(x=[-5.5,5.5]){
                translate([x,0,0])
                    cylinder(h=30,r=6.6,$fn=4);
            }
		}
		// Some rounded corners
		translate([75,5,-1])
        rotate([0,0,-90])
            rounded_corner(lg=50);
        translate([69,5,-5])
        rotate([0,0,180])
            rounded_corner(lg=55);
        if(idler){
            translate([61,14.5,-5])
            rotate([0,0,180])
                rounded_corner(lg=55);
        }
		// Hole for tensioner screw
		translate([30,19.5,21])rotate([0,90,0])
			cylinder(h=150, r=1.6, $fn=80);
	}
    // slot clamp
    translate([53,0,0])
    union(){
        translate([-2,30,0])
        //rotate([0,180,0])
            slot_clamp(h=42);
        translate([3,27,0])
            cube([24,6,42]);
    }
}


module x_endstop_holder(daxis=32){

//  daxis = distance between smooth rods
    
	difference(){
		union(){
			hull(){
				// union bridge between clamps
				translate([10,0,0])
                    cube([5,daxis,10]);
				// smooth rod clamps
				for(y=[0,daxis]){
					translate([0,y,0])
                        cylinder(h=10,r=5);
				}	
			}
			// endstop holder
			translate([17,daxis/2,0])
            union(){
				cylinder(h=10,r=5);
				translate([-5,-5,0])
                    cube([5,10,10]);				
			}
		}
		// room for smooth rods
		translate([0,0,-5])
        for(y=[0,daxis]){
			translate([0,y,0])
                cylinder(h=20,r=3.05);
		}
	// room for belt
	translate([-11.5,-10,-5])
        cube([10,50,20]);
	translate([-9,5,-5])
        cube([20,daxis-10,20]);
	// M3 drill for screw holder
	translate([17,daxis/2,-5])
            cylinder(h=20,r=1.2);
	}
}
