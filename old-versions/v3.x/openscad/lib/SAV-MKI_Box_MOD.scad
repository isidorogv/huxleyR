// SAV MkI housing box, by Francisco Malpartida
// https://www.thingiverse.com/thing:180565
// Distributed under the terms of Creative Commons: 
//        Attribution - Share Alike 

// Modifications by Isidoro Gayo (isidoro.gayo@wanadoo.es)
// https://github.com/isidorogv/Huxley-reloaded
// Distributed under the same terms of the original files.

// ---------------------------------------------------------

$fn = 25;
postHight = 8;  // modificado
shellWidth = 1.5;
boxHight = 23 + postHight;  // modificado
pcbHight = 1.6;


// modificados diametros de las bases
module SAVMKIPosts ( hight )
{
	translate ([3.81, 3.81, 0])
	{
		difference ()
		{
			cylinder ( h = hight+2, r2 = 2.5, r1=6);
			cylinder ( h = hight+2, r = 1.2 );
		}
	}
	translate ([96.52, 3.81, 0])
	{
		difference ()
		{
			cylinder ( h = hight+2, r2 = 2.5, r1=6);
			cylinder ( h = hight+2, r = 1.2 );
		}
	}
	translate ([96.52, 60.96, 0])
	{
		difference ()
		{
			cylinder ( h = hight+2, r2 = 2.5, r1=6 );
			cylinder ( h = hight+2, r =1.2 );
		}
	}
	translate ([3.81, 60.96,0])
	{
		difference ()
		{
			cylinder ( h = hight+2, r2 = 2.5, r1=6 );
			cylinder ( h = hight+2, r =1.2 );
		}
	}
}

// modificadas dimensiones para espacio de cables
module SAVMKIBoard (hl=1,offset=true)
{
	minkowski ()
	{
		translate ([3.81,3.81,0])
			cube ([123-(2*3.81), 75-(2*3.81), hl]);
		cylinder(r=4.5, h=hl, $fn=50);
	}
}

// modificado espesor de paredes
module SAVMKIOuter (espesor=1)
{
	minkowski ()
	{
		SAVMKIBoard (hl=espesor);
		cylinder ( r = 2.2, h = 0.1 );
	}
}

module supplyCon ( )
{
	cube ([7.5, 10.6, 8], center = true);
}

module USBCon ()
{
	cube ([12, 10, 9], center = true);
}

module uSDCon ()
{
	cube ([10, 17.5, 3], center = true);
	rotate ([0,90,0])
		cylinder (r=5, h=10 );
}


module cubeSlice ()
{
	cube ([220, 200, shellWidth+1.5], center=true);
}

module boardBox ()
{
	// The board
	union()
	{
        // modificada posicion de uSD, usb y de soportes de placa
            translate ([20,5,shellWidth])
                SAVMKIPosts(hight=postHight);
		difference ()
		{
            union(){
                resize([0,0,boxHight], auto=[false,false,true])
                    SAVMKIOuter ( );
                translate([85,77,0])cube([10,4,boxHight]);
            }
            translate([12,5,16])rotate([90,0,0])
                wires_intake(dia=15);
		
			translate ( [36.9, 0, shellWidth+postHight+pcbHight+5])
				USBCon ();
			
			translate ( [123, 20.4, shellWidth+postHight+pcbHight+1.5+2])
				uSDCon ();
		
		
			translate ( [0,0,shellWidth] )
				resize([0,0,boxHight], auto=[false,false,true])
					SAVMKIBoard ( );
		
			//cubeSlice ();
            
            // taladros para tornillos fijadores al marco de aluminio
            translate([0,70,11])rotate([-90,0,0])hull(){
                translate([28,0,0])cylinder(h=20,r=1.6);
                translate([32,0,0])cylinder(h=20,r=1.6);    
            }
            translate([90,70,11])rotate([-90,0,0])
                cylinder(h=20,r=1.6);
		}
	}
}

module wires_intake(dia=10){

    // external wires...
    cylinder(h=10,r=dia/2);
    translate([-dia/2,0,0])cube([dia,30,10]);
    
    // ... and internal ones
    translate([-5,20,-32])rotate([90,90,0])union(){
        hull(){
            cylinder(h=1.2*boxHight,r=dia/2,$fn=60);
            translate([30,0,0])cylinder(h=1.2*boxHight,r=dia/2,$fn=60);
        }
        translate([0,-dia,0])cube([30,dia,1.2*boxHight]);
    }
}

module airIntakes ( diam, num )
{
	for (i=[0:num])
	{
		translate([sin(360*(i+0.5)/num)*diam/2, cos(360*(i+0.5)/num)*diam/2,0])
			cylinder (r=4.5,h=10, $fn=6);
	}
}

// modificada
module boxLid ()
{
	// The Lid
	translate ([0, -90, 0])
	{
		difference ()
		{
			union()
			{
				SAVMKIOuter(espesor=6);
				translate([0,0,shellWidth+10])
					SAVMKIBoard(hl=2);
			}
            // OSHW logo
            translate([60,10,-0.5])rotate([0,0,90])
                scale([1,1,10])import("aux/oshw_logo.stl");
            // Borde de encaje
            translate([0,0,shellWidth])minkowski(){
                translate ([5.81,5.81,0])
                    cube ([119-(2*3.81), 71-(2*3.81), 20]);
                cylinder(r=4.5, h=20, $fn=50);
            }
            // entrada de cables
            /*translate([120,50,-5])union(){
                cylinder(h=30,r=6);
                translate([0,-6,0])cube([12,12,30]);
            }*/
            // SAV logo
            translate([125,43,0])import("aux/SAV_logo.stl");
            //SAV_logo();
		}
	}

	
}


module SAV_logo(){
    
    rotate([180,0,-90])scale([0.1,0.1,0.1])
        linear_extrude(height = 10, center = true, convexity = 10)
            import (file = "SAV_inside.dxf");
    
}
