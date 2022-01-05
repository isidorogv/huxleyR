// Clip de fijacion en el interior de perfiles de alumino.
// Released under the terms of GNU/GPL v3.0 or higher
// (Copyleft) Isidoro Gayo Velez
// Feb 2015

color("pink")difference(){
	union(){
		cube([10,8,4]);
		translate([0,1.5,4])cube([10,5,1.7]);
	}
	
	translate([5,4,-2])union(){
		cylinder(h=20,r=1.6,$fn=30);
		cylinder(h=5,r=3.2,$fn=6);
	}
}