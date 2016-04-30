//
//  Constants.h
//  StandUI
//
//  Created by ganapathy.ln on 07/08/14.
//  Copyright (c) 2014 Philips. All rights reserved.
//

#ifndef StandUI_Constants_h
#define StandUI_Constants_h

#define FLUOROSCOPYSETTINGS 0
#define EXPOSURESETTINGS    1
#define MODE                2
#define DOSE                3
#define PULSES              4
#define STORE               5
#define EXPMODE             6
#define EXPPULSES           7


// fluoro Settings group
//Mode Constants
#define FLUORO  @"Fluoroscopy"
#define ROADMAP @"Roadmap"
/*#define CO2     @"co2"
#define CO21    @"co21"
#define CO22    @"co22"
#define CO23    @"co23"
#define CO24    @"co24"
*/
// Dose constants
#define LOW         @"Low"
#define NORMAL      @"Normal"
#define INCREASED   @"Increased"
#define HIGHLEVEL   @"High level"

// Pulses constants
#define TWOPERSEC       @"2/s"
#define FOURPERSEC       @"4/s"
#define EIGHTPERSEC      @"8/s"
#define FIFTEENPERSEC     @"15/s"

#define ONEPERSEC       @"1/s"
#define FIVEPERSEC      @"5/s"
#define NINEPERSEC     @"9/s"

//Storage constants
#define LIH         @"LIH"
#define NOSTORAGE   @"No Storage"
#define STOREALL    @"Store all"
#define HYPHEN      @"-"

// Exposure settings group
// Mode constants
#define SINGLEEXPOSURE  @"Single Shot"
#define EXPOSURERUN     @"Run"
#define SUBTRACT        @"Subtract"
#define TRACE           @"Trace"

// Storage Constants
#define EXPLIH         @"LIH"
#define EXPSTOREALL    @"Store all"


// Procedure Type
#define     SKELETON    @"Skeleton"
#define     UROLOGY     @"Urology"
#define     ENDOSCOPY   @"Endoscopy"
#define     VASCULAR    @"Vascular"
#define     PAIN        @"Pain"
#define     CARDIO      @"Cardio"

// Skeleton Anatomy Type
#define SKULL           @"SkeletonSkull.png"
#define THORAX          @"SkeletonThorax.png"
#define PELVIS          @"SkeletonPelvis.png"
#define SPINE           @"SkeletonSpine.png"
#define SKELETONARMS    @"SkeletonArms.png"
//#define SKELETONLEGS    @"SkeletonLegs.png"


// Skeleton Procedures
#define SKELETONPROCEDURESKULL      @"ProcedureSkeletonSkull.png"
#define SKELETONPROCEDURETHORAX     @"ProcedureSkeletonThorax.png"
#define SKELETONPROCEDUREPELVIS     @"ProcedureSkeletonPelvis.png"
#define SKELETONPROCEDURESPINE      @"ProcedureSkeletonSpine.png"
#define SKELETONPROCEDUREARMS       @"ProcedureSkeletonArm.png"
#define SKELETONPROCEDURELEGS       @"ProcedureSkeletonLeg.png"


#define ANATOMYSKULL    @"Skull"
#define ANATOMYTHORAX   @"Thorax"
#define ANATOMYPELVIS   @"Pelvis"
#define ANATOMYSPINE    @"Spine"
#define ANATOMYSKELETONARMS     @"Arms"
#define ANATOMYSKELETONLEGS     @"Leg"


// Vascular Anatomy Type
#define CEREBRAL        @"VascularCerebral.png"
#define ABDOMINAL       @"VascularAbdominal.png"
#define AROTA           @"VascularAorta.png"
#define VASCULARARMS    @"VascularArms.png"
#define VASCULARLEGS    @"VascularLegs.png"

// Vascular Procedures
#define VASCULARPROCEDUREABDOMINAL   @"ProcedureVascularAbdominal.png"
#define VASCULARPROCEDUREARMS        @"ProcedureVascularArm.png"
#define VASCULARPROCEDURECEREBRAL    @"ProcedureVascularCerebral.png"
#define VASCULARPROCEDURELEGS        @"ProcedureVascularLeg.png"
#define VASCULARPROCEDUREAORTA       @"ProcedureVascularAorta Arc.png"

#define ANATOMYCEREBRAL        @"Cerebral"
#define ANATOMYABDOMINAL       @"Abdominal"
#define ANATOMYAROTA           @"Aorta"
#define ANATOMYVASCULARARMS    @"Arms"
#define ANATOMYVASCULARLEGS    @"Leg"

// Examination Type view selected
#define     SKELETONVIEW    1
#define     UROLOGYVIEW     2
#define     ENDOSCOPYVIEW   3
#define     VASCULARVIEW    4
#define     PAINVIEW        5
#define     CARDIOVIEW      6


#define SKELETON_LEG_1_CLINICAL     @"Skeleton_Leg_1_1K.png"
#define SKELETON_LEG_2_CLINICAL     @"Skeleton_Leg_2_1K.png"
#define VASC_ABDOMINAL_1_CLINICAL   @"Vasc_Abdominal_1_1K.png"
#define VASC_ABDOMINAL_2_CLINICAL   @"Vasc_Abdominal_2_1K.png"
#define CARDIO_PACEMAKER_1_CLINICAL       @"Cardio_Pacemaker_1_1K"

// KVManual
#define KVMANUALMAX     120
#define KVMANUALMIN     40


#define CONTRASTSLIDElINEMIN    0
#define CONTRASTSLIDELINEMAX    200
#define CONTRASTSLIDEMIN        25
#define CONTRASTSLIDEMAX        175


// Current System Mode

#define NOIMAGE         01
#define LIVE            02
#define LIHMODE         03 // Xray off is alos called as LIH mode
#define IMAGEREVIEW     04

#endif
