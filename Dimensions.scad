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
// Dimensions.scad
// Does not generate any parts, used for design dimensions
// *********************************************************************************************************************

hwMountHole_Spacing = 28;

hwGearBox_Diameter = 36;
hwGearBox_Depth = 23;
hwGearBox_HubDiameter = 21.5;
hwGearBox_HubDepth = 2;

hwShaft_Diameter = 8;
hwShaft_Length = 21;

hwMotor_BodyWidth = 42;
hwMotor_BodyDepth = 44;

hw608Thickness = 7;
hw608OutsideDiameter = 21.8;
hw608InsideDiameter = 8;
hw608HubDiameter = 12;

hwHob_Diameter = 13;
hwHob_Length = 13;
hwHob_Inset = 4;

hwPushFit_ThreadDiameter = 9.2;
hwPushFit_ThreadDepth = 5.5;

hwPos_HobOffset = hwGearBox_HubDepth + 1;
hwPos_MotorRotation = 55;
hwPos_PushFitOffset = hwGearBox_Diameter/2 - 5;
