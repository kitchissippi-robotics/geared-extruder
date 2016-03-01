// *********************************************************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *********************************************************************************************************************
// Filament Extruder for Geared NEMA17 motors
//
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2016 Kitchissippi Robotics
// ---------------------------------------------------------------------------------------------------------------------
// Extruder_Body.scad
// *********************************************************************************************************************

include <Configuration.scad>
include <Dimensions.scad>
include <OpenSCAD-Hardware/HardwareLib.scad>

// Determine if MultiPartMode is enabled - if not, render the part automatically
// and enable support material (if it is defined)

if (undef == MultiPartMode) {
	MultiPartMode = false;
	EnableSupport = true;


	//color("gray")
	Part_Extruder_Body();

	// Move these two modules to other files once completed
	//color("orange")
	%Part_Extruder_Base();

	color("gray")
	translate([0,0, rpBaseThickness])
	Part_Extruder_Idler();

	translate([0,0, rpBaseThickness])
	#Part_Extruder_IdlerOutside();

	Draw_Extruder_Body_Hardware();
} else {
	EnableSupport = false;
}

// ---------------------------------------------------------------------------------------------------------------------
module Part_Extruder_Base() {
	baseCurve = 5;
	baseOffset = 10;
	difference() {
		union() {
			hull() {
				translate([0,0,2])
				cylinder(h = rpBaseThickness -2, d = 37, $fn = gcFacetLarge);

				cylinder(h = rpBaseThickness, d = 36, $fn = gcFacetLarge);

				translate([-36/2 + baseCurve/2 - baseOffset,-36/2 + baseCurve/2,0])
					cylinder(h = rpBaseThickness, d = baseCurve, $fn = gcFacetSmall);

				translate([-36/2 + baseCurve/2 - baseOffset, 36/2 - baseCurve/2,0])
					cylinder(h = rpBaseThickness, d = baseCurve, $fn = gcFacetSmall);
			}
		}

		CarveOutHardware(isBase = true);


		// mounting holes
		translate([-36/2 + baseCurve/2 - baseOffset + 3,-36/2 + baseCurve/2 + 3,-0.1])
					cylinder(h = rpBaseThickness + 0.2, d = HW_Hole(4), $fn = gcFacetSmall);

		translate([-36/2 + baseCurve/2 - baseOffset + 3,36/2 - baseCurve/2 - 3,-0.1])
					cylinder(h = rpBaseThickness + 0.2, d = HW_Hole(4), $fn = gcFacetSmall);
	}
}


// ---------------------------------------------------------------------------------------------------------------------
// Lower part of idler arm
// .....................................................................................................................

module Part_Extruder_IdlerOutside() {
	topEdge = 16;

	difference() {
		union() {

			rotate([0,0,45 + hwPos_MotorRotation])
					translate([hwMountHole_Spacing/ 2, 0, topEdge - 6])
						cylinder(h = 6, d = 10, $fn = gcFacetSmall);

			hull() {
						rotate([0,0,45 + hwPos_MotorRotation])
						translate([hwMountHole_Spacing/ 2, 0, topEdge - 3])
						cylinder(h = 3, d = 10, $fn = gcFacetSmall);

						translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, topEdge - 3])
						cylinder(h = 3, d = hw608HubDiameter, $fn = gcFacetSmall);
					}

			// hub for bearing
			hull() {
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, topEdge - 3.4])
			cylinder(h = 3.4, d = hw608HubDiameter, $fn = gcFacetSmall);

			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, topEdge - 3])
			cylinder(h = 2, d = hw608HubDiameter + 2, $fn = gcFacetSmall);
			}
		}
		translate([0,0,-rpBaseThickness])
			CarveOutHardware(isIdler = true);

		// post for bearing
		translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 0])
			cylinder(h = 30, d = hw608InsideDiameter + 0.5, $fn = gcFacetSmall);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// Lower part of idler arm
// .....................................................................................................................

module Part_Extruder_Idler() {
	difference() {
		union() {
			// bolt post to mount to motor
			rotate([0,0,45 + hwPos_MotorRotation])
			translate([hwMountHole_Spacing/ 2, 0, 0])
				cylinder(h = 10 - 0.25, d = 10, $fn = gcFacetSmall);

			// post for bearing
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 0])
			cylinder(h = 16, d = hw608InsideDiameter - 0.25, $fn = gcFacetSmall);

			// hub for bearing
			hull() {
				translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 0])
				cylinder(h = 5.5, d = hw608HubDiameter, $fn = gcFacetSmall);

				translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 1.5])
				cylinder(h = 2.5, d = hw608HubDiameter + 2, $fn = gcFacetSmall);
			}

			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2 ,-21,0])
			cube([5,10,14]);

			hull() {
				rotate([0,0,45 + hwPos_MotorRotation])
				translate([hwMountHole_Spacing/ 2, 0, 0])
				cylinder(h = 4, d = 10, $fn = gcFacetSmall);

				translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 0])
				cylinder(h = 4, d = hw608HubDiameter, $fn = gcFacetSmall);
			}

			hull() {

				translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 0])
				cylinder(h = 4, d = 8, $fn = gcFacetSmall);

				translate([hwHob_Diameter/2 + hw608OutsideDiameter/2 ,-21,0])
				cube([5,10,4]);
			}
		}

		translate([0,0,-rpBaseThickness])
			CarveOutHardware(isIdler = true);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
// Main block of extruder body
// .....................................................................................................................


module Part_Extruder_Body() {
	idlerOutsideEdge = 13;
	bodyEdge = 26.5;
	bodyWidth = 17.5;

	difference() {
		// draw body
		union() {
				// idler bolt mount
			hull() {
				translate([idlerOutsideEdge, -12, rpBaseThickness + 2])
				cylinder(h = 3, d =3, $fn = gcFacetSmall);
				translate([idlerOutsideEdge, -12, rpBaseThickness])
				cylinder(h = 2, d =1.5, $fn = gcFacetSmall);

				translate([-2, -bodyEdge, rpBaseThickness + 2])
				cylinder(h = 3, d =3, $fn = gcFacetSmall);
				translate([-2, -bodyEdge, rpBaseThickness])
				cylinder(h = 2, d =1.5, $fn = gcFacetSmall);


				translate([idlerOutsideEdge, -bodyEdge, 5])
				cylinder(h = 3, d =3, $fn = gcFacetSmall);
				translate([idlerOutsideEdge, -bodyEdge, 3])
				cylinder(h = 2, d =1.5, $fn = gcFacetSmall);

				// idler bolt mount top
				translate([idlerOutsideEdge, -bodyEdge, bodyWidth])
				sphere(d =3, $fn = gcFacetSmall);

				translate([idlerOutsideEdge, -12, bodyWidth])
				sphere(d =3, $fn = gcFacetSmall);

				translate([-2, -bodyEdge, bodyWidth])
				sphere(d =3, $fn = gcFacetSmall);

				translate([-2, -12, bodyWidth])
				sphere(d =3, $fn = gcFacetSmall);

				// base rear
				rotate([0,0,hwPos_MotorRotation - 45])
				translate([-hwMountHole_Spacing/ 2, 0, 7])
				scale([1,1,0.5])
				sphere(d = 10, $fn = gcFacetSmall);

				rotate([0,0,hwPos_MotorRotation - 45])
				translate([-hwMountHole_Spacing/ 2, 0, rpBaseThickness + 2])
				cylinder(h = 3, d = 11, $fn = gcFacetSmall);

				rotate([0,0,hwPos_MotorRotation - 45])
				translate([-hwMountHole_Spacing/ 2, 0, rpBaseThickness])
				cylinder(h = 2, d = 9.5, $fn = gcFacetSmall);

				// filament path
				translate([6, -7, rpBaseThickness + 2])
				cylinder(h = 3, d =3, $fn = gcFacetSmall);
				translate([6, -7, rpBaseThickness])
				cylinder(h = 2, d =1.5, $fn = gcFacetSmall);

				translate([6, -7, bodyWidth])
				sphere(d =3, $fn = gcFacetSmall);
			}

			// lip around pushfit connector openning

			translate([hwHob_Diameter/2 - 1.75/3,-bodyEdge - 1.5,hwPos_HobOffset + hwHob_Length - hwHob_Inset])
			rotate([90,90,0])
			rotate_extrude(convexity = 10, $fn = gcFacetMedium)
			hull() {
			translate([5.5, 0, 0])
			circle(r = 1, $fn = gcFacetSmall);
			translate([6, 0, 0])
			circle(r = 1, $fn = gcFacetSmall);
			}
		}
	CarveOutHardware();
		// cut out base section
		*translate([-50,-50,- 0.1])
			cube([100, 100, rpBaseThickness + 0.1]);
	}
}

module CarveOutHardware(isIdler = false, isBase = false) {
	union() {
				// carve outs

		// filament shape
		translate([hwHob_Diameter/2 - 1.75/3, 100, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = 200, d = HW_Hole(2), $fn = gcFacetSmall);

		// PTFE Tube hole
		translate([hwHob_Diameter/2 - 1.75/3, 100, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = 200, d = HW_Hole(4), $fn = gcFacetSmall);

		/*translate([hwHob_Diameter/2, -21, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = 1, d1 = HW_Hole(4), d2 = HW_Hole(8), $fn = gcFacetSmall);
		translate([hwHob_Diameter/2, -18.1, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = 3, d1 = HW_Hole(2), d2 = HW_Hole(4), $fn = gcFacetSmall);

		translate([hwHob_Diameter/2, -11.1, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = 3, d1 = HW_Hole(2), d2 = HW_Hole(4), $fn = gcFacetSmall);*/

		// hob
		translate([0,0,-0.1])
		cylinder(h = 40, d = hwHob_Diameter + 2, $fn = gcFacetMedium);

		// motor raised hub
		if (true == isBase) {
			translate([0,0,-0.1])
			cylinder(h = hwGearBox_HubDepth + 1, d = hwGearBox_HubDiameter + 0.5, $fn = gcFacetLarge);
			translate([0,0,hwGearBox_HubDepth + 0.8])
			cylinder(h = 2.3, d1 = hwGearBox_HubDiameter + 0.5, d2 = hwGearBox_HubDiameter -1, $fn = gcFacetLarge);
		}

		// motor mount bolts
		rotate([0,0,45 + hwPos_MotorRotation]){
			translate([hwMountHole_Spacing/ 2, 0, -5])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20, 50);

			translate([-hwMountHole_Spacing/ 2, 0, -4])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20, 50);

			translate([0, hwMountHole_Spacing/ 2, -5])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 10, 50);


		}

		// bolt for idler spring

		translate([36, -16, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([0,-90,0])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 25, 50);

		if (false == isIdler) {
		translate([36, -15, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([5,-90,0])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 25, 1);

		translate([36, -17, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([-5,-90,0])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 25, 1);
		}

		/*if (false == isIdler) {

		// idler bearing
		difference() {
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 7])
				cylinder(h = hw608Thickness + 20, d = hw608OutsideDiameter + 1, $fn = gcFacetMedium);
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 7])
				cylinder(h = hw608Thickness + 20, d = hw608InsideDiameter, $fn = gcFacetMedium);
			}
		} else*/ {


		// idler bearing
		difference() {
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 7.5])
				cylinder(h = hw608Thickness + 2, d = hw608OutsideDiameter + 2, $fn = gcFacetMedium);
			translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, 7])
				cylinder(h = hw608Thickness + 20, d = hw608HubDiameter + 2, $fn = gcFacetMedium);
			}

		}

		// pushfit connector
		translate([hwHob_Diameter/2 - 1.75/3,-hwPos_PushFitOffset,hwPos_HobOffset + hwHob_Length - hwHob_Inset])
		rotate([90,90,0])
		cylinder(h = hwPushFit_ThreadDepth * 2, d = hwPushFit_ThreadDiameter, $fn = gcFacetMedium);

	}



}

// ---------------------------------------------------------------------------------------------------------------------
module Draw_Extruder_Body_Hardware() {

	// geared NEMA17 shape
	rotate([0,180,hwPos_MotorRotation])
	%Vitamin_DrawMotor();

	// motor mount bolts
	rotate([0,0,45 + hwPos_MotorRotation]){
		translate([hwMountHole_Spacing/ 2, 0, -5])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

		translate([-hwMountHole_Spacing/ 2, 0, -4])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

		translate([0, hwMountHole_Spacing/ 2, -5])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 10);
	}

	// bolt for idler spring
	translate([36, -16, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([0,-90,0])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 25);

	/*translate([36, -15, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([5,-90,0])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 25);

	translate([36, -17, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([-5,-90,0])
		Draw_hwBolt(hwM3_Bolt_AllenHead, 25);*/

	// bolt for idler shaft
	*translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, hwPos_HobOffset + hwHob_Length - hwHob_Inset - hw608Thickness/2 + 16])
	rotate([0,180,0])
		Draw_hwBolt(hwM4_Bolt_HexHead, 20);

	// idler bearing
	//color("Silver")
	translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, hwPos_HobOffset + hwHob_Length - hwHob_Inset - hw608Thickness/2])
		%Vitamin_DrawBearing();

	// hobbed pulley
	//color("Gold")
	translate([0,0,hwPos_HobOffset])
	%Vitamin_DrawHob();

	// filament shape
	//color("Blue")
	translate([hwHob_Diameter/2 - 1.75/3, 100, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([90,90,0])
	%cylinder(h = 200, d = 1.75, $fn = gcFacetSmall);

	// pushfit connector shape
	//color("Gold")
	%translate([hwHob_Diameter/2 - 1.75/3,-hwPos_PushFitOffset - 1,hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([90,90,0])
	import("pushfit.stl", convexity=3);
}

// ---------------------------------------------------------------------------------------------------------------------
module Vitamin_DrawHob() {
	cylinder(h = hwHob_Length, d = hwHob_Diameter);
}

// ---------------------------------------------------------------------------------------------------------------------
module Vitamin_DrawBearing() {
	difference() {
		cylinder(h = hw608Thickness, d = hw608OutsideDiameter);
		translate([0,0,-0.1])
		cylinder(h = hw608Thickness + 0.2, d = hw608InsideDiameter);
	}
}

// ---------------------------------------------------------------------------------------------------------------------
module Vitamin_DrawMotor() {

	difference() {
		union() {
			translate([0,0,-hwGearBox_HubDepth])
			cylinder(h = hwGearBox_HubDepth, d = hwGearBox_HubDiameter);

			cylinder(h = hwGearBox_Depth, d = hwGearBox_Diameter);
			translate([-hwMotor_BodyWidth/2, -hwMotor_BodyWidth/2, hwGearBox_Depth])
				cube([hwMotor_BodyWidth, hwMotor_BodyWidth, hwMotor_BodyDepth]);
			translate([0,0,-hwShaft_Length])
				cylinder(h = hwShaft_Length, d = hwShaft_Diameter);
		}


		rotate([0,180,45]){
			translate([hwMountHole_Spacing/ 2, 0, -3])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20);

			translate([-hwMountHole_Spacing/ 2, 0, -3])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20);

			translate([0, hwMountHole_Spacing/ 2, -3])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20);

			translate([0, -hwMountHole_Spacing/ 2, -3])
			Carve_hwBolt(hwM3_Bolt_AllenHead, 20);
		}

	}
}
