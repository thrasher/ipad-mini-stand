use<Write.scad/Write.scad> // git submodule add https://github.com/rohieb/Write.scad.git
//all dimentions in millimeters

$fs = 0.1; // mm per facet in cylinder
$fa = 5; // degrees per facet in cylinder
$fn = 100;

outside_dia = 100;
thickness=10;
ipad_thickness = 12.5;
lip_height=6;

module slot() {
	translate([0,0,outside_dia/2]) {
		cube(size = [ipad_thickness,outside_dia,outside_dia], center = true);
		translate([-outside_dia, -outside_dia/2,-outside_dia/2+lip_height]) cube(size = [outside_dia,outside_dia,outside_dia], center = false);
	}
	translate([50,0,10])
	rotate([0,270,0]) cylinder(d=20, h=200);
}


difference() {
	translate([0,0,outside_dia * 0.20]) {
		difference() {
			sphere(d = outside_dia);
			sphere(d = outside_dia-thickness);

			translate([-40,0,0])
			rotate([0,40,0])
			slot();

			translate([38,0,0])
			rotate([0,20,180])
			slot();

		}
	}

	// cut off bottom
	translate([0,0,-outside_dia/2]) {
		cube(size = [outside_dia,outside_dia,outside_dia], center = true);
	}
}

translate([0,0,20])
difference() {
	color([0,1,1]) {
		rotate([0,-17,0])
		writesphere(text="Pride in Craft", where=[0,0,0], radius=-40, font = "orbitron.dxf", rounded=true,  east=90, h=10, t=0.001);
		rotate([0,-17,180])
		writesphere(text="IFTTT 2016", where=[0,0,0], radius=-40, font = "orbitron.dxf", rounded=true,  east=90, h=10, t=0.001);
	}
	sphere(d = outside_dia-thickness-2);
}
