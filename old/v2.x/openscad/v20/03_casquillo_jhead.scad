
module casquillo_jhead(){
	difference(){
		union(){
			cylinder(h=5.9, r=2.5, $fn=6);
			cylinder(h=0.9, r=5, $fn=50);
		}
		translate([0,0,-2])cylinder(h=10, r=1.1, $fn=20);
	}
}


module fan_holder(){

	difference(){
		union(){
			translate([-12,0,0])cube([24,10,10]);
			translate([-20,-4,0])cube([40,4,10]);
		}
		
		translate([0,-5,5])rotate([-90,0,0])union(){
			translate([-7.5,0,0])cylinder(h=20, r=1.55, $fn=30);
			translate([7.5,0,0])cylinder(h=20, r=1.55, $fn=30);
		
			translate([-7.5,0,0])cylinder(h=8, r=2.55, $fn=50);
			translate([7.5,0,0])cylinder(h=8, r=2.55, $fn=50);
	
			translate([-7.5,0,8])cylinder(h=1.2, r1=2.55, r2=1.55, $fn=50);
			translate([7.5,0,8])cylinder(h=1.2, r1=2.55, r2=1.55, $fn=50);
	
			translate([-16,0,0])cylinder(h=10, r=1.55, $fn=30);
			translate([16,0,0])cylinder(h=10, r=1.55, $fn=30);
	
			translate([-16,0,2])rotate([0,0,30])cylinder(h=15, r=3.1, $fn=6);
			translate([16,0,2])rotate([0,0,30])cylinder(h=15, r=3.1, $fn=6);
	
			//color("pink")translate([-15,-20,0])cube([30,20,30]);
		}
	}
}


module portainductivo(metrica=12){

offset = metrica==12 ? 1.25 : 1.35;

difference(){
	union(){
		translate([2,6,-1])rotate([0,0,90])difference(){
		
				translate([-2.75,7,1])rotate([90,0,0])
					hull(){
						translate([5,4.5,0])cylinder(h=10, r=4.5, $fn=50);
						translate([0,0,0])cube([2,20,10]);
					}
				translate([4,2,5])rotate([90,0,0])
					cylinder(h=15, r=1.55, $fn=50);
		}
		difference(){
			translate([0,-metrica/4,0])hull(){
				cylinder(h=5, r=(metrica/2)+2, $fn=80);
				translate([0,-metrica/2,0])
					cylinder(h=5, r=(metrica/2)+2, $fn=80);
			}
		
			translate([0,-metrica/4,-3])
				cylinder(h=15, r=(metrica/2)+0.1, $fn=50);
			translate([0,0,2.5])rotate([90,0,0])
				cylinder(h=25, r=1.6, $fn=50);
			#translate([-3.05,-offset*metrica,-3])cube([6.05,4.15,10]);
		}
	}
	translate([-17,5,-5])cube([20,20,40]);
	}
}


// -----------------------------------

//color("pink")casquillo_jhead();

//rotate([90,0,0])color("red")fan_holder();

portainductivo();
