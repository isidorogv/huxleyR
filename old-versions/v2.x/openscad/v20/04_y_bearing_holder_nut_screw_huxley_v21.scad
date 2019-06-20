
module y_bearing_holder(){

	difference(){
		union(){			
			translate([0,0,-2])hull(){
				translate([0,0,-7.7])cube([13.5,16.5,5]);
				translate([12.15,22.25,-7.7])cylinder(h=5,r=5,$fn=60);
			}
			
			translate([0,0,-2])hull(){
				translate([54.8,0,-7.7])cube([13.5,16.5,5]);
				translate([56.15,22.25,-7.7])cylinder(h=5,r=5,$fn=60);
			}
			
			color("cyan")translate([0,-1.50,-7]){
				translate([0,-1,-2.7])cube([68.3,18.5,5]);
			}
			// LM6UU bearing clamps
			color("orange")translate([3.3,-2.5,-4.7])cube([15,18.5,4.75]);
			color("orange")translate([49.8,-2.5,-4.7])cube([15,18.5,4.75]);
		}

		translate([78.3,15.25,0])union(){
			// M3 fixing screws and nuts 
			translate([-66.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-66.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			translate([-22.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-22.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			// bearings and smooth rod
			translate([-58,-8.5,-1])rotate([0,-90,0])
				cylinder(h=19,r=6.1,$fn=60);
			#translate([-11.5,-8.5,-1])rotate([0,-90,0])
				cylinder(h=19,r=6.1,$fn=60);
			translate([-100,-2.25,-2.95])difference(){
				cube([100,4,4]);	
				color("pink")translate([-2,0,0])rotate([0,90,0])
					cylinder(h=105, r=3, $fn=50);
			}
			translate([0,-14.7,-2.95])rotate([0,0,180])difference(){
				cube([100,4,4]);	
				color("pink")translate([-2,0,0])rotate([0,90,0])
					cylinder(h=105, r=3, $fn=50);
			}
			// cut for filament saving
			translate([-49.3,-65,0])hull(){
				translate([0,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([0,20,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,20,-15])cylinder(h=20,r=5,$fn=50);
	
			}
			translate([-49.3,-25,0])hull(){
				translate([0,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,0,-15])cylinder(h=20,r=5,$fn=50);
				translate([0,10,-15])cylinder(h=20,r=5,$fn=50);
				translate([10,10,-15])cylinder(h=20,r=5,$fn=50);
			}
		}
	}
}



// -----------------------------------------


y_bearing_holder();
mirror([0,1,0])translate([0,10,0])y_bearing_holder();





