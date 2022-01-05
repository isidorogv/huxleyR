//---------------------------------------------------------------
//-- 3D printed pieces for Huxley i3 3D printer
//---------------------------------------------------------------
// (c) 2016-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)
// Credits:
//-- Some files have been taken from other authors:
//      ffleurey (https://www.thingiverse.com/thing:148358)
//---------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//---------------------------------------------------------------

include <lib/core.scad>
include <lib/X_axis.scad>
include <lib/Y_axis.scad>
include <lib/Z_axis.scad>
include <lib/misc.scad>
include <lib/extruder.scad>


// Parameters to modify. 
// Try to NOT modify variables in other places.
NEMA14=34;      // NEMA14 width in mm
NEMA17=42;      // NEMA17 width in mm
wslot = 22;		// aluminum slot width (wslot)
lslot = 2*wslot;	// aluminum slot lenght (lslot)
altop = 20;			// preform height
thwall = 3;			// wall thickness (thwall)
footl=2.5*wslot;// foot lenght
ease=0.2;       // clearance to fit the aluminum profile easier
stepper=17;     // type of stepper motor;e.g. 14 = NEMA14, and so...

// Frog for mini heatbed by F. Malpartida
lfrog=132;          // frog dimension from left to right in mm
wfrog=70;           // frog dimension from back to front in mm
rlm6=6;             // LM6 bearing radius (rbearing)
llm6=20;            // LM6 lenght (lbearing)
rrod=3;         // smooth rod radius in mm
drod=130;       // distance between Y rods in mm
bhole=95.25/2;      // M3 hole distance from bed center

// Power supply values
PSU_footprint_width = 98;
PSU_footprint_height = 40;
height_from_base = 70;

IEC_width = 27;
IEC_heigth = 20;

switch_width = 19;
switch_height = 13;

// Board case
blen=110;       // board lenght in mm
bwit=80;        // board widht in mm
offscrew=3.5;   // offset for board fixing screws

$fn = 50;

// -------- X axis --------

x_carriage(daxis=32);

//translate([-80,0,0])
    //x_motor_holder(th=6);

/*
mirror([1,0,0])
translate([52,55,0])
rotate([0,0,180])
    x_motor_idler();
*/

// this is a belt tensioner
//translate([25,29,21])
//rotate([90,0,180])
  //  x_bearing_holder(span=13);

//translate([0,20,0])
//    knob(thk=6,dia=18,nk=16,dk=1.5,f=8);

// adjustable endstop head
//knob(dia=12,spc=true,thk=3,dk=2,nk=14);
//x_endstop_holder();



// -------- Y axis --------

// Feet pieces must be printed twice!!
//mirror([1,0,0])
  //  foot();

//translate([-25,0,0])
    //y_bearing_idler();

//y_motor_holder(hg=10,th=10,stepper=17);

// Print four times the following piece
//y_smooth_rod_holder();

// Y endstop adjustement, print just one
//knob(dia=12,spc=true,thk=3,dk=2,nk=14);

//rotate([0,90,0])
  //  heatbed_wire_fastener();

//frog();

//y_belt_clamp();

// Thumb wheel (print four times!)
//rotate([180,0,0])
  //  knob(dia=8,thk=3,nk=10,dk=3,f=6,spc=false);

// endstop holder
//y_endstop_adj();


// -------- Z axis --------

// Print twice base piece!!
//base();

//mirror([0,1,0])
  //  z_motor_holder(stepper=17);

// Print twice upper_union piece!!
//upper_union(largo=wslot,ancho=lslot,thick=7.5);

// Print twice slot lid piece!!
//z_slot_lid(th=thwall);




// -------- Direct Extruder --------

//extruder();

//translate([0,0,15])
  //  extruder_holder();

//mirror()
    //extruder_idler();

// Default diameter for inductive 
// sensor is M8. For other sensor sizes
// set isize variable to 12 (M12) and so...
//fan_pipe(l=40);

//rotate([90,0,0])
  //  fan_nozzle();

//rotate([180,0,0])
  //  knob(dia=10,nk=8,thk=5,mt=4,dk=2,spc=false);



// -------- Miscelaneous --------

//rotate([0,0,90])
    //psu_holder(wth=2);

//rotate([0,180,0])
  //  spool_holder_arm();
//spool_holder_clamp();
//knob(dia=45,thk=10,nk=20,dk=6,mt=8);

//rotate([90,0,0])
  //  psufastener();

// case for GT2560 A+
//board_case();

/*
translate([1.5*bwit,0,0])
color("lightgrey")
translate([0,0,42])
rotate([0,180,0])*/
 //   case_lid();

//arm_holder();

//filament_holder_2();

//cable_guard();

