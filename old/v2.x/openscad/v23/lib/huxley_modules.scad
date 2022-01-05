NEMA14 = 34;
NEMA17 = 42;


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


// l = motor length
// daxis = dual axis
module NEMA14(l=33, daxis=false){

	//color("black")
    cube([34,34,l], center=true);
	//color("white")
    translate([0,0,l/2])cylinder(h=2, r=11, $fn=90);

	axispos = daxis ? -(l/2)-10 : (l/2)+2;
	axislenth = daxis ? l+32 : 20;

	//color("gray")
    translate([0,0,axispos])
		cylinder(h=axislenth, r=2.5, $fn=50);

	//translate([0,0,21])hobbed_mk7();

	// fixing screws
	union(){
		translate([-13,13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([13,13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([13,-13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([-13,-13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
	}
}


// l = motor length
// daxis = dual axis
module NEMA17(l=39, daxis=false){

	//color("black")
    cube([42,42,l], center=true);
	//color("white")
    translate([0,0,l/2])cylinder(h=2, r=11, $fn=90);

	axispos = daxis ? -(l/2)-10 : (l/2)+2;
	axislenth = daxis ? l+32 : 20;

	//color("gray")
    translate([0,0,axispos])
		cylinder(h=axislenth, r=2.5, $fn=50);

	// fixing screws
	union(){
		translate([-15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([-15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
	}
}


module portamotor_14(ht=5){
	difference(){
		union(){
			difference(){
				// proforma
				translate([-4,-4,0])cube([NEMA14,NEMA14,ht]);
		
				union(){
					// taladros para tornillos
					translate([0,0,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([26,0,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([0,26,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					//translate([26,26,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					// muesca lateral
					translate([6,6,-3])cube([30,50,ht+5]);
					//translate([6,-6,-5])cube([30,50,15]);
				}
			}
			// extremos redondeados
			translate([5.5,26.36,0])cylinder(h=ht, r=3.65, $fn=50);
			translate([26.36,5.5,0])cylinder(h=ht, r=3.65, $fn=50);
			//translate([5.9,-0.358,0])cylinder(h=ht, r=3.65, $fn=50);
		}
			// hueco central

			translate([13,13,-2])
				cylinder(h=ht+5,r=12,fn=60);
			%translate([13,13,-2])
				cylinder(h=ht+5, r=2.6, $fn=50);
			%translate([-2.5,13,-2])cylinder(h=ht+5, r=3.2, $fn=50);
			%translate([13,-2.5,-2])cylinder(h=ht+5, r=3.2, $fn=50);
	}
	// porta barra lisa
	//translate([-4,-17.1,0])cube([NEMA14,13.1,ht]);
	//translate([13,13,-2])cylinder(h=10, r=2.5, $fn=60);*/
}


module portamotor_17(ht=5){

	difference(){
		union(){
			difference(){
				// proforma
				translate([-NEMA17/2,-NEMA17/2,0])
					cube([NEMA17,NEMA17,ht]);
		
				union(){
					// taladros para tornillos
					translate([-15.5,15.5,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([-15.5,-15.5,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					//#translate([15.5,15.5,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([15.5,-15.5,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					// muesca lateral
					translate([0,0,-3])cube([30,50,ht+5]);
				}
			}
			// extremos redondeados
			translate([-1,16.5,0])cylinder(h=ht, r=4.5, $fn=90);
			translate([16.5,-1,0])cylinder(h=ht, r=4.5, $fn=90);
			//translate([5.9,-0.358,0])cylinder(h=ht, r=3.65, $fn=50);
		}
			// hueco central
			translate([0,0,-2])cylinder(h=ht+5, r=12, $fn=60);
			// referencias para el eje y la varilla lisa
			%translate([0,0,-2])cylinder(h=ht+5, r=2.6, $fn=50);
			%translate([-16,0,-2])cylinder(h=ht+5, r=4.1, $fn=80);
			%translate([0,-16,-2])cylinder(h=ht+5, r=4.1, $fn=80);
	}
}



// ht = piece height
// basic motor holder
module portamotor(ht=5){
	difference(){
		union(){
			difference(){
				// preform
				translate([-4,-4,0])cube([NEMA14,NEMA14,ht]);
		
				union(){
					// drills for screws
					translate([0,0,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([26,0,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([0,26,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					translate([26,26,-3])
						cylinder(h=ht+5, r=1.6, $fn=30);
					// side bevel
					translate([6,6,-3])cube([30,50,ht+5]);
					//translate([6,-6,-5])cube([30,50,15]);
				}
			}
			// rounded corners
			translate([5.5,26.36,0])cylinder(h=ht, r=3.65, $fn=50);
			translate([26.36,5.5,0])cylinder(h=ht, r=3.65, $fn=50);
		}
			// central vane
			translate([13,13,-2])cylinder(h=ht+5,r=12,fn=60);								
			%translate([13,13,-2])cylinder(h=ht+5, r=2.6, $fn=50);
			//%translate([-2.5,13,-2])cylinder(h=ht+5, r=3.1, $fn=50);
			%translate([13,-2.5,-2])cylinder(h=ht+5, r=3.1, $fn=50);
	}
}



// rd = radius
// lg = length
module rounded_corner(rd=5, lg=30){

	difference(){
		cube([rd+0.1, rd+0.1, lg]);
		translate([0,0,-2])cylinder(h=lg+4, r=rd, $fn=15*rd);
	}
}


module nemacollar(hg=5){
    
    difference(){

        translate([-1,-1,0])cube([22,22,hg]);

        translate([0,0,-2])cylinder(h=2*hg,r=15,$fn=150);
        translate([15.5,15.5,-2])cylinder(h=2*hg,r=1.6,$fn=60);
        translate([25.5,11.5,-2])rotate([0,0,45])cube([20,20,2*hg]);
    }    
}


module nema17collar(h=5){
    
    nemacollar(hg=h);
    mirror([1,0,0])nemacollar(hg=h);
    mirror([0,1,0])nemacollar(hg=h);
    mirror([1,1,0])nemacollar(hg=h);
}


module nema17drills(hg=5,dia=3){
    
    translate([15.5,15.5,-5])
        cylinder(h=5*hg,r=(dia/2)+0.1,$fn=20*dia);
    translate([-15.5,15.5,-5])
        cylinder(h=5*hg,r=(dia/2)+0.1,$fn=20*dia);
    translate([15.5,-15.5,-5])
        cylinder(h=5*hg,r=(dia/2)+0.1,$fn=20*dia);
    translate([-15.5,-15.5,-5])
        cylinder(h=5*hg,r=(dia/2)+0.1,$fn=20*dia);    
}


module hotendhead(vinsert=true,filament=true,bcoupling=false){
    
    union(){
        /*if (vinsert){
            // The hotend head will be fixed to the extruder
            // with a couple of M3 screws and inserted vertically
            cylinder(h=15.25,r=8.15,$fn=50);
        }
        else{*/
            // upper mount
            translate([0,0,0])cylinder(h=5.5,r=8.15,$fn=50);
            // neck
            translate([0,0,5.1])cylinder(h=5.1,r=6.15,$fn=50);
            // lower mount
            translate([0,0,10.1])cylinder(h=5.5,r=8.15,$fn=50);
            // This makes posible to carve a side slot
            // in order to insert the hotend from a side,
            // not vertically
            /*translate([-8.15,0,0])cube([16.3,20,5.1]);
            translate([-6.15,0,5])cube([12.3,20,5.1]);
            translate([-8.15,0,10.1])cube([16.3,20,5.1]);
        }*/
        if (bcoupling){
            cylinder(h=17.75,r=4,$fn=60);
        }
        // 1,75mm hole filament
        if (filament)
        translate([0,0,-10])cylinder(h=100,r=1.1,$fn=50);
    }
}
