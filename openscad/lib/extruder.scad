// Direct Extruder for Huxley i3 3D Printer/Foldarap DDE v3.0
// Based on https://www.thingiverse.com/thing:147705, by ffleurey
// Distributed under the terms of GNU/GPL v3.0 or higher

// Modifications by Isidoro Gayo (isidoro.gayo@wgmail.com)
// https://github.com/isidorogv/Huxley-reloaded
// Distributed under the terms of GNU/GPL v3.0 or higher

// -----------------------------------------------------------------


module extruder_idler(thk=9){
 
    difference(){   
        union(){
            // main body
            translate([-15,18,0])
            hull(){
                for(x=[5,-5]){
                    translate([x,-x,0])
                        cube([28,1,thk]);    
                }
            }
            // arm
            translate([-27,21,0]){
                cylinder(h=thk,r=3);
                translate([0,-3,0])
                    cube([33,6,thk]);
            }
            // reinforcement piece
            translate([-10,10,0])
                cube([10,14,thk]);
            // idler axis
            translate([15.5,15.5,0])
                cylinder(h=thk,r=3.5);
            // bearing axis    
            translate([0,10,0])
                cylinder(h=2,r=6);
        }
        // M3 pivot axis
        translate([15.5,15.5,-1])
            cylinder(h=thk+2,r=1.6);
        // M4 bearing axis
        translate([0,10,-1]){
            cylinder(h=thk+2,r=1.6);
            // bearing room
            translate([0,0,3])
                cylinder(h=thk+2,d=15+ease);
        }
        // M4 pushing screw drill
        translate([-21,0,thk/2])
        rotate([-90,0,0])
            hull(){
            for(x=[-2,2]){
                translate([x,0,0])
                    cylinder(h=25,r=2.1);
            }
        }
        // internal rounded corner 
        translate([-14,10,-1])
            cylinder(h=thk+2,d=16);
    }
    // bearing bevel
    translate([0,10,0])
    difference(){
        cylinder(h=2.5,r=3);
        cylinder(h=thk+2,r=1.6,center=true);
    }
}

module extruder_holder(){
    
    difference(){
        // Preform
        union(){
            // Extruder fixing body
            translate([0,6,0])cube([40,45,5]);
            // Contact plane carriage-holder
            translate([0,35,0])cube([40,18,25]);
        }
        // Upper fixing screws + nuts...
        for(pos=[[8.5,48.5,2],[31.5,48.5,2]]){
            translate(pos){
                rotate([0,0,30])
                    cylinder(h=3,r=3.2,$fn=6);
                translate([-2.75,0,0])
                    cube([5.52,20,3]);
                translate([0,0,-10])
                    cylinder(h=20,r=1.6);
            }
        }
        // ... and the lower ones
        for(pos=[[14,20,0],[26,20,0]]){
            translate(pos){
                // screw drill...
                translate([0,0,-5])
                    cylinder(h=25,r=1.6);
                // ... and recess nut
                translate([0,0,2])
                rotate([0,0,30])
                    cylinder(h=5,r=3.2,$fn=6);
            }
        }
        // fixing parts for hotend
        for(pos=[[7.5,43,20],[23.5,43,20]]){
            translate(pos){
                // drill screw
                translate([0,0,-5])
                    cylinder(h=25,r=1.6);
                // nut
                rotate([0,0,30])
                    cylinder(h=3,r=3.2,$fn=6);
                // room for nut
                translate([-2.75,-10,0])
                    cube([5.5,10,3]);
            }
        }
        // Hole for x endstop
        translate([5,22,-5])
            cylinder(h=15,r=1.2);
        translate([35,22,-5])
            cylinder(h=15,r=1.2);
        // upper right bevel
        translate([35,48,-2])
            rounded_corner();
        // upper left bevel
        translate([5,48,-2])
        rotate([0,0,90])
            rounded_corner();
        // lower bevel
        translate([-5,11,0])
        rotate([0,-90,180])
            rounded_corner(lg=50);
    }
    // reinforcement
    translate([0,28,12])rotate([0,90,0])rounded_corner(lg=40,rd=7);
}


module extruder(){
    difference(){
        union(){
            difference(){
                union(){
                    // hotend holder
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
                translate([15.5,34.5,49])rotate([-90,180,0])
                    hotendhead();
                translate([(NEMA17/2)-1,74,40])nema17drills();
                translate([(NEMA17/2)-1,74,43])
                    nema17drills(hg=10,dia=7);
                // M3 nut holes for hotend
                translate([3,45,35])rotate([0,0,90])union(){
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
        // side bevels on hotend holder
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
    // motor holder
    difference(){
        translate([(NEMA17/2)-1,74,40])nema17collar();
    
        translate([4.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
        translate([35.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
        translate([35.5,58.5,43])cylinder(h=10,r=3.6,$fn=70);    
    }
    // extruder mount
    difference(){
        // hotend holder
        color("lightgrey")
        translate([-1,35,54])
            cube([NEMA17+2,17.5,5]);
        // hotend head
        translate([15.5,34.5,49])
        rotate([-90,0,0])
            hotendhead();
        // M3 nut holes for fixing the hotend
        translate([3,45,45])rotate([0,0,90])union(){
            translate([-2,-4.5,0])cylinder(h=25,r=1.6,$fn=60);    
            translate([-2,-20.5,0])cylinder(h=25,r=1.6,$fn=60);
        }
        // Rounded corner
        translate([50,47.5,54])rotate([0,-90,0])rounded_corner(lg=60);
    }
}


module fan_pipe(l=45,isize=8){
 
// Support for an axial fan (diameter 45 mm)
// isize = inductive diameter, default for a M8 inductive
    
    difference(){
        union(){
            // main body
            difference(){
                difference(){
                    cube([14,19,l+5]);
                
                    translate([2,2,-5])
                        cube([10,15,1.5*l]);
                    translate([0,16,l+25])
                    rotate([0,90,0])
                        cylinder(h=35,r=25,$fn=90);
                }
                // fixing slot for axial fan
                translate([0,0,l-5])
                difference(){
                    translate([-2,-3,0])
                        cube([20,25,12]);
                    translate([1,1,-2])
                        cube([12,17,15]);
                }
            }
            // upper fixing screw
            translate([0,9.5,l-10])
            rotate([0,90,0])
                cylinder(h=14,r=3.5,$fn=80);
            // inductive holder
            translate([((isize+4)/2)+14,9.5,0])
            difference(){
                union(){
                    hull(){
                        translate([-(isize+4)/2,-(isize+4)/2,0])
                            cube([1,isize+4,10]);
                        cylinder(h=10,r=(isize+4)/2,$fn=80);
                    }
                    translate([isize/2,-2,0])
                    difference(){
                        // inductive clamp
                        cube([8,4,10]);
                    
                        // M3 drill to get the slot tight
                        translate([5,10,5])
                        rotate([90,0,0])
                            cylinder(h=20,r=1.6,$fn=60);
                        // rounded corners in inductive clamp
                        for(r=[0,90]){
                            translate([3,6,5])
                            rotate([90,r,0])
                                rounded_corner(lg=10);
                        }
                    }
                }
                // internal hole for inductive sensor
                translate([0,0,-5])
                    cylinder(h=25,r=(isize/2)+0.1,$fn=60);
                // adjustement slot
                translate([0,-0.5,-5])cube([2*isize,1,25]);
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
        // test: plano de corte
        //color("red")translate([-20,-20,-l/2])cube([60,30,2*l]);
    }
}


module fan_nozzle(){

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
        //color("grey")
        hull(){
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
