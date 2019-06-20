module porta_melzi(){
	rotate([180,0,0])difference(){
		hull(){
			cylinder(h=8,r=4,$fn=50);
			translate([8,0,0])cylinder(h=8,r=4,$fn=50);
		}
		
		cylinder(h=15,r=1.6,$fn=30);
		translate([0,0,-2])cylinder(h=5,r=3.2,$fn=6);
		hull(){
			translate([8.5,0,-2])cylinder(h=15,r=1.6,$fn=30);
			translate([6.5,0,-2])cylinder(h=15,r=1.6,$fn=30);
		}
	}
}



translate([0,5,0])porta_melzi();
translate([0,-5,0])porta_melzi();
translate([0,15,0])porta_melzi();
translate([0,-15,0])porta_melzi();