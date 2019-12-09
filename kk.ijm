// RUNS MAGNetQA TESTS
close("*")
roiManager("reset");

script_path=getDirectory("current");

print(script_path)
//SNR measurements with the BODY COIL
BODY_SNR_TRA_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/2";
BODY_SNR_TRA_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/3";

BODY_SNR_COR_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/4";
BODY_SNR_COR_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/5";

BODY_SNR_SAG_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/6";
BODY_SNR_SAG_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/7";



// Slice Position measurements
SLICE_POS="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/9";


//GEOMETRIC_LINEARITY measurements
 GEOMETRY_TRA="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/10";
 GEOMETRY_COR="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/12";
 GEOMETRY_SAG="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/15";
 
//SNR measurements with the HEAD COIL
 HEAD_SNR_TRA_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/22";
 HEAD_SNR_TRA_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/23";
 
 HEAD_SNR_COR_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/24";
 HEAD_SNR_COR_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/25";
 
 HEAD_SNR_SAG_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/26";
 HEAD_SNR_SAG_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/27";




//GHOSTING measurements
 GHOSTING_1="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/31";
 GHOSTING_2="/Users/papo/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/33";


 
// Output folder
 Results_dir="/Users/papo/Desktop/QAResults_PORTLAND2019";


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
// runMacro("/Users/papo/MagNET_QA_scripts/SNR.ijm") ;

// RUN SIGNAL UNIFORMITY:
 runMacro(script_path+"/SIGNAL_UNIFORMITY.ijm") ;