
module porta_tornillo(){

	rotate([0,90,90])difference(){
		union(){
			cylinder(h=10,r=5,$fn=50);
			translate([0,-5,0])cube([17,10,10]);
		}
		
		translate([0,0,-2])union(){
			cylinder(h=20,r=1.6,$fn=30);
			translate([-2.9,-8,5])cube([5.8,16,4]);
		}
	}
}


module ajuste_altura(){

	difference(){
	
		union(){
		color("red")translate([37,0,17])porta_tornillo();
		translate([37,52,17])porta_tornillo();
		}
		import("x-motor-bracket.STL");
		translate([37,-10,7])rotate([-90,0,0])cylinder(h=80,r=1.6,$fn=30);
	}
}


module porta_motor_x(){

	difference(){
		union(){
			color("lightblue")import("x-motor-bracket.STL");
			translate([37,12,0])cube([5,8,10]);	
			translate([37,42,0])cube([5,8,10]);
		}

		translate([37,0,7])rotate([-90,0,0])cylinder(h=15,r=1.6,$fn=30);
		translate([37,47,7])rotate([-90,0,0])cylinder(h=15,r=1.6,$fn=30);
		//translate([0,0,7])cube([100,80,30]);
		// huecos para las tuercas
		translate([34,49.5,-10])cube([6,3,30]);
		translate([34,9.5,-10])cube([6,3,30]);
	}
}



//porta_motor_x();
//rotate([-90,0,0])
ajuste_altura();
