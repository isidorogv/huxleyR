include <modules.lib>;


// pitch = distance between theeth; T2.5 = 2.5, GT2 = 2
// wbelt = belt thickness
module x_carriage(pitch = 2.5, wbelt = 0.8){

	// LM6UU bearing and smooth rod (lower)
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
	// LM6UU bearing and smooth rod (upper)
	//%translate([0,38,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	//%translate([-20,38,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);

	difference(){
		union(){
			difference(){
				// old huxley carriage, by ReprapPRO team
				import("x-carriage-1off.stl");
			
				translate([-10,16.7-wbelt,4])cube([60,2,15]);
				translate([-10,35,-5])cube([60,60,35]);
			}
			color("pink")for (i=[0:15]) {
		    	translate([0+pitch*i, 16.7, 3]) cube([1, 1.5, 12]);  
			}
			translate([40,48,0])rotate([0,0,180])x_bearing_holder();
			color("orange")translate([0,46.1,0])cube([40,5,15]);
		}
		// M3 screw holes 
		translate([7.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		translate([32.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		translate([7.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
		translate([32.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
		// M3 screw heads
		translate([7.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
		translate([32.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
		translate([7.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
		translate([32.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
		// Some rounded corners
		translate([35,46.1,-10])rounded_corner();
		translate([5,46.1,-10])rotate([0,0,90])rounded_corner();
	}
}


module x_bearing_holder(){

	difference(){
		// old huxley carriage, by ReprapPRO team
		import("x-carriage-1off.stl");
	
		translate([-10,16.2,-4]) cube([60,60,25]);
	}
	// LM6UU bearing and smooth rod
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
}


//  dejes = distance between smooth rods
module x_endstop_adj(dejes=32){

	difference(){
		union(){
			hull(){
				// puente de union entre abrazaderas
				translate([5,0,0])cube([5,dejes,10]);
				// abrazaderas de la barra lisa
				union(){
					cylinder(h=10, r=5, $fn=90);
					translate([0,dejes,0])cylinder(h=10, r=5, $fn=90);
				}	
			}
			// orejeta para tuerca prisionera de ajuste
			translate([12,dejes/2,0])union(){
				cylinder(h=10,r=5,$fn=90);
				translate([-5,-5,0])cube([5,10,10]);
				// tuerca prisionera
				%translate([0,0,3.5])rotate([0,0,30])
					cylinder(h=3,r=3.2,$fn=6);
			}
		}
		// barras lisas
		translate([0,0,-5])union(){
			cylinder(h=20, r=3.05, $fn=90);
			translate([0,dejes,0])cylinder(h=20, r=3.05, $fn=90);
		}
	// rebaje para la correa
	translate([-11.5,-10,-5])cube([10,50,20]);
	translate([-4,5,-5])cube([10,dejes-10,20]);
	// hueco para la tuerca prisionera
	translate([12,dejes/2,-5])cylinder(h=20,r=1.6,$fn=60);
	translate([9,9,3.5])cube([8.5,12,3]);
	}
}


// adjustement piece for Y end stop (piece 1)
module y_endstop_adj(){

	difference(){
		rotate([90,0,0])union(){
			difference(){
				union(){
					cylinder(h=5, r=4, $fn=80);
					translate([-5.5,-4,0])cube([5.5,8,5]);
				}			
				translate([0,0,-3])cylinder(h=10, r=1.6, $fn=50);
			}		
			translate([-15.5,-4,-13])cube([10,8,18]);
			translate([-5.5,0,-13])rotate([0,-90,0])
				cylinder(h=10,r=4,$fn=80);
		}	
		translate([0,13,0])rotate([0,-90,0])
			cylinder(h=20,r=1.6,$fn=80);
		translate([-12,10.25,-7])cube([3,10,15]);
		translate([-10.5,0,-5])rotate([0,0,180])rounded_corner();
	}

}



// altura = height
// radio = radius
// paso = pitch
// metrica = metric; M3 = 3, M4 = 4, and so...
// adjustement piece for end stops (piece 2)
module endstop_head_adj(altura=5, radio=6, paso=25, metrica=3){

	difference(){
		union(){
			cylinder(h=altura/2, r=radio, $fn=radio*10);
			translate([0,0,altura/2])
				cylinder(h=altura/2, r1=radio, r2=radio-(radio*0.25), $fn=90);
		}
		if (metrica == 5){
			translate([0,0,(altura/2)+1])cylinder(h=20, r=4.6, $fn=6);
			translate([0,0,-2.5])cylinder(h=4, r=4.6, $fn=90);
		}else
			{
			translate([0,0,(altura/2)+1])cylinder(h=20, r=3.2, $fn=6);
			translate([0,0,-2.5])cylinder(h=4, r=3.2, $fn=90);
			}
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
		}
	for (ang=[0:paso:360]){
		rotate([0,0,ang])translate([radio,0,0])
			cylinder(h=altura/2, r=1.5, $fn=60);
		}
}


module heatbed_wire_fastener(){

	difference(){
		hull(){
			cylinder(h=18,r=5,$fn=60);
			translate([0,-5,0])cube([20,10,18]);
		}
		translate([0,0,-1])cylinder(h=3,r=3.2,$fn=6);	
		translate([0,0,-5])cylinder(h=25,r=1.6,$fn=50);
		translate([17.5,0,-5])cylinder(h=25,r=3,$fn=80);
		translate([-10,-10,11])cube([20,20,4.1]);
		//translate([17,0,-5])rounded_corner();
		//translate([17,0,-5])rotate([0,0,-90])rounded_corner();
		translate([17.5,-10,-10])cube([20,20,50]);
		// zip ties
		translate([18,0,3])difference(){
			cylinder(h=3,r=6,$fn=80);
			translate([0,0,-1])cylinder(h=7,r=4,$fn=80);
			translate([0,-15,-4])cube([20,30,10]);
		}
		translate([18,0,13])difference(){
			cylinder(h=3,r=6,$fn=80);
			translate([0,0,-1])cylinder(h=7,r=4,$fn=80);
			translate([0,-15,-4])cube([20,30,10]);
		}
	}

}


/* ------------------------------------------------ */

// Test pieces
//NEMA14();
//hobbed_mk7();

// --------------

//x_carriage();
//x_endstop_adj();

//translate([0,20,4])y_endstop_adj();
//color("red")endstop_head_adj();

//rotate([0,90,0])heatbed_wire_fastener();


