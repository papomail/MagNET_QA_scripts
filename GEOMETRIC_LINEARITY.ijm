

macro "GEOMETRIC_LINEARITY" {

////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path 
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 
GEOMETRY_TRA = call("ij.Prefs.get", "myMacros.GEOMETRY_TRA", "defaultValue"); 
GEOMETRY_COR = call("ij.Prefs.get", "myMacros.GEOMETRY_COR", "defaultValue"); 
GEOMETRY_SAG = call("ij.Prefs.get", "myMacros.GEOMETRY_SAG", "defaultValue"); 



// run SIGNAL UNIFORMITY TEST for 3 slice orientations:
GEOMETRIC_LINEARITY_TEST(GEOMETRY_TRA,Results_dir);
GEOMETRIC_LINEARITY_TEST(GEOMETRY_COR,Results_dir);
GEOMETRIC_LINEARITY_TEST(GEOMETRY_SAG,Results_dir);







//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function GEOMETRIC_LINEARITY_TEST(filename,results_dir) {



outdir=results_dir+File.separator+"LINEARITY";
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
	
saveAs("Results", outdir+File.separator+myimage+"_GEOMETRIC_LIN.csv");


// Close all result images"
close("*Result*");
}

//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function FindRods(name,results_dir) {
selectWindow(name);	
run("Duplicate...", "title=dup1");
rename("dup1");
run("8-bit");
setAutoThreshold("Minimum dark no-reset");
run("Convert to Mask", "method=Minimum background=Dark calculate");

run("Duplicate...", "title=dup2");
run("Fill Holes", "slice");

	run("Calculator Plus", "i1=dup2 i2=dup1 operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=0 create");
	close("dup*");
	selectWindow("Result");
  
//particles	
run("Set Measurements...", "area mean centroid shape stack display redirect=None decimal=3");
run("Analyze Particles...", "size=9-200 exclude clear");

	
xpos=newArray(9);
ypos=newArray(9);
posind=newArray(9);
for (i = 0; i < 9; i++) {
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

xpos2=newArray(9);
ypos2=newArray(9);
for (i = 0; i < 9; i++) {
	xpos2[i]=xpos[sort_index[i]];
	ypos2[i]=ypos[sort_index[i]];
}
xpos=xpos2;
ypos=ypos2;
xpos_ypos_concat=Array.concat(xpos,ypos);

selectWindow(name); 
// Horizontal lines
roiManager("reset")

makeLine(xpos[0], ypos[0], xpos[2], ypos[2]);
roiManager("add");
makeLine(xpos[3], ypos[3], xpos[5], ypos[5]);
roiManager("add");
makeLine(xpos[6], ypos[6], xpos[8], ypos[8]);
roiManager("add");

// Vertical lines
makeLine(xpos[0], ypos[0], xpos[6], ypos[6]);
roiManager("add");
makeLine(xpos[1], ypos[1], xpos[7], ypos[7]);
roiManager("add");
makeLine(xpos[2], ypos[2], xpos[8], ypos[8]);
roiManager("add");

roiManager("Show All");

setLocation(1,1,1028,1028);
wait(100);
myscreenshot=screenshot_dir+File.separator+myimage+".png";
exec("screencapture", myscreenshot);
setLocation(1,1,300,300);

return xpos_ypos_concat;

}



}


