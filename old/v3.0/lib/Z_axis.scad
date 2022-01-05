//-----------------------------------------------------------
//-- Z axis library modules for Huxley i3 3D printer
//-----------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

//----------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//----------------------------------------------------------


module preform(altura, ancho, fondo, pared=2.7){
// The begining, the main piece
// altura = height
// ancho = length
// fondo = witdh
// pared = wall thickness, all dimensions in mm
    
	difference(){
		union(){
			hull(){
                for(pos=[[0,0,0],
                        [ancho,0,0],
                        [ancho,fondo,0],
                        [0,fondo,0]]){
				translate(pos)
                    cylinder(h=altura, r=pared);
                }
			}
		}
		// hollow for aluminun slot
		translate([-0.1,-0.1,-1])cube([ancho+0.2,fondo+0.2,altura+2]);
	}
}


module base(alto=48,pared=2.7,perfil=wslot,mtor=3){

// Where the vertical and horizontal slots are joined
// altura = height
// ancho = width
// pared = wall thickness
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
// mtor = screw metric; 3 = M3, 4 = M4 (don't use metric higher than M3)
    
	difference(){
		union(){
			preform(altura=alto,ancho=lslot,fondo=wslot,pared=pared); 

			color("pink")translate([lslot+2.1,-perfil,0])
				cube([perfil+pared,3*perfil,12]);

			color("cyan")translate([lslot+2.1,-perfil,0])
				cube([pared,3*perfil,alto]);

			color("red")translate([lslot+0.1,-2.7,0])
				cube([pared,perfil+5.4,alto]);
		}
		// holes for fixing screws (vertical slots)
		translate([-1.5*pared,11,alto/2])rotate([0,90,0])
			cylinder(h=60,r=(mtor/2)+0.1,$fn=30);
		// hollow for feet
		translate([lslot+(perfil/2)+pared+2,60,-1])
        rotate([90,0,0])
        hull(){
			cylinder(h=100,r=perfil/3, $fn=6);
			translate([0,perfil/3,0])
				cylinder(h=100,r=perfil/6, $fn=6);
		}
		// hollow for plastic saving
        #translate([65,11,-10])
            hollow(lg=25,wd=42,hg=alto,rd=pared);
		// holes for fixing screws (horizontal slots)
		translate([lslot+(perfil/2)+pared+2,perfil+15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		translate([lslot+(perfil/2)+pared+2,-15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		// holes for screw heads
		translate([lslot+(perfil/2)+pared+2,perfil+15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		translate([lslot+(perfil/2)+pared+2,-15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		// some screws for horizontal slots (reinforcement)
		translate([lslot-1,-15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		translate([lslot-1,perfil+15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		// side bevel on the wall of horizontal slot
		translate([lslot-2,-26,25])
        rotate([45,0,0])
            cube([10,50,50]);
		translate([lslot-2,13,60])
        rotate([-45,0,0])
            cube([10,50,50]);
		// fixing screws for conection wiring box
		translate([11,-5,35])
        rotate([-90,0,0])
			cylinder(h=alto, r=1.6);
		translate([33,-5,35])
        rotate([-90,0,0])
			cylinder(h=alto, r=1.6);
	}
}


module upper_union(lprofile=lslot,profile=wslot,thick=7){
// lprofile = profile lenght in mm
// ancho = profile widthin mm
// thick = piece thickness in mm
    
// this piece joints the vertical side  
// slots to the horizontal upper one
    
	difference(){
        translate([-lprofile/2,-profile/2,0])
            cube([lprofile,profile,thick]);
        
        for(x=[-profile/2,profile/2]){
			translate([x,0,-1])
                cylinder(h=thick+2,r=2.6);
			translate([x,0,3.5])
                cylinder(h=thick+2,r=4.55);
        }
        for(x=[-lprofile/2+2.5,lprofile/2-2.5]){
			translate([x,0,-1])
                cylinder(h=thick+2,r=1.6);
        }
	}
}


module z_motor_holder(profile=wslot,
                      lprofile=lslot,
                      thick=5,
                      stepper=14){

    NEMA = stepper==14 ? NEMA14 : NEMA17;

    translate([(lslot-NEMA-4)/2,3,0])
    union(){
        // base
        translate([NEMA/2,profile+thick+NEMA/2,0])
        rotate([0,0,90])
            motor_plate(ht=thick,
                        stepper=stepper,
                        chamcor=false,
                        notch=true);
        // some extra parts, avoids motor hitting the profile
        translate([0,(wslot+thwall/2)-2,0])
            cube([NEMA,thick+1,thick]);
        // vertical side reinforcement
        translate([NEMA,profile-2,0])
        rotate([90,0,90])
        linear_extrude(height=thwall)
            polygon(points=[[0,0],
                            [0,profile],
                            [NEMA+thick+2,thick],
                            [NEMA+thick+2,0]]);
    }
	// slot clamp
    difference(){
		preform(altura=wslot,ancho=lslot,fondo=wslot);
        // drills for M3 side fixing screws
        translate([60,wslot/2,12.5])
        rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
}


module z_slot_lid(th=1.8,la=lslot,an=wslot){

// al = height
// la = lenght
// an = width
    
// This piece fits into the upper point
// of a vertical aluminium slot. 
// For cosmetic purpose only, suitable
// for a 44x22 slot profile by default.
    
	// lid
    linear_extrude(height=th)
    offset(r=1)
        square([la-2,an-2],center=true);
    // central fitting piece
    linear_extrude(height=17)
    offset(delta=1.5,chamfer=true)
        square([3,16],center=true);
}

