
include <huxley_modules.scad>
include <huxleyi3_X_axis.scad>
include <huxleyi3_Y_axis.scad>
include <huxleyi3_Z_axis.scad>
include <huxleyi3_misc.scad>


// Parameters to modify. 
// Try to NOT modify variables in other places.
fondop = 22;		// aluminum slot width
anchop = 2*fondop;	// aluminum slot lenght
altop = 20;			// preform height
pared = 6;			// wall thickness


PSU_footprint_width = 98;
PSU_footprint_height = 40;
height_from_base = 70;

IEC_width = 27;
IEC_heigth = 20;

switch_width = 19;
switch_height = 13;

wall_thickness = 2;


// -------- X axis --------

//mirror([1,0,0])geared_extruder();

x_carriage();

//x_endstop_adj();

// NEMA14-17 steppers are test pieces, don't print them
//translate([-55,45,21])rotate([90,0,0])NEMA14();
//translate([-55,45,21])rotate([90,0,0])NEMA17();
//translate([-80,0,0])x_motor_holder();

//mirror([1,0,0])translate([-100,0,0])x_motor_idler();

//translate([20,-15,5])rotate([0,90,90])x_belt_tensioner();


// -------- Y axis --------

//foot();
//translate([-5,0,0])mirror([1,0,0])foot();
//translate([0,-5,0])mirror([0,1,0])foot();
//translate([-5,-5,0])mirror([1,0,0])mirror([0,1,0])foot();

//rotate([0,90,0])y_bearing_idler();

//y_motor_holder(espesor=10);

//y_smooth_rod_holder();
//translate([0,15,0])y_smooth_rod_holder();
//translate([30,0,0])y_smooth_rod_holder();
//translate([30,15,0])y_smooth_rod_holder();

//y_endstop_adj();

//rotate([0,90,0])heatbed_wire_fastener();


// -------- Z axis --------

//base();
//translate([0,70,0])base();

//translate([0,10,0])z_motor_holder();
//mirror([0,1,0])z_motor_holder();

//upper_union(largo=anchop,ancho=fondop);
//translate([0,-30,0])upper_union(largo=anchop,ancho=fondop);

//translate([10,0,0])z_rod_holder();
//mirror([1,0,0])z_rod_holder();


// -------- Miscelaneous --------

//ramps_holder();
//rotate([0,0,90])psu_holder();

// Spool holder, you'll need:
//		foot() - x4
//		slot_holder_cross() - x2
//		upper_crow() - x2
//		slot_clamp() - x18	
//		M3 screws - x18
//		M3 nut - x18
//		M8 threaded rod - 16 or 17cm
//		SpoolHolder_Prusai3.stl - x2
//		608ZZ bearing - x2
//		M8 nut - x2
//spool_holder_cross();
//spool_upper_crow();

//guardacable(longitud=30);

//rotate([90,0,0])psufastener();

//slot_clamp();

//endstop_head_adj();

