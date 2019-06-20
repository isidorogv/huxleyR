
// The begining, the main piece
// altura = height
// ancho = length
// fondo = witdh
// pared = wall thickness
module preform(altura, ancho, fondo, pared=2.7){
	difference(){
		union(){
			hull(){
				translate([0,0,0])cylinder(h=altura, r=pared, $fn=90);
				translate([ancho,0,0])cylinder(h=altura, r=pared, $fn=90);
				translate([ancho,fondo,0])cylinder(h=altura, r=pared, $fn=90);
				translate([0,fondo,0])cylinder(h=altura, r=pared, $fn=90);
			}
		}
		// hollow for aluminun slot
		#translate([-0.1,-0.1,-1])cube([ancho+0.2,fondo+0.2,altura+2]);
	}
}

// Where the vertical and horizontal slots are joined
// altura = height
// ancho = width
// pared = wall thickness
// perfil = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
// mtor = screw metric; 3 = M3, 4 = M4 (don't use metric higher than M3)
module base(alto=48, pared=2.7, perfil=fondop,mtor=3){

	difference(){
		union(){
			preform(altura=alto, ancho=anchop, fondo=fondop, pared=pared); 

			color("pink")translate([anchop+2.1,-perfil,0])
				cube([perfil+pared,3*perfil,12]);

			color("cyan")translate([anchop+2.1,-perfil,0])
				cube([pared,3*perfil,alto]);

			color("red")translate([anchop+0.1,-2.7,0])
				cube([pared,perfil+5.4,alto]);
		}
		// holes for fixing screws (vertical slots)
		translate([-1.5*pared,11,alto/2])rotate([0,90,0])
			cylinder(h=60,r=(mtor/2)+0.1,$fn=30);
		// hollow for feet
		translate([anchop+(perfil/2)+pared+2,60,-1])rotate([90,0,0])hull(){
			cylinder(h=100,r=perfil/3, $fn=6);
			translate([0,perfil/3,0])
				cylinder(h=100,r=perfil/6, $fn=6);
		}
		// hollow for plastic saving
		#translate([55,-7,-10])hull(){
			translate([0,0,0])cylinder(h=alto, r=pared, $fn=90);
			translate([20,0,0])cylinder(h=alto, r=pared, $fn=90);
			translate([20,36,0])cylinder(h=alto, r=pared, $fn=90);
			translate([0,36,0])cylinder(h=alto, r=pared, $fn=90);
		}
		// holes for fixing screws (horizontal slots)
		translate([anchop+(perfil/2)+pared+2,perfil+15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,0])
			cylinder(h=30, r=(mtor/2)+0.1, $fn=60);
		// holes for screw heads
		translate([anchop+(perfil/2)+pared+2,perfil+15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		translate([anchop+(perfil/2)+pared+2,-15,-1])
			cylinder(h=10.5, r=3, $fn=60);
		// some screws for horizontal slots (reinforcement)
		translate([anchop-1,-15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		translate([anchop-1,perfil+15,(perfil/2)+13])rotate([0,90,0])
			cylinder(h=5*pared, r=(mtor/2)+0.1, $fn=60);
		// side bevel on the wall of horizontal slot
		translate([anchop-2,-26,25])rotate([45,0,0])cube([10,50,50]);
		translate([anchop-2,13,60])rotate([-45,0,0])cube([10,50,50]);
		// fixing screws for conection wiring box
		translate([11,-5,35])rotate([-90,0,0])
			cylinder(h=alto, r=1.6, $fn=90);
		translate([33,-5,35])rotate([-90,0,0])
			cylinder(h=alto, r=1.6, $fn=90);
	}
}



// largo = lenght
// ancho = width
// espesor = thickness
// this piece joints the vertical side slots to the horizontal upper one
module upper_union(largo,ancho,espesor=7){

	difference(){
		cube([largo,ancho,espesor]);
		union(){
			translate([ancho/2,ancho/2,-2])
                cylinder(h=10,r=2.6,$fn=30);
			translate([ancho/2,ancho/2,3.5])
                cylinder(h=10,r=4.55,$fn=50);

			translate([3*ancho/2,ancho/2,-2])
                cylinder(h=10,r=2.6,$fn=30);
			translate([3*ancho/2,ancho/2,3.5])
                cylinder(h=10,r=4.55,$fn=50);

			translate([2.5,ancho/2,-2])
                cylinder(h=10,r=1.6,$fn=50);
			translate([largo-2.5,ancho/2,-2])
                cylinder(h=10,r=1.6,$fn=50);
		}
	}
}

// ht = piece height
module upper_clip(ht=7){

	translate([1,-2,0])difference(){
		union(){
			difference(){
				union(){
					// preform
					translate([8,-4,0])cube([NEMA14+1,0.72*NEMA14,ht]);
					// espacer
					translate([8,-10,0])cube([NEMA14+1,6,ht]);
				}
				union(){
					// hollow for smooth rod
					translate([34,13.9,-2])
						cylinder(h=ht+5, r=3, $fn=50);
					translate([-8,0,0])union(){
						// fixing screw for smooth rod
						translate([47,4,ht/2])rotate([-90,0,0])
							cylinder(h=20, r=1.6, $fn=50);
						// hole for M3 fixing nut
						translate([44.25,7,-2])cube([5.5,3.2,ht+5]);
					}
				}
			}
		}
			// hole for centering bearing...
			translate([18.5,13.9,ht-5])cylinder(h=6, r=5.58, $fn=60);
			// ... and for the threaded rod
			translate([18.5,13.9,-2])cylinder(h=ht+5, r=2.55, $fn=60);
			// rounded corners
			translate([5.95,17.5,-2])difference(){
				cube([5,5,ht+5]);
				translate([5,0,-2])cylinder(h=ht+5, r=3, $fn=50);
			}
			translate([40,6,-10])rotate([0,0,-90])rounded_corner(rd=3);
			translate([40,17.5,-2])difference(){
				cube([4,4,ht+5]);
				translate([0,0,-2])cylinder(h=ht+5, r=3, $fn=50);
			}
			translate([NEMA14,13.5,-2])cube([15,0.5,ht+5]);
			// some hollow...
			translate([40,-10,-2])hull(){
				cylinder(h=ht+5, r=3, $fn=50);
				translate([0,10,0])cylinder(h=ht+5, r=3, $fn=50);
				translate([23,10,0])cylinder(h=ht+5, r=3, $fn=50);
				translate([23,0,0])cylinder(h=ht+5, r=3, $fn=50);
			}
			translate([14,-5,-2])hull(){
				cylinder(h=ht+5, r=3, $fn=50);
				translate([0,5,0])cylinder(h=ht+5, r=3, $fn=50);
				translate([15,5,0])cylinder(h=ht+5, r=3, $fn=50);
				translate([15,0,0])cylinder(h=ht+5, r=3, $fn=50);
			}
	}
	// Internal corners
	translate([41,-8.5,0])rotate([0,0,180])rounded_corner(rd=3,lg=ht);
	translate([6,-8.5,0])rotate([0,0,-90])rounded_corner(rd=3,lg=ht);
}



// al = height
// la = lenght
// an = width
// this piece clamps the smooth and threaded rods
// and fits in the side aluminum slots 
module z_rod_holder(al=10, la=anchop, an=fondop){

	difference(){
		preform(altura=al, ancho=la, fondo=an);

		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
	translate([0,fondop+pared+8,0])upper_clip(ht=7);
	// Upper cap
	translate([0,0,10])hull(){
		translate([0,0,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([la,0,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([la,an,0])cylinder(h=1.2, r=2.7, $fn=50);
		translate([0,an,0])cylinder(h=1.2, r=2.7, $fn=50);
	}
}



// esp = piece height
module z_motor_holder(esp=5){

	difference(){
		union(){
			translate([NEMA14-4,fondop+pared+6.9,0])rotate([0,0,90])
				portamotor_14(ht=esp);
			// some extra parts
			translate([0,(fondop+pared/2)-2,0])
				cube([NEMA14+4,8,esp]);
			translate([NEMA14,(fondop+pared/2)-2,0])
				cube([4,NEMA14+7.9,esp]);
		}
		// hole for smooth rod
		#translate([NEMA14-1.5,fondop+pared+19.9,-5])
			cylinder(h=70, r=3.1, $fn=30);
		translate([NEMA14-6,fondop+pared+19.5,-5])
			cube([5,0.5,30]);
		// external rounded corner
		translate([NEMA14+0.1,NEMA14+fondop+pared-1,-3])difference(){
			cube([5,5,esp+5]);
			translate([0,0,-3])cylinder(h=20,r=4,$fn=50);
		}
	}
	// drills for side fixing screws
	translate([-2.5,0,0])difference(){
		preform(altura=10,ancho=anchop, fondo=fondop);
		translate([60,fondop/2,5])rotate([0,-90,0])
			cylinder(h=70, r=1.6, $fn=30);
	}
	// reinforcement (rounded internal corner)
	translate([0,fondop+pared+1.5,10])rotate([-90,0,-90])
		rounded_corner(lg=38);
}




