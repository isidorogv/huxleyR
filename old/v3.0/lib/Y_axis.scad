//-----------------------------------------------------------
//-- Y axis library modules for Huxley i3 3D printer
//-----------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

//----------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//----------------------------------------------------------


module y_belt_clamp(){
    
// PRUSA iteration3 Y belt holder
// Original idea by Josef Průša <iam@josefprusa.cz> 
// and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Released under the terms of GNU-GPL v3 or higher
// -------------------------------------------------------
// Modified by Isidoro Gayo <isidoro.gayo@gmail.com>
// for Huxley i3/Foldarap 3D printers (oct 2018/apr 2019)
// -------------------------------------------------------
    
    difference(){
        // main body
        union(){
            // upper part (screws)...
            linear_extrude(height=15)
            offset(chamfer=true)
                square([28,25]);
            // ... and lower part (belt)
            translate([-10,26,1])
            rotate([90,0,0])
            linear_extrude(height=8)
            offset(chamfer=true)
                square([48.5,13]);
        }
        // belt space cutaway around belt pivots
        for(pos=[[16,18,2],[12,5,2]]){
            translate(pos) 
                cylinder(h=16,r=7.2);  
        }
    
        // belt clamp notches and bevels
        for(p=[[[10,7,2],[0,0,0],[32,2.1,16]],
            [[16,8,12],[45,0,0],[15,5,5]],
            [[-20,9,2],[0,0,0],[28,2.1,16]],
            [[-2,10,12],[45,0,0],[10,5,5]]]){     
            
            translate(p[0]) 
            rotate(p[1])
                cube(p[2]);
        }        
        // drills for all screws
        translate([-2,0,0])
        // left and right screw holes
        for(pos=[[-4,17,7.5],[36,17,7.5]]){
            translate(pos)
            rotate([-90,0,0])
            union(){
                // drill for one screw
                hull(){
                    for(c=[[-1.5,0,0],[1.5,0,0]]){
                        // screw drill
                        translate(c)
                            cylinder(h=10,r=1.6);
                        }
                }            
                hull(){
                    for(c=[[-1.5,0,0],[1.5,0,0]]){
                        // head screw recess
                        translate(c)
                            cylinder(h=5,r=3);
                    }
                }
            }
        }        
        // removing minor details for cosmetic improvement
        rotate([0,0,40]) 
        translate([11,1,2]) 
            cube([10,4,16]);        
    }
    // placing the belt pivots on main body
    for(xy=[[16,18,0],[12,5,0]]){
        translate(xy)
        // belt pivot
        for(p=[[[0,0,0],11,3.5,3.5],
                [[0,0,11],3,3.5,2.5]]){
            // lower and upper part
            translate(p[0])
                cylinder(h=p[1],r1=p[2],r2=p[3]);
        }
    }
}


module foot(perfil = wslot){
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
    
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


module y_endstop_adj(){

// adjustement piece for Y end stop (piece 1/2)
    
    difference(){
        minkowski(){
            cylinder(h=1,r=3,$fn=30);
            cube([20,14,12]);        
        }
        // drill for M3 adjustement screw
        translate([10,-5,6])rotate([-90,0,0])
            cylinder(h=30,r=1.4,$fn=30);
        // Side bevelsm106 s180
        translate([14,-10,20])rotate([0,65,0])cube([30,30,30]);
        translate([-5.8,-10,-5])rotate([0,-65,0])cube([30,30,30]);
        // Side hollow
        translate([17,-1,2])cube([14,16,14]);
        translate([-11.2,-1,2])cube([14,16,14]);
        // Drills for M3 clamp screws
        translate([0,7,-1])union(){
            cylinder(h=10,r=1.6,$fn=30);
            translate([20,0,0])cylinder(h=10,r=1.6,$fn=30);
        }
    }
}


module heatbed_wire_fastener(l=18,slot=5){

// l = fastener lenght
// slot = slot dimension
    
	difference(){
        // Preform base
		hull(){
			cylinder(h=l,r=5,$fn=60);
			translate([0,-5,0])cube([20,10,l]);
		}
        // fixing M3 screw and nut
		translate([0,0,-1])cylinder(h=3,r=3.2,$fn=6);	
		translate([0,0,-1])cylinder(h=l+2,r=1.6,$fn=50);
        // room for wires
		translate([18.5,0,-1])cylinder(h=l+2,r=3,$fn=80);
        // Fixing Slot to the frog
		translate([-10,-10,5])cube([20,20,slot+0.1]);
        // we only need the bigger part...
        translate([17.5,-10,-10])cube([20,20,50]);
		// slots for zip ties
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


module y_smooth_rod_holder(profile=wslot){

// profile = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
    
	difference(){
        // preform
		hull(){
            cylinder(h=profile+2.5,r=5.5);
			translate([0.9*profile,0,0])
				cylinder(h=profile+2.5,r=5.5);
		}
		// M6 smooth rod
		#translate([0,0,2.5])
            cylinder(h=profile+2.5,r=3.08);
        // M3 fixing screw
		#translate([(profile/2)+5.1,0,-2])
            cylinder(h=7, r=1.6);
        // we remove the profile volume...
        translate([5,-10,2.5])
            cube([1.2*profile,20,profile+10]);
	}
}


module y_motor_holder(th=5,hg=7,profile=wslot,stepper=stepper){

// hg = piece height (here we have no wall thickness)
// profile = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
    
    NEMA = stepper==14 ? NEMA14 : NEMA17;
    
    t = 4.5;  // arm thickness in mm
    
    motor_plate(thick=th,notch=true,stepper=stepper);
    
    // fixing arms
    translate([0,-NEMA/2-profile/2,hg/2])
    rotate([0,90,0])
    for(feat=[[-profile/2-t-ease/2,0],[profile/2+t+ease/2,1]]){
        translate([0,0,feat[0]])
        mirror([0,0,feat[1]])
        // arm without drills
        difference(){
            hull(){
                translate([-hg/2,0,0])
                    cube([hg,(profile/2),t]);
                translate([0,-3,0])
                    cylinder(h=t,r=hg/2);
            }
            // M3 fixing screw drills
            cylinder(h=3*t,d=3+ease,center=true);
            // head screw recess
            cylinder(h=5,d=6+ease,center=true);
        }
    }
    // fake aluminium slot, just for refence
	%translate([-profile/2,-profile-NEMA/2,-10])
        cube([profile,profile,30]);
}


// bearing 623ZZ idler for Y axis
module y_bearing_idler(){
    
    translate([0,0-18.5,0])half_bholder();
    translate([0,18.5,0])mirror([0,1,0])half_bholder();

    %translate([0,4,13])rotate([90,0,0]){
        cylinder(h=8,d=18,$fn=50);
        translate([0,0,-11])cylinder(h=30,d=3,$fn=50);
    }
}


// Auxiliar module for y_bearing_idler. NOT FOR PRINTING!!
module half_bholder(){
    
    intersection(){
        difference(){
            translate([0,0,10])rotate([-90,0,0])difference(){
                union(){
                    // base
                    hull(){
                        cylinder(h=14,r=10,$fn=60);
                        translate([-10,0,0])cube([20,10,14]);
                    }
                    // bearing half clamp
                    //translate([0,0,14])
                      //  cylinder(h=1.25,r1=3.5,r2=2,$fn=90);
                    // half base
                    translate([-10,7,0])cube([20,3,20]);
                }
                // M3 bearing holder screw
                translate([0,-3,-2])cylinder(h=20,r=1.4,$fn=50);
            }
            // shaping the reinforcement...
            translate([-15,0,3])rotate([55,0,0])cube([30,30,20]);
            translate([-5,-6,3])cube([10,15,20]);
            // M3 fixing screw for slot
            translate([0,3.5,-2])cylinder(h=10,r=1.6,$fn=50);
        }
        // rounded external corners, just for cosmetics
        translate([0,19,-10])cylinder(h=30,r=20,$fn=80);
    }
}


module frog(thickness=5){

    difference(){
        // frog base
        union(){
            y_bearing_holder();
            mirror([0,1,0])
                y_bearing_holder();
            mirror([1,0,0])
                y_bearing_holder();
            rotate([0,0,180])
                y_bearing_holder();
            // extra surface for endstop drills
            translate([-28,36,5])
                hollow(rd=3,lg=12,wd=6,hg=thickness);            
            // uncomment the following line if you are
            // obtaining extrange results with your slicer
            //color("orange")translate([-10,-35,0])cube([20,70,5]);
        }
    
        // belt clamp holes
        #translate([lfrog/7,wfrog/4,-1])union(){
            cylinder(h=thickness+2,r=1.6,$fn=30);
            translate([0,-37,0])
                cylinder(h=thickness+2,r=1.6,$fn=30);
        }       
        // drills for endstop...
        #translate([-0.25*lfrog,(wfrog/2)+3,-1])union(){
            cylinder(h=thickness+2,r=1.6,$fn=30);
            translate([10,0,0])
                cylinder(h=thickness+2,r=1.6,$fn=30);
        }
        // ... and wire holder (zip ties)
        translate([-0.08*lfrog,(wfrog/2)-16,-1]){
        for(x=[10,0]){
            for(y=[0,10]){
                translate([x,y,0])
                    cube([1.5,3,thickness+2]);
            }
        }
            // hole for wire fastener
            // use this or zip ties, but just one of them
            translate([6,6,0])
                cylinder(h=thickness+2,r=1.6,$fn=30);
        }
    }
}


// This is an auxiliar module, DO NOT print!!
module minihotbed(){

// Mini Heatbed by F. Malpartida
    %cube([100,100,2],center=true);
    
    // fixing screws for mini heatbed
    #for(x=[-bhole,bhole]){
        for(y=[-bhole,bhole]){
            translate([x,y,-1])
                cylinder(h=5,r=1.6);
        }
    }
}


// This is an auxliar module, NOT FOR PRINTING!!
module y_bearing_holder(lf=132,wf=70,tf=5){

    // lf = Frog dimension from left to right
    // wf = Frog dimension from back to front
    // tf = Thickness frog
    
    //rlm6=6; // LM6UU radius
    
    
	translate([-lf/2,-wf/2,0])difference(){
		union(){            
            // frog base
			cube([lf/2,wf/2,tf]);
            // LM6UU bearing clamp
            difference(){
                cube([35,llm6,15.75]);
                // Bearing clamp reinforcement
                translate([19,-1,17])rotate([0,45,0])
                    cube([50,llm6+2,20]);
            }
		}
        // bearing hole
        translate([11.75,-1,13.5])rotate([-90,0,0])union(){
            #translate([0,0,0])
                cylinder(h=(wf/2)+2,r=rlm6,$fn=60);
            // smooth rod
            %translate([0,0,-30])cylinder(h=3*wf/2,r=3,$fn=60);
        }
        // Hole to save filament
        translate([30,30,-2])hollow(rd=3,lg=30,wd=20);
        // Bevel on bearing clamp left side
        translate([-21.5,-1,19])rotate([0,45,0])
            cube([20,llm6+2,20]);
	}
    // frog arm for mini heatbed by F. Malpartida
    translate([-bhole,-bhole,0])difference(){
        hull(){
            cylinder(h=tf,r=5,$fn=50);
            translate([0,bhole-(wf/2),0])
                cube([25,1,tf]);
        }
        translate([0,0,-3])cylinder(h=2*tf,r=1.8,$fn=30);
        //translate([0,0,tf-3])
          //  cylinder(h=tf,r=3.2,$fn=6);        
    }
    // this avoids the bearing release out of the clamp
    translate([-lfrog/2,-wf/2,0])cube([20,1,2*tf]);
}

