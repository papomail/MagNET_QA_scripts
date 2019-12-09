macro "SLICE_WIDTH" {

close("*");
////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue");
GEOMETRIC_LINEARITY_TRA = call("ij.Prefs.get", "myMacros.GEOMETRY_TRA", "defaultValue");
GEOMETRIC_LINEARITY_COR = call("ij.Prefs.get", "myMacros.GEOMETRY_COR", "defaultValue");
GEOMETRIC_LINEARITY_SAG = call("ij.Prefs.get", "myMacros.GEOMETRY_SAG", "defaultValue");



// run SIGNAL UNIFORMITY TEST for 3 slice orientations:
SLICE_WIDTH(GEOMETRIC_LINEARITY_TRA,Results_dir);
SLICE_WIDTH(GEOMETRIC_LINEARITY_COR,Results_dir);
SLICE_WIDTH(GEOMETRIC_LINEARITY_SAG,Results_dir);







//////////////////////////
/// Function definition:   SLICE_WIDTH
function SLICE_WIDTH(filename,results_dir) {



outdir=results_dir+File.separator+"SLICE_WIDTH";
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

x_y=FindRods(myimage,results_dir);
roiManager("reset");
run("Clear Results");

x1=x_y[1];
y1=x_y[1+9];

x3=x_y[3];
y3=x_y[3+9];

x4=x_y[4];
y4=x_y[4+9];

x5=x_y[5];
y5=x_y[5+9];

x7=x_y[7];
y7=x_y[7+9];


// centre for Vertical roi
Vxp=round((x3+x4)/2); //1st window
Vyp=round((y3+y4)/2);

Vxp2=round((x4+x5)/2); //2nd window
Vyp2=round((y4+y5)/2);

// centre for Horizontal roi
Hxp=round((x1+x4)/2); //1st window
Hyp=round((y1+y4)/2);

Hxp2=round((x4+x7)/2); //2nd window
Hyp2=round((y4+y7)/2);


// check whether vertical or horizontal is needed
roiManager("reset");


makeRectangle(Vxp-5, Vyp-60, 10, 120);
roiManager("add");
roiManager("select", 0);
roiManager("Rename", "vertical");

makeRectangle(Hxp-60, Hyp-5, 120, 10);
roiManager("add");
roiManager("select", 1);
roiManager("Rename", "horizontal");
selectWindow(myimage);
roiManager("select", 1);


hprofile = getProfile();
//Plot.create("Window profile","Voxel number along X axis","Voxel intensity",hprofile);
  //  Plot.addText(myimage+": Horizontal ROI",0.3,0.1);
   // Plot.show();

selectWindow(myimage);
roiManager("select", 0); //0 for vertical1 , 1 for horizontal1 roi
setKeyDown("alt");
vprofile = getProfile();
setKeyDown("none");
//Plot.create("Window profile","Voxel number along X axis","Voxel intensity",vprofile);
  //  Plot.addText(myimage+": Vertical ROI",0.3,0.1);
    //Plot.show();


hpp=newArray(hprofile.length-1);
vpp=newArray(hprofile.length-1);
for (i = 0; i < hprofile.length-1; i++) {
	hpp[i]=hprofile[i+1]-hprofile[i];// hprofile derivative
	if (i<hprofile.length-2) {
	hpp[i]=hpp[i+1]-hpp[i];// hprofile 2nd derivative
	}
	if (i<hprofile.length-3) {
	hpp[i]=hpp[i+1]-hpp[i];// hprofile 3rd derivative
	}
	hpp[i]=abs(hpp[i]);
	vpp[i]=vprofile[i+1]-vprofile[i];// vprofile derivative
	if (i<hprofile.length-2) {
	vpp[i]=vpp[i+1]-vpp[i];// hprofile 2nd derivative
	}
	if (i<hprofile.length-3) {
	vpp[i]=vpp[i+1]-vpp[i];// hprofile 3rd derivative
	}
	vpp[i]=abs(vpp[i]);
}

hpp=Array.sort(hpp);
vpp=Array.sort(vpp);

hpp=Array.trim(hpp, 100);
vpp=Array.trim(vpp, 100);

 //Plot.create("3rd derivative abs H, peaks removed","Voxel number along X axis","Voxel intensity",hpp);
 //Plot.show();
 //Plot.create("derivative abs V, peaks removed","Voxel number along X axis","Voxel intensity",vpp);
 //Plot.show();

Array.getStatistics(hpp, hmin, hmax, hmean, hstd);
Array.getStatistics(vpp, vmin, vmax, vmean, vstd);

if(hmean>vmean){
    //Plot.create("Window profile","Voxel number along X axis","Voxel intensity",hprofile);
    //Plot.addText(myimage+": Horizontal",0.3,0.1);
    //Plot.show();
    roiManager("select", 0);
	roiManager("delete");

	selectWindow(myimage);

	roiManager("show none");
	makeRectangle(Hxp2-60, Hyp2-5, 120, 10); //add 2nd window roi H
	roiManager("add");
	wait(100);
	roiManager("show all");

	roiManager("select", 1);
	hprofile2 = getProfile();

	  // get both windows profile values (horizontal case)
	  for (i=0; i<hprofile.length; i++){
      setResult("1st window profile", i, hprofile[i]);
      setResult("2nd window profile", i, hprofile2[i]);
      updateResults;
      }



}
else {
	//Plot.create("Window profile","Voxel number along X axis","Voxel intensity",vprofile);
    //Plot.addText(myimage+": Horizontal",0.3,0.1);
    //Plot.show();
    roiManager("select", 1);
	roiManager("delete");
	selectWindow(myimage);
	roiManager("show none");

	makeRectangle(Vxp2-5, Vyp2-60, 10, 120); //add 2nd window roi V
	roiManager("add");
	wait(100);
	roiManager("show all");

	roiManager("select", 1);
	setKeyDown("alt");
	vprofile2 = getProfile();
	setKeyDown("none");

	// get both windows profile values (vertical case)
	  for (i=0; i<vprofile.length; i++){
      setResult("1st window profile", i, vprofile[i]);
       setResult("2nd window profile", i, vprofile2[i]);
       updateResults;
       }

}

//save results
saveAs("Results", outdir+File.separator+myimage+"_SLICE_WIDTH.csv");

//take screenshots
selectWindow(myimage);
setLocation(1,1,1028,1028);
wait(100);
myscreenshot=screenshot_dir+File.separator+myimage+"_SLICE_WIDTH.png";
exec("screencapture", myscreenshot);
setLocation(1,1,300,300);





// Close all result images"
close("*Result*");
}








//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function FindRods(name,results_dir) {
selectWindow(name);
run("Duplicate...", "dup1");
rename("dup1");
run("8-bit");
setAutoThreshold("Minimum dark no-reset");
run("Convert to Mask", "method=Minimum background=Dark calculate");

run("Duplicate...", "title=dup2");
run("Fill Holes", "slice");
wait(100);
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


return xpos_ypos_concat;

}



}


//close("*");
