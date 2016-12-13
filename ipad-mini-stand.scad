use<Write.scad/Write.scad> // git submodule add https://github.com/rohieb/Write.scad.git
//all dimentions in millimeters

$fs = 0.1; // mm per facet in cylinder
$fa = 5; // degrees per facet in cylinder
$fn = 100;

outside_dia = 150; // 100 for ipad mini
thickness=outside_dia/10;
ipad_thickness = 12.5;
lip_height=6;
charger_hole=10;

module slot() {
	translate([0,0,outside_dia/2]) {
		cube(size = [ipad_thickness,outside_dia,outside_dia], center = true);
		translate([-outside_dia, -outside_dia/2,-outside_dia/2+lip_height]) cube(size = [outside_dia,outside_dia,outside_dia], center = false);
	}
	translate([50,0,10])
	rotate([0,270,0]) cylinder(d=20, h=200);

	// hole for charger cable
	// rotate([0,0,0])
	// translate([0,0,-30])
	// cylinder(d=charger_hole, h=200);
}


difference() {
	translate([0,0,outside_dia * 0.20]) {
		difference() {
			sphere(d = outside_dia);
			sphere(d = outside_dia-thickness);

			translate([-40*outside_dia/100,0,0])
			rotate([0,45,0])
			slot();

			translate([38*outside_dia/100,0,0])
			rotate([0,15,180])
			slot();

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
			rotate([0,-16,0])
			writesphere(text="IFTTT  2016", where=[0,0,0], radius=-(outside_dia/2-thickness), font = "orbitron.dxf", rounded=true,  east=90, h=outside_dia/10, text_thickness=1);
			rotate([0,-16,180])
			writesphere(text="Pride in Craft", where=[0,0,0], radius=-(outside_dia/2-thickness), font = "orbitron.dxf", rounded=true,  east=90, h=outside_dia/10, text_thickness=1);
		}
		echo(outside_dia/2);
		echo(outside_dia/2-7);
		sphere(d = outside_dia-thickness-text_thickness);
	}
}