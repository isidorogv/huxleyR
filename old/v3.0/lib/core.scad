//------------------------------------------------------------
//-- Core modules for Huxley i3 3D printer
//------------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)
// Credits:
//-- Some files have been taken from other authors:
//		ePoxi (https://www.thingiverse.com/thing:279973)
//		rowokii (https://www.thingiverse.com/thing:767317)
//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


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


module hobbed_mk8(al=11,rd=4.5,rd2=3.5){

	//color("lightgrey")
    difference(){
		union(){
			cylinder(h=al-5, r=rd, $fn=20*rd);
			translate([0,0,al-5])
                cylinder(h=2, r1=rd, r2=rd2, $fn=20*rd);
			translate([0,0,al-3])
                cylinder(h=2, r1=rd2, r2=rd, $fn=20*rd);
			translate([0,0,al-1])
                cylinder(h=1, r=rd, $fn=20*rd);
		}
		translate([0,0,-5])cylinder(h=2*al, r=2.5, $fn=50);
	}
}



module NEMA14(tp=14,lg=33,dualx=false){

// DEPRECATED: DO NOT use anymore!!!
// ONLY FOR backward compatibility
// Use nema_motor instead
    
    nema_motor(type=tp,l=lg,daxis=dualx);
}



module NEMA17(tp=17,lg=39,dualx=false){

// DEPRECATED: DO NOT use anymore!!!
// ONLY FOR backward compatibility
// Use nema_motor instead
    
    nema_motor(type=tp,l=lg,daxis=dualx);
}



module nema_motor(type=14,h=33,daxis=false,hobbed=false){

// type = type of stepper motor,
// e.g., 14 = NEMA14 or 17 = NEMA17
    
// h = motor height
// daxis = dual axis
// hobbed = Shows hobbed Mk8 
    
    stpmot = type==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    // these three values are:
    //  1st -> motor dimensions, lenght and width in mm.
    //  2nd -> screw distance in mm.
    //  3td -> collar diameter in mm.
    
	color("lightgray")
    linear_extrude(height=5)
    offset(delta=2.5,chamfer=true)
        square(stpmot[0]-5,center=true);
    
    color("black")
    translate([0,0,-h+13])
    linear_extrude(height=h-13)
    offset(delta=2.5,chamfer=true)
        square(stpmot[0]-5,center=true);
    
    color("lightgray")
    translate([0,0,-h+5])
    linear_extrude(height=8)
    offset(delta=2.5,chamfer=true)
        square(stpmot[0]-5,center=true);
    
    //cube([34,34,l], center=true);
	color("white")
    translate([0,0,5])cylinder(h=2, r=11, $fn=50);

	axispos = daxis ? -h-6 : 5;
	axislenth = daxis ? h+32 : 20;

	color("gray")
    translate([0,0,axispos])
		cylinder(h=axislenth,r=2.5,$fn=50);

    if (hobbed){
        translate([0,0,7])hobbed_mk8();
    }

	// fixing screws
	#union(){
        for(x=[stpmot[1]/2,-stpmot[1]/2]){
            for(y=[stpmot[1]/2,-stpmot[1]/2]){
                    translate([x,y,0])cylinder(h=8,r=1.5,$fn=30);
            }
        }
    }
}


module motor_plate(thick=5,
                    stepper=stepper,
                    notch=false,
                    chamcor=true,
                    half=false){
    
// thick = plate thickness in mm
// e.g., 14 = NEMA14, 17 = NEMA17, and so...
// stp = stepper motor type; NEMA14 or NEMA17
// notch = motor plate with only 3 fixing screws
// chamcor = chamfer on corners
// half = shows only a half motor plate
    
    NEMA = stepper==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    
    difference(){
        // preform base
        linear_extrude(height=thick)
        offset(delta=2,chamfer=chamcor)
            square(NEMA[0]-4,center=true);
        
        // drills for M3 fixing screws
        for(x=[NEMA[1]/2,-NEMA[1]/2]){
            for(y=[NEMA[1]/2,-NEMA[1]/2]){
                translate([x,y,-1]){
                    cylinder(h=thick+2,r=1.6);
                    translate([0,0,5])
                        cylinder(h=thick,r=3);
                }
            }
        }
        // room for Nema collar
        translate([0,0,-1])cylinder(h=thick+2,d=NEMA[2]);
        // side notch
        if(notch){
            translate([-5,-5,-1])
                cube([NEMA[0]+5,NEMA[0]+5,thick+2]);
        }
        if(half){
            translate([-5,-NEMA[0]/2-2.5,-1])
                cube([NEMA[0]+5,NEMA[0]+5,thick+2]);
        }
    }
    // rounded notch borders
    if(notch){
        translate([-5,
                    NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        translate([NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    -5,0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
    }
    if(half){
        translate([-5,
                    NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        translate([-5,
                    -NEMA[0]/2
                    +(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    ,0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        
    }
    // just for reference
    %cylinder(h=10,r=2.5);
}


module nemacollar(hg=5){

// DEPRECATED: DO NOT use anymore!!!
// ONLY FOR backward compatibility
// Use motor_plate instead
    
    motor_plate(stepper=17,thick=hg); 
}


module nema17collar(h=5){

// DEPRECATED: DO NOT use anymore!!!
// ONLY FOR backward compatibility
// Use motor_plate instead
    
    nemacollar(hg=h);
}


module nema17drills(hg=5,dia=3){

// DEPRECATED: DO NOT use anymore!!!
// ONLY FOR backward compatibility
    
    for(x=[31/2,-31/2]){
         for(y=[31/2,-31/2]){
            translate([x,y,0])cylinder(h=hg+2,d=dia+0.2,$fn=30);
         }
    }
}


module hotendhead(filament=true,bcoupling=true,ptfe=4){
    // ptfe = ptfe tube diameter in mm
    union(){
        translate([0,0,0])cylinder(h=16,r=8.15,$fn=50);

        if (bcoupling)
            translate([0,0,0])cylinder(h=17.75,r=4.4,$fn=60);
        
        // 1,75mm hole filament
        if (filament)
            translate([0,0,-10])cylinder(h=100,d=ptfe+0.2,$fn=50);
    }
}


module hollow(rd=5,lg=35,wd=20,hg=20){

// A cube with rounded corners (radius rd) on XY plane 
// and its height on Z axis is hg. All ammounts in mm.
// rd = corner radius in mm.
// lg = length, in mm.
// wd = width in mm.
// hg = height in mm.
    
    linear_extrude(height=hg)
    offset(r=rd)
        square([lg-2*rd,wd-2*rd],center=true);
}


module beveled_hollow(rd=5,lg=35,wd=20,hg=20){

// A cube with rounded corners and edges (radius rd) 
// and its height on Z axis is hg. All ammounts in mm.
// rd = bevel radius in mm.
// lg = length, in mm.
// wd = width in mm.
// hg = height in mm.
    
    minkowski(){
        sphere(rd);
        cube([lg-2*rd,wd-2*rd,hg-2*rd],center=true);
    }
}


module wedge(ld=10,wd=25,hg=20){

// A 90 degrees triangle on XY plane
// lg = lenght in mm (X coord.)
// wd = width in mm (Y coord.)
// hg = height in mm (Z coord.)
    
    linear_extrude(height=hg,
        twist=0,
        center=true,
        //convexity=10,
        slices=30)
    
        polygon(points=[[0,0],[ld,0],[0,wd]],paths=[[0,1,2]]);
}


module rounded_corner(rd=5,lg=30){

// A rounded corner on XY plane with lg height on Z axis
// rd = radius
// lg = length
    
	difference(){
		cube([rd+0.1, rd+0.1, lg]);
		translate([0,0,-2])cylinder(h=lg+4, r=rd, $fn=15*rd);
	}
}

