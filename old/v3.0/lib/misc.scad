//------------------------------------------------------------
//-- Miscelaneous modules for Huxley i3 3D printer
//------------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)
// Credits:
//-- Some files have been taken from other authors:
//		ePoxi (https://www.thingiverse.com/thing:279973)
//		rowokii (https://www.thingiverse.com/thing:767317)
//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module cable_guard(profile=wslot,thk=10,sw=5.5){
    
    difference(){
            union(){
                difference(){
                    linear_extrude(height=thk)
                    offset(r=3)
                        square(profile,center=true);
                    
                    cube([profile+ease,profile+ease,3*thk],center=true);
                    // remove unused part
                    translate([-profile/2-4,sw/2+1,-1])
                        cube([profile+8,profile,thk+2]);
                }
                // slot clamps
                for(x=[-profile/2,profile/2]){
                    translate([x,1,0])
                    linear_extrude(height=thk)
                    offset(delta=0.5,chamfer=true)
                        square([0.5,sw-1],center=true);
            }
        }
        // rounded corners
        for(pos=[[[profile/2-2,-1,-1],[0,0,0]],
                [[-profile/2+2,-1,-1],[0,0,90]]]){
            translate(pos[0])
            rotate(pos[1])
                rounded_corner();
        }
    }
}


module psu_holder(wth=thwall){

	difference(){
		// Proform
		cube([PSU_footprint_width,
            PSU_footprint_height,
            height_from_base],
			center=true);
	
		// Hole for IEC connector
		translate([-2,0,-20]){
			cube([PSU_footprint_width-2,IEC_width,IEC_heigth],
                center=true);
			cube([PSU_footprint_width-6,IEC_width,IEC_heigth+4],
                center=true);
		}
		// Hole for switch
		translate([(PSU_footprint_width/2)-switch_width,0,-20]){
			cube([switch_width,
                PSU_footprint_height+10,
                switch_height],
				center=true);
			cube([switch_width+4,
                PSU_footprint_height-2,
                switch_height],
				center=true);
		}
		// Hollow for wiring
		cube([PSU_footprint_width-2*wth,
			PSU_footprint_height-2*wth,height_from_base+10],
				center=true);
		// removing some parts...
		translate([-(PSU_footprint_width/2)+6,
                    (PSU_footprint_height/2)-1,
                    (height_from_base/2)-3])
                cube([8,wth+2,14],center=true);
		translate([(PSU_footprint_width/2)-1,
                    (PSU_footprint_height/2)-3.5,
                    (height_from_base/2)-3])
                cube([wth+2,3,14],center=true);
	}
}


module spool_holder_clamp(){
    
    h=44;
    w=80;
    th=7;
    
    difference(){
        // base
        union(){
            difference(){
                linear_extrude(height=th)
                offset(chamfer=true)
                    square([w-2,h-2],center=true);        
            
                // matching slots
                translate([0,-h/2-1,th+1])
                rotate([-90,0,0])
                    cylinder(h=h+2,r=2,$fn=4);
                translate([-h/2-1,0,th+1])
                rotate([0,90,0])
                    cylinder(h=h+2,r=2,$fn=4);
            }
            
            translate([0,0,th])
            //rotate([0,0,45])
                cylinder(h=th,r1=h/3,r2=h/4,$fn=30);
        }
        
        translate([0,0,-1])union(){
            // M3 fixing screws
            translate([-w/2+11,h/4,0]){
                cylinder(h=10,r=1.6,$fn=30);
                translate([0,0,4])cylinder(h=5,r=3.4,$fn=30);
            }
            translate([w/2-11,h/4,0]){
                cylinder(h=10,r=1.6,$fn=30);
                translate([0,0,4])cylinder(h=5,r=3.4,$fn=30);
            }
            translate([w/2-11,-h/4,0]){
                cylinder(h=10,r=1.6,$fn=30);
                translate([0,0,4])cylinder(h=5,r=3.4,$fn=30);
            }
            translate([-w/2+11,-h/4,0]){
                cylinder(h=10,r=1.6,$fn=30);
                translate([0,0,4])cylinder(h=5,r=3.4,$fn=30);
            }
            // M5 pivot screw head recess
            cylinder(h=6,r=7.55,$fn=6);
            // M5 pivot screw drill
            cylinder(h=30,r=4.1,$fn=60);
        }    
    }
}


module spool_holder_arm(){

    h=44;
    w=80;
    th=7;
    
    difference(){
        union(){
            // base
            difference(){
                hull(){                        
                    cylinder(h=2*th,r=h/2,$fn=50);
                    translate([0,80,0])
                        cylinder(h=2*th,r=h/4,$fn=50);
                }                
                translate([0,0,-1])hull(){    
                    cylinder(h=2*th+2,r=h/2-5,$fn=50);
                    translate([0,80,0])
                        cylinder(h=2*th+2,r=h/4-5,$fn=50);    
                }        
            }
            // base
            cylinder(h=2*th,r=h/2,$fn=50);
            translate([0,80,0])cylinder(h=2*th,r=h/4,$fn=50);
            // matching slots
            translate([0,-h/2,1])
            rotate([-90,0,0])
                cylinder(h=h,r=2,$fn=4);
            translate([-h/2,0,1])
            rotate([0,90,0])
                cylinder(h=h,r=2,$fn=4);
        }
        // pivot hollow
        union(){
            cylinder(h=th,r1=h/3+1,r2=h/4+1,$fn=30);
            translate([0,0,-9.9])cylinder(h=10,r=h/3+1,$fn=30);
            cylinder(h=4*th,r=4.1,$fn=50);
        }
        // spool holder drill
        translate([0,80,-1]){
            cylinder(h=3*th,r=4.1,$fn=30);
            #cylinder(h=7,r=7.6,$fn=6);
        }
    }
    // reinforcement
    rotate([0,0,20])translate([16,0,0])cube([5,70,2*th]);
    rotate([0,0,-20])translate([-20.8,0,0])cube([5,70,2*th]);
}


module psufastener(){

	color("lightgray")difference(){
		union(){
			cube([40,7,10],center=true);
			translate([20,-3.5,-5])cube([7,25,10]);
		}
		translate([-13,-10,0])rotate([-90,0,0])
            cylinder(h=30,r=1.6,$fn=70);
		translate([9,-10,0])rotate([-90,0,0])
            cylinder(h=30,r=1.6,$fn=70);
		translate([-13,-1,0])rotate([-90,0,0])
            cylinder(h=10,r=3.5,$fn=70);
		translate([9,-1,0])rotate([-90,0,0])
            cylinder(h=10,r=3.5,$fn=70);
		translate([15,12,0])rotate([0,90,0])hull(){
			cylinder(h=20,r=1.6,$fn=70);
			translate([0,3,0])cylinder(h=20,r=1.6,$fn=70);
		}
		translate([22,1.5,-15])rotate([0,0,-90])rounded_corner();

		translate([10,16.5,0])rotate([0,90,0])rounded_corner();
		translate([40,16.5,0])rotate([0,-90,0])rounded_corner();

		translate([-15,20,0])rotate([90,-90,0])rounded_corner();
		translate([-15,20,0])rotate([90,180,0])rounded_corner();
	}
}


// Auxiliar module for knob module
module screw_drills(nr=3.2,sr=1.6,nt=2,dd=10){
    
    // Makes drills in knob in order to the screw
    // (knob axis) and a nut if needed. An screw
    // with hexagonal head can also be used.
        
    // by default, M3 is set.
    
    // nr = nut radius in mm, for a given metric
    // sr = screw radius in mm
    // nt = nut thickness in mm
    // dd = drill depth in mm
    
    translate([0,0,-1])union(){
        cylinder(h=2*dd+2,r=sr);
        cylinder(h=nt+1,r=nr,$fn=6);
    }
    // nut hole in spacer, if needed
    translate([0,0,2*dd-nt])
        cylinder(h=nt+1,r=nr,$fn=6);
}


module knob(thk=5,dia=24,mt=3,spc=true,knurl=true,nk=20,dk=5,f=40){

    // This is a knob in order to use in endstops,
    // belt tensioners and leveler thumb wheels, 
    // among other applications.

    // thk = knob thickness in mm
    // dia = knob diameter in mm
    // spc = spacer, suitable for belt tensioners
    // knurl = knob has or not knurl around its perimeter?
    // nk = number of knurls used on the perimeter
    // dk = knurl diameter in mm
    // mt = screw metric used on the knob axis (3 = M3, 4 = M4,
    //      5 = M5, and so...
    // f = number of knurl faces (shape)

    $fn = 50;   // default faces for all cylinders/cones
    
    difference(){
        union(){
            cylinder(h=thk,d=dia);
            // do we want knurl on our knob?
            if(knurl){
                for(i=[0:360/nk:359]){
                    rotate([0,0,i])
                    translate([dia/2,0,0])
                        cylinder(h=thk,r=dk,$fn=f);    
                }
            }
            // do we need an spacer on our knob?
            if (spc){
                translate([0,0,thk])
                    cylinder(h=thk,d1=dia,d2=dia-3);
            }
        }
        // drill for nuts and screw depending on the metric
        if(mt==3){
            screw_drills(nr=3.2,sr=1.6,nt=2.5,dd=thk);
        }
        else if(mt==4){
            screw_drills(nr=4,sr=2.1,nt=3,dd=thk);
        }
        else if(mt==5){
            screw_drills(nr=4.6,sr=2.6,nt=3,dd=thk);
        }
        else if(mt==6){
            screw_drills(nr=5.6,sr=3.1,nt=5,dd=thk);
        }
        else if(mt==8){
            screw_drills(nr=7.6,sr=4.1,nt=6.5,dd=thk);
        }
        else if(mt==10){
            screw_drills(nr=9.6,sr=5.1,nt=8,dd=thk);
        }
        else if(mt==12){
            screw_drills(nr=10.9,sr=6.1,nt=8,dd=thk);
        }
    }
}


module arm_holder(){

// holds the board case in place
    
    difference(){    
        // base
        cube([50,130,10]);
        // angle
        translate([6,6,-1])
            cube([50,130,12]);
        // M3 fixing drills
        // on aluminium slot...
        for(x=[17,39]){
            translate([x,-2,5])
            rotate([-90,0,0])
            hull(){
                for(dx=[-1.5,1.5]){
                    translate([dx,0,0])
                        cylinder(h=10,r=1.6);
                }
            }
        }
        // ... and back on board case
        for(y=[25,115]){
            translate([-2,y,5])
            rotate([0,90,0])
            hull(){
                for(dy=[-3,3]){
                    translate([0,dy,0])
                        cylinder(h=10,r=2.1);
                }
            }
        }
    }
    // rounded internal corner
    translate([14,14,0])
    rotate([0,0,180])
        rounded_corner(lg=10,rd=8);
}

        
module case_plane(w=bwit,l=blen,gap=15,thick=1.8){
    
// Auxiliar module for board case and lid
    
// gap = margin between board and case walls, in mm
// thick = base thickness in mm
    
    linear_extrude(height=thick)
    offset(r=gap)
        square([w,l],center=true);
}


module case_base(thick=1.8){

// Auxiliar module for board case and lid
    
    color("orange")
    case_plane(thick=thick);
    // M3 fixing screws
    for(x=[bwit/2-offscrew,-bwit/2+offscrew]){
        for(y=[blen/2-offscrew-9,-blen/2+offscrew]){
            translate([x,y,thick])
                difference(){
                    cylinder(h=10,d1=16,d2=8);
                    #cylinder(h=14,r=1.4);
                }
        }
    }
}

module case_lid(){
    
    difference(){
        union(){
            case_plane(l=bwit,thick=12);
            case_plane(l=bwit,thick=16,gap=11);
        }
        translate([0,0,1.8])
            case_plane(l=bwit,thick=18,gap=9);
        // ventilation grid
        /*for(yoffset=[5:10:30]){
            translate([0,-blen/2+yoffset,-1])
                hull(){
                    for(x=[bwit/2,-bwit/2]){
                        translate([x,0,0])
                            cylinder(h=5,r=2);
                    }
                }
        }*/
        // 80x80 Fan intake
        //translate([0,blen/2-37.5,-1]){
        translate([0,0,-1]){
            // Main intake
            cylinder(h=10,d=75,$fn=120);
            // M3 fixing fan drills
            for(i=[0:90:359]){
                rotate([0,0,i])
                translate([35.5,35.5,-1])
                    cylinder(h=8,r=1.2,$fn=50);
            }
        }
    }
}


module board_case(height=30,wall=2){

    difference(){
        union(){
            // base
            case_base();
            // case walls
            difference(){
                case_plane(thick=height);
                translate([0,0,-1])
                    case_plane(thick=height+2,gap=15-2*wall);
            }
        }
        // lower wire intake
        translate([-10,-bwit,-2])
            hollow(hg=50,lg=50,wd=40);
        // medium wire intake
        //translate([bwit/2+14,-bwit/2,12+wall])
          //  beveled_hollow(hg=16,lg=20,wd=24);
        // higher wire intake
        translate([bwit/2+14,bwit/2,12+wall])
            beveled_hollow(hg=16,lg=20,wd=24);
        // usb hollow
        //translate([bwit/2+6,-blen/2+19,12])
          //  cube([15,18,14]);
        // drills for fixing the board on the slot
        for(y=[-35,30]){
            for(x=[45,-45]){
                translate([x,y,-1])
                    cylinder(h=2*wall,r=1.6);
            }
        }
    }
    
    // fake board, for reference
    %translate([0,0,12]){
        linear_extrude(height=1.6)
            square([bwit,blen],center=true);
        // usb connector
        //translate([bwit/2-15,-blen/2+22,1.8])
          //  cube([15,12,10]);
    }
}


module filament_holder_2(){
    
    difference(){
        hull(){
            cylinder(h=5,r=8,$fn=50);
            translate([120,0,0])cylinder(h=5,r=6,$fn=50);
        }
        
        translate([0,0,-1])cylinder(h=7,r=4.1,$fn=50);
        translate([110,0,-1])hull(){
            cylinder(h=7,r=2.5,$fn=50);
            translate([10,0,0])cylinder(h=7,r=2.5,$fn=50);
        }
        translate([110,-10,-1])cube([10,10,7]);
    }
    translate([110,-4.2,0]){
        cylinder(h=5,r=1.7,$fn=50);
        translate([10,0,0])cylinder(h=5,r=1.7,$fn=50);
    }
}


module full_model_extruder(){
    // Just as reference
    rotate([90,0,0])
    union(){
        %translate([(NEMA17/2)-1,74,57])
        rotate([0,180,0])
            hobbed_mk8();
        %translate([(NEMA17/2)-1,74,35])
            NEMA17();
        
        x_carriage(dejes=30);
        
        color("lightblue")
        translate([0,0,15])
            extruder_holder(erods=true);
        
        translate([18.5,75,54])
        rotate([180,0,-85])
            extruder_idler();
        
        color("lightgreen"){
            extruder();
            extruder(showmount=true);
        }
        
        color("maroon")
        translate([41,13,59.5])
        rotate([-90,0,0])
        union(){    
            translate([2,0,0])fan_pipe(isize=8);
            translate([4,2,-2])fan_nozzle();
        }
    }
}