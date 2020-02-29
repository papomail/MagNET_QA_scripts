// RUNS MAGNetQA TESTS
close("*")
roiManager("reset");

script_path=getDirectory("current");
home_path=getDirectory("home");

//SNR measurements with the BODY COIL
BODY_SNR_TRA_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_TRA_27";
BODY_SNR_TRA_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_TRA_28";

BODY_SNR_COR_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_COR_31";
BODY_SNR_COR_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_COR_32";

BODY_SNR_SAG_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_SAG_29";
BODY_SNR_SAG_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SNR_SAG_30";



// Slice Position measurements
SLICE_POS=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_SP_TRA_34";


//GEOMETRIC_LINEARITY measurements
 GEOMETRY_TRA=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_GEO_TRA_38";
 GEOMETRY_COR=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_GEO_COR_41";
 GEOMETRY_SAG=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BC_GEO_SAG_43";
 
//SNR measurements with the HEAD COIL
 HEAD_SNR_TRA_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_TRA_2";
 HEAD_SNR_TRA_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_TRA_3";
 
 HEAD_SNR_COR_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_COR_6";
 HEAD_SNR_COR_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_COR_7";
 
 HEAD_SNR_SAG_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_SAG_5";
 HEAD_SNR_SAG_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_SNR_SAG_4";


// SNR Spine with BodyMatrix 
SP12_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM1SP12_SNR_TRA_45"
SP12_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM1SP12_SNR_TRA_46"

SP56_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM1SP56_SNR_TRA_54"
SP56_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM1SP56_SNR_TRA_55"

SP34_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM2SP34_SNR_TRA_48"
SP34_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM2SP34_SNR_TRA_49"

SP67_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM2SP67_SNR_TRA_57"
SP67_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/BM2SP67_SNR_TRA_58"

//GHOSTING measurements
 GHOSTING_1=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_GHO_NA1_13";
 GHOSTING_2=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/DATA/DICOMS/HNC_GHO_NA2_14";


 
// Output folder
 Results_dir=home_path+ "/Desktop/UCH_Podium_2_Avanto/Acceptance_20200224/Scrip_results3";


//Create Results_dir folder
if ( File.isDirectory(Results_dir)==0 ){
print("Creating folder "+ Results_dir);
File.makeDirectory(Results_dir);
}


//store results_dir path
call("ij.Prefs.set", "myMacros.savedir", Results_dir);
//store filename paths
//SNR Head coil
call("ij.Prefs.set", "myMacros.HEAD_SNR_TRA_1", HEAD_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.HEAD_SNR_COR_1", HEAD_SNR_COR_1);
call("ij.Prefs.set", "myMacros.HEAD_SNR_SAG_1", HEAD_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.HEAD_SNR_TRA_2", HEAD_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.HEAD_SNR_COR_2", HEAD_SNR_COR_2);
call("ij.Prefs.set", "myMacros.HEAD_SNR_SAG_2", HEAD_SNR_SAG_2);

//SNR Body coil
call("ij.Prefs.set", "myMacros.BODY_SNR_TRA_1", BODY_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.BODY_SNR_COR_1", BODY_SNR_COR_1);
call("ij.Prefs.set", "myMacros.BODY_SNR_SAG_1", BODY_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.BODY_SNR_TRA_2", BODY_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.BODY_SNR_COR_2", BODY_SNR_COR_2);
call("ij.Prefs.set", "myMacros.BODY_SNR_SAG_2", BODY_SNR_SAG_2);


//SNR SP coil 
SP12_1 = call("ij.Prefs.set", "myMacros.SP12_1", SP12_1);
SP34_1 = call("ij.Prefs.set", "myMacros.SP34_1", SP34_1);
SP56_1 = call("ij.Prefs.set", "myMacros.SP56_1", SP56_1);
SP67_1 = call("ij.Prefs.set", "myMacros.SP67_1", SP67_1);

SP12_2 = call("ij.Prefs.set", "myMacros.SP12_2", SP12_2);
SP34_2 = call("ij.Prefs.set", "myMacros.SP34_2", SP34_2);
SP56_2 = call("ij.Prefs.set", "myMacros.SP56_2", SP56_2);
SP67_2 = call("ij.Prefs.set", "myMacros.SP67_2", SP67_2);

//Geometry
call("ij.Prefs.set", "myMacros.GEOMETRY_TRA", GEOMETRY_TRA);
call("ij.Prefs.set", "myMacros.GEOMETRY_COR", GEOMETRY_COR);
call("ij.Prefs.set", "myMacros.GEOMETRY_SAG", GEOMETRY_SAG);

//Ghosting
call("ij.Prefs.set", "myMacros.GHOSTING_1", GHOSTING_1);
call("ij.Prefs.set", "myMacros.GHOSTING_2", GHOSTING_2);

//Slice Position
call("ij.Prefs.set", "myMacros.SLICE_POS", SLICE_POS);

//this will retrieve stored valeu of myMacros.savedir to myvalue
//myvalue = call("ij.Prefs.get", "myMacros.savedir", "defaultValue");



// RUN SNR:
runMacro(script_path + "SNR.ijm") ;


// RUN SPINE+BMAT SNR:
runMacro(script_path + "SpineBodyMatrix_SNR.ijm") ;

// RUN SIGNAL UNIFORMITY:
 //runMacro(script_path + "SIGNAL_UNIFORMITY.ijm") ;
runMacro(script_path + "SIGNAL_UNIFORMITY_NOPLOTS.ijm") ;

// RUN GEOMETRIC_LINEARITY:
runMacro(script_path + "GEOMETRIC_LINEARITY.ijm");


// RUN SLICE WIDTH:
runMacro(script_path + "SLICE_WIDTH.ijm");


// RUN GHOSTING:
runMacro(script_path + "GHOSTING.ijm");


// RUN SLICE_POS:
// NOT READY!!! 
runMacro(script_path + "SLICE_POSITION2.ijm");



// close("*");

print("");
print("");
print("");
print("Done! Closing FIJI now... ");
//run("Quit");
