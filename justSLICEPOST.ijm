// RUNS MAGNetQA TESTS
close("*")
roiManager("reset");

script_path=getDirectory("current");
home_path=getDirectory("home");

//SNR measurements with the BODY COIL
BODY_SNR_TRA_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/2";
BODY_SNR_TRA_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/3";

BODY_SNR_COR_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/4";
BODY_SNR_COR_2=home_path+ "/Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/5";

BODY_SNR_SAG_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/6";
BODY_SNR_SAG_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/7";



// Slice Position measurements
SLICE_POS=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/9";


//GEOMETRIC_LINEARITY measurements
 GEOMETRY_TRA=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/10";
 GEOMETRY_COR=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/12";
 GEOMETRY_SAG=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/15";
 
//SNR measurements with the HEAD COIL
 HEAD_SNR_TRA_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/22";
 HEAD_SNR_TRA_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/23";
 
 HEAD_SNR_COR_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/24";
 HEAD_SNR_COR_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/25";
 
 HEAD_SNR_SAG_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/26";
 HEAD_SNR_SAG_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/27";




//GHOSTING measurements
 GHOSTING_1=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/31";
 GHOSTING_2=home_path+ "Sync/QA_PORTLAND/Portland_2019/DATA/HOROS/1/33";


 
// Output folder
 Results_dir=home_path+ "Desktop/QAResults_PORTLAND2019";


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
//runMacro(script_path + "SNR.ijm") ;

// RUN SIGNAL UNIFORMITY:
 //runMacro(script_path + "SIGNAL_UNIFORMITY.ijm") ;
//runMacro(script_path + "SIGNAL_UNIFORMITY_NOPLOTS.ijm") ;

// RUN GEOMETRIC_LINEARITY:
//runMacro(script_path + "GEOMETRIC_LINEARITY.ijm");


// RUN SLICE WIDTH:
//runMacro(script_path + "SLICE_WIDTH.ijm");


// RUN GHOSTING:
//runMacro(script_path + "GHOSTING.ijm");


// RUN SLICE_POS:
// NOT READY!!! 
mySLICE_POSITION()



// close("*");

print("");
print("");
print("");
print("Done! Closing FIJI now... ");
//run("Quit");

close("*")
 


function mySLICE_POSITION() {

////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path 
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 
SLICE_POS = call("ij.Prefs.get", "myMacros.SLICE_POS", "defaultValue"); 



// run SIGNAL UNIFORMITY TEST for 3 slice orientations:
SLICE_POSITION_TEST(SLICE_POS,Results_dir);







//////////////////////////
/// Function definition:   
function SLICE_POSITION_TEST(filename,results_dir) {



outdir=results_dir+File.separator+"SLICE_POSITION";
screenshot_dir=outdir+File.separator+"ScreenshotCheck";
//Create uniformity folder
if ( File.isDirectory(outdir)==0 ){
print("Creating folder "+ outdir);
File.makeDirectory(outdir);
}
//Create screenshot_dir folder
if ( File.isDirectory(screenshot_dir)==0 ){
print("Creating folder "+ screenshot_dir);
File.makeDirectory(screenshot_dir);
}

open(filename);
myimage=getTitle();
selectWindow(myimage);

FindRods(myimage,results_dir);
run("Clear Results");
for (i = 0; i < 6; i++) {
	roiManager("select", i);
	//waitForUser( "Pause","Put line through the centre of the rods. \n Press OK when finished");
	roiManager("Update");
	run("Set Measurements...", "shape stack display redirect=None decimal=3");
	roiManager("measure");
	};
	
saveAs("Results", outdir+File.separator+myimage+"_SLICE_POS.csv");


// Close all result images"
close("*Result*");
}

//////////////////////////
/// Function definition:   
function FindRods(name,results_dir) {
selectWindow(name);	


run("Duplicate...", "duplicate");
rename("dup1");
run("Make Binary", "method=Minimum background=Dark calculate black");

run("Duplicate...", "duplicate");
rename("dup2");
run("Fill Holes", "stack");


	run("Calculator Plus", "i1=dup2 i2=dup1 operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
	close("dup*");
	selectWindow("Result");


//find edge rods
run("Duplicate...", "duplicate");
run("Z Project...", "projection=Median");
rename("Flat");

  
// particles	
selectWindow("Flat");	
run("Set Measurements...", "centroid shape stack display redirect=None decimal=2");
run("Analyze Particles...", "size=1-20 circularity=0.50-1.00 exclude clear");

xpos=newArray(4);
ypos=newArray(4);
posind=newArray(4);
for (i = 0; i < 4; i++) {
	xp=getResult("X", i);
	yp=getResult("Y", i);
	xpos[i]=xp;
	ypos[i]=yp;

	posind[i]=yp*10+xp;
}

sort_index=Array.rankPositions(posind);


Array.print(xpos);
Array.print(ypos);
Array.print(posind);
Array.print(sort_index);

xpos2=newArray(4);
ypos2=newArray(4);
for (i = 0; i < 4; i++) {
	xpos2[i]=xpos[sort_index[i]];
	ypos2[i]=ypos[sort_index[i]];
}
xpos=xpos2;
ypos=ypos2;
xpos_ypos_concat=Array.concat(xpos,ypos);


// rectangle
selectWindow("Result");
roiManager("reset")

makePolygon(xpos[0]-5, ypos[0]-5, xpos[1]+5, ypos[1]-5,xpos[3]+5, ypos[3]+5, xpos[2]-5, ypos[2]+5);
roiManager("add");
roiManager("Select", 0);
run("Make Inverse");
run("Clear", "stack");
roiManager("Show All");


// create copies for centre and edge rods
run("Duplicate...", "duplicate");
rename("centreRods");
run("Duplicate...", "duplicate");
rename("edgeRods");

roiManager("reset")
makeOval(xpos[0]-15, ypos[0]-15, 30, 30);
roiManager("add");
makeOval(xpos[1]-15, ypos[1]-15, 30, 30);
roiManager("add");
makeOval(xpos[2]-15, ypos[2]-15, 30, 30);
roiManager("add");
makeOval(xpos[3]-15, ypos[3]-15, 30, 30);
roiManager("add");
roiManager("Select", newArray(0,1,2,3));
roiManager("Combine");
roiManager("Add");

run("Clear Outside", "stack");
//roiManager("Show All with labels");

selectWindow("centreRods");
roiManager("Select", 4);
run("Clear", "stack");
////






return xpos_ypos_concat;
////

}



}
}