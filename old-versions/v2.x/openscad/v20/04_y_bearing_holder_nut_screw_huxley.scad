
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
			//color("orange")translate([13,-40,-9.7])cube([42,45,5]);
			// donde agarran los rodamientos LM6UU
			//translate([0,-2.5,-4.7])cube([13.5,18.5,9]);
			//translate([54.8,-2.5,-4.7])cube([13.5,18.5,9]);
			color("orange")translate([3.3,-2.5,-4.7])cube([15,18.5,4.75]);
			color("orange")translate([49.8,-2.5,-4.7])cube([15,18.5,4.75]);
		}

		translate([78.3,15.25,0])union(){
			// tornillos y tuercas de fijacion a la bandeja
			translate([-66.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-66.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			translate([-22.15,7,-10])cylinder(h=15,r=1.65,$fn=30);
			translate([-22.15,7,-7.5])cylinder(h=5,r=3.15,$fn=6);
			// rodamientos y barra lisa
			//translate([5,-8.5,0])rotate([0,-90,0])
			//	cylinder(h=100,r=6.1,$fn=60);
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
			// huecos rectangulares redondeados
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

module belt_holder(altura){
	difference(){
		color("red")rotate([0,0,180])hull(){
			translate([0,0,-10])cylinder(h=altura,r=5,$fn=50);
			translate([0,21,-10])cylinder(h=altura,r=5,$fn=50);
		}
		translate([0,-2.7,-10.5])union(){
			cylinder(h=altura+5,r=1.65,$fn=30);
			translate([-8,-3.3,altura-5])cube([16,6,3]);
		}
		translate([0,-18.7,-10.5])union(){
			cylinder(h=altura+5,r=1.65,$fn=30);
			translate([-8,-3.3,altura-5])cube([16,6,3]);
		}
	}
}



module belt_clip(altura,pitch = 2.5){
	difference(){
		color("orange")rotate([0,0,180])hull(){
			translate([0,0,0])cylinder(h=altura,r=5,$fn=50);
			translate([0,21,0])cylinder(h=altura,r=5,$fn=50);
		}
		// agujero para los tornillos fijadores
		translate([0,-2.7,-2])cylinder(h=altura+5,r=1.65,$fn=30);
		translate([0,-18.7,-2])cylinder(h=altura+5,r=1.65,$fn=30);
		// hueco para la correa
		translate([-8,-13.5,altura-0.5])cube([16,6,2.5]);
		for (i=[0:5]) {
	    	translate([-5+pitch*i, -13.5, altura-1.5]) cube([1.6, 6, 1.5]);  
		}
	}
}


module y_carriage(){

	difference(){
		union(){
			cube([145,30,4.9]);
			translate([0,0,4.9])cube([2.5,30,2.1]);
			translate([142.5,0,4.9])cube([2.5,30,2.1]);
		
			translate([43.5,-11,0])difference(){
				cube([27,52,4.9]);
		
				translate([5.5,7,-2])cylinder(h=10, r=1.6, $fn=60);
				translate([5.5,7,2])cylinder(h=10, r=3.2, $fn=6);
				translate([21.5,7,-2])cylinder(h=10, r=1.6, $fn=60);	
				translate([21.5,7,2])cylinder(h=10, r=3.2, $fn=6);
				translate([5.5,45,-2])cylinder(h=10, r=1.6, $fn=60);	
				translate([5.5,45,2])cylinder(h=10, r=3.2, $fn=6);
				translate([21.5,45,-2])cylinder(h=10, r=1.6, $fn=60);	
				translate([21.5,45,2])cylinder(h=10, r=3.2, $fn=6);
			}
		}

		translate([15,5,-2])cube([32,20,15]);
		translate([67,5,-2])cube([63,20,15]);
	}
}


// -----------------------------------------

/*
translate([0,0,10]){
y_bearing_holder();
//translate([18.5,-11,5.3])belt_holder(13);
//translate([49.5,-11,5.3])belt_holder(13);
//mirror([0,1,0])translate([0,75.5,0])y_bearing_holder();
mirror([0,1,0])translate([0,10,0])y_bearing_holder();
}
//translate([-5,-16,0])belt_clip(altura = 5);
//translate([-20,-16,0])belt_clip(altura = 5);
*/


y_carriage();


