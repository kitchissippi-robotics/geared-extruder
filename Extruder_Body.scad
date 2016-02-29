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


	Part_Extruder_Body();
	Draw_Extruder_Body_Hardware();
} else {
	EnableSupport = false;
}

module Part_Extruder_Body() {
}

module Draw_Extruder_Body_Hardware() {
	rotate([0,180,hwPos_MotorRotation])
	%Vitamin_DrawMotor();

	rotate([0,0,45 + hwPos_MotorRotation]){
	translate([hwMountHole_Spacing/ 2, 0, -3])
	Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

	translate([-hwMountHole_Spacing/ 2, 0, -3])
	Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

	translate([0, hwMountHole_Spacing/ 2, -3])
	Draw_hwBolt(hwM3_Bolt_AllenHead, 20);

	*translate([0, -hwMountHole_Spacing/ 2, -3])
	Draw_hwBolt(hwM3_Bolt_AllenHead, 20);
	}



	translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, hwPos_HobOffset + hwHob_Length - hwHob_Inset - hw608Thickness/2 + 16])
	rotate([0,180,0])
		Draw_hwBolt(hwM4_Bolt_HexHead, 20);

	translate([hwHob_Diameter/2 + hw608OutsideDiameter/2, 0, hwPos_HobOffset + hwHob_Length - hwHob_Inset - hw608Thickness/2])
		%Vitamin_DrawBearing();

	translate([0,0,hwPos_HobOffset])
	%Vitamin_DrawHob();

	// filament
	translate([hwHob_Diameter/2, 100, hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([90,90,0])
	%cylinder(h = 200, d = 1.75);


	color("Gold")
	%translate([hwHob_Diameter/2,hwPos_PushFitOffset,hwPos_HobOffset + hwHob_Length - hwHob_Inset])
	rotate([-90,90,0])
	import("pushfit.stl", convexity=3);
}

module Vitamin_DrawHob() {
	cylinder(h = hwHob_Length, d = hwHob_Diameter);
}

module Vitamin_DrawBearing() {
	difference() {
		cylinder(h = hw608Thickness, d = hw608OutsideDiameter);
		translate([0,0,-0.1])
		cylinder(h = hw608Thickness + 0.2, d = hw608InsideDiameter);
	}
}

module Vitamin_DrawMotor() {
	translate([0,0,-hwGearBox_HubDepth])
	cylinder(h = hwGearBox_HubDepth, d = hwGearBox_HubDiameter);

	cylinder(h = hwGearBox_Depth, d = hwGearBox_Diameter);
	translate([-hwMotor_BodyWidth/2, -hwMotor_BodyWidth/2, hwGearBox_Depth])
		cube([hwMotor_BodyWidth, hwMotor_BodyWidth, hwMotor_BodyDepth]);
	translate([0,0,-hwShaft_Length])
		cylinder(h = hwShaft_Length, d = hwShaft_Diameter);
}
