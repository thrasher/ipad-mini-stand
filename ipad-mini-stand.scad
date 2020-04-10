use<Write.scad/Write.scad> // git submodule add https://github.com/rohieb/Write.scad.git
//all dimentions in millimeters

$fs = 0.1; // mm per facet in cylinder
$fa = 2; // degrees per facet in cylinder
$fn = 140;

outside_dia = 90; // 100 for ipad mini
thickness=outside_dia/10;
ipad_thickness = 7.7; // iphone5 is 7.6mm thick
lip_height=3.5;
charger_hole=10;

module slot(LIP_WIDTH = 40, ADD_CHARGER_PORT = false) {
	translate([0,0,outside_dia/2]) {
		cube(size = [ipad_thickness,outside_dia,outside_dia], center = true);

		translate([-outside_dia, -outside_dia/2, -outside_dia/2 + lip_height])
		cube(size = [outside_dia,outside_dia,outside_dia], center = false);
	}
	// translate([50,0,10])
	// rotate([0,270,0]) cylinder(d=20, h=200);

	if (ADD_CHARGER_PORT) {
		// hole for charger cable
		translate([0,0,-30]) {
			hull() {
				translate([0, 3, 0])
				cylinder(d=ipad_thickness, h=50);
				translate([0, -3, 0])
				cylinder(d=ipad_thickness, h=50);
			}
		}
	}

	// left and right lip cutoffs
	// LIP_WIDTH = 40;
	translate([-50, -50 - LIP_WIDTH/2, 50])
	cube(100, center = true);
	translate([-50, 50 + LIP_WIDTH/2, 50])
	cube(100, center = true);
}

module base() {
	difference() {
		translate([0,0,outside_dia * 0.20]) {
			difference() {
				sphere(d = outside_dia);
				sphere(d = outside_dia-thickness);

				translate([-40*outside_dia/100,0,0])
				rotate([0,45,0])
				slot(45, true);

				translate([38*outside_dia/100,0,0])
				rotate([0,15,180])
				slot(47);

			}
		}

		// cut off bottom
		translate([0,0,-outside_dia/2]) {
			cube(size = [outside_dia,outside_dia,outside_dia], center = true);
		}
	}

	// add writing
	// note: there appears to be a bug in Write.scad where negative radius spherical text renders at the wrong thickness (t)
	// so we chop it off with another sphere!
	text_thickness=2;
	translate([0,0,outside_dia * 0.20]) {
		difference() {
			color([0,1,1]) {
				rotate([0,-18,0])
				writesphere(text="Thrasher        2020", where=[0,0,0], radius=-(outside_dia/2-thickness), font = "orbitron.dxf", rounded=true,  east=90, h=outside_dia/10, text_thickness=1);
				// rotate([0,-16,180])
				// writesphere(text="  Give    Thanks", where=[0,0,0], radius=-(outside_dia/2-thickness), font = "orbitron.dxf", rounded=true,  east=90, h=outside_dia/10, text_thickness=1);
			}
			echo(outside_dia/2);
			echo(outside_dia/2-7);
			sphere(d = outside_dia-thickness-text_thickness);
		}
	}
}

PART = "all";
if (PART == "base") {
	echo("render base");
	base();
} else {
	// render as assembly
	echo("render all parts");
	color("grey") base();
}


