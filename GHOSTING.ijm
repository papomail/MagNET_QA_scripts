
macro "GHOSTING" {

TestName="GHOSTING";

close("*");
////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path 
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 
GHOSTING_1 = call("ij.Prefs.get", "myMacros.GHOSTING_1", "defaultValue"); 
GHOSTING_2 = call("ij.Prefs.get", "myMacros.GHOSTING_2", "defaultValue"); 


//Ghoting_ROIs=

// run GHOSTING TEST:
GHOSTING_TEST(GHOSTING_1,GHOSTING_2,Results_dir);





//////////////////////////
/// Function definition:   GHOSTING_TEST
// Runs the main GHOSTING_TEST and produces the results in csv file and the screenshots to check ROI selection. 
function GHOSTING_TEST(filename,filename2,results_dir) {



outdir=results_dir+File.separator+"GHOSTING";
screenshot_dir=outdir+File.separator+"ScreenshotCheck";
//Create GHOSTING folder
if ( File.isDirectory(outdir)==0 ){
print("Creating folder "+ outdir);
File.makeDirectory(outdir);
}
//Create screenshot_dir folder
if ( File.isDirectory(screenshot_dir)==0 ){
print("Creating folder "+ screenshot_dir);
File.makeDirectory(screenshot_dir);
}

//open both images
open(filename);
myimage=getTitle();

open(filename2);
myimage2=getTitle();

// Find centre from the NSA=1 image
selectWindow(myimage);  
bottle_pos=find_bottle();
print("Phantom centre at x,y ="); 
Array.print(bottle_pos); //show central point (x,y) of the phantom

//draw ROIs and do the maths for Ghosting measure:  Ghosting = 100*abs(Maximum Ghost–Noise)/Signal
Ghosting_NSA1=ROIs_Draw_Cal(myimage,bottle_pos);
Ghosting_NSA2=ROIs_Draw_Cal(myimage2,bottle_pos);


//take screenshots
TakeScreenshot(myimage,screenshot_dir,TestName);
TakeScreenshot(myimage2,screenshot_dir,TestName);


//saves the ghosting measure to a results table
run("Clear Results");
for (i = 0; i < Ghosting_NSA1.length; i++) {
setResult("Ghosting_NSA1", i, Ghosting_NSA1[i]);
setResult("Ghosting_NSA2", i, Ghosting_NSA2[i]);
updateResults();
}

//saves the results to a .csv file 
saveAs("Results", outdir+File.separator+myimage+"_"+TestName+".csv");


Array.print(Ghosting_NSA1);
Array.print(Ghosting_NSA2);



}








//////////////////////////
/// Function definition:  TakeScreenshot
function TakeScreenshot(myimage,screenshot_dir,TestName) {
selectWindow(myimage);
setLocation(1,1,1028,1028);
wait(100);
myscreenshot=screenshot_dir+File.separator+myimage+"_"+TestName+".png";
exec("screencapture", myscreenshot);
setLocation(1,1,300,300);
}




/// Function definition:  CreateROIs
function ROIs_Draw_Cal(myimage,bottle_pos) {
//Creates ROIs needed for GHOSTING_TEST and calculates the Ghosting measure from them. Ghosting = 100*abs(Maximum Ghost–Noise)/Signal

selectWindow(myimage);  

//bottle position and dimension
xx=bottle_pos[0];
yy=bottle_pos[1];
ww=bottle_pos[2];
hh=bottle_pos[3];

//create rois for noise measure
nxx=xx+105;
nyy=yy-105;

//off_pos=newArray(140+40,33+65);
roiManager("reset");
makeRectangle(nxx-40, nyy-65, 20, 20);
roiManager("add");
makeRectangle(nxx+40, nyy-65, 20, 20);
roiManager("add");
makeRectangle(nxx-40, nyy+65, 20, 20);
roiManager("add");
makeRectangle(nxx+40, nyy+65, 20, 20);
roiManager("add");
roiManager("select", newArray(0, 1, 2, 3));
roiManager("combine");
roiManager("add");
roiManager("select", newArray(0, 1, 2, 3));
roiManager("delete");
roiManager("select", 0);
roiManager("rename", "Noise");

//create roi for signal measure
makeRectangle(xx-10, yy-10, 20, 20);
roiManager("add");
roiManager("select", 1);
roiManager("rename", "Signal");


// Calculate Noise and Signal values
roiManager("select", newArray(0,1));
run("Set Measurements...", "  mean redirect=None decimal=2");
run("Clear Results");


Stack.getDimensions(width, height, channels, slices, frames);

Signal=newArray(slices);
Noise=newArray(slices);


roiManager("multi measure")
for (i = 0; i < slices; i++) {
Signal[i]=getResult("Mean(Signal)", i);
Noise[i]=getResult("Mean(Noise)", i);
}

print("Mean Signal values for the 4 echoes are:");
Array.print(Signal);
print("Mean Noise values for the 4 echoes are:");
Array.print(Noise);


//create roi of max ghosting 
rc=newArray(-2,-1,1,2,3,4,5,6,7,8);

for (i = 0; i < lengthOf(rc); i++) {
	makeRectangle(xx+rc[i]/abs(rc[i])*ww/2-10+20*rc[i],yy-10, 20, 20);
roiManager("add");
roiname="G"+i;
roiManager("select", i+2);
roiManager("rename", roiname);
}



// create all posible ghosting rois
for (i = 0; i < lengthOf(rc); i++) {
	makeRectangle(xx-10,yy-rc[i]/abs(rc[i])*hh/2-10-20*rc[i], 20, 20);
roiManager("add");
roiname="G"+i+lengthOf(rc);
roiManager("select", i+2+lengthOf(rc));
roiManager("rename", roiname);
}

L=2*lengthOf(rc);
kk=Array.getSequence(L);
for (i = 0; i < L; i++) {
kk[i]=kk[i]+2;
}

roiManager("select", kk);
roiManager("show all");

//select the roi with max ghosting (from the first echo)
run("Set Measurements...", "  mean redirect=None decimal=2");
run("Clear Results");
roiManager("measure");

ghosts=newArray(L);
for (i = 0; i < L; i++) {
	ghosts[i]=getResult("Mean", i);
}

print("Ghosts:");
Array.print(ghosts);
sortGhosts=Array.rankPositions(ghosts);
print("Sorted ghosts rank:");
Array.print(sortGhosts);

roiManager("deselect");
roiManager("deselect");

roiManager("select", 2+sortGhosts[sortGhosts.length-1]); //Select the ROI with max ghosting. (first two rois correspond to Noise and Signal)
roiManager("add");

roiManager("select", roiManager("count")-1);
roiManager("rename", "MaxGhost");

//Delete the ghost ROIs that aren't the maximum
roiManager("select", kk); 
roiManager("delete");

//get maxghost values
MaxGhost=newArray(slices);
roiManager("select", roiManager("count")-1);
roiManager("multi measure");
for (i = 0; i < slices; i++) {
MaxGhost[i]=getResult("Mean(MaxGhost)", i);

}

roiManager("show all with labels")")

//Calculate the ghosting measure
Ghosting_measure=newArray(slices);
for (i = 0; i < slices; i++) {
Ghosting_measure[i]=100*abs(MaxGhost[i]-Noise[i])/Signal[i];

}
return Ghosting_measure;



}




/////////////////////////////////////
/// Function definition:  find_phantom_centre

function find_bottle(){
//Finds centre position x,y the width and height of the bottle. [x y w h]
name = "edge image";
run("Duplicate...", "title=&name");
run("Find Edges");

makeRectangle(0, 0, getWidth(), getHeight());

//check x direction
Xprofile = getProfile();
xpos=Array.rankPositions(Xprofile);
//midx=(lengthOf(xpos)-1)/2;
//edge_uncertainty=10;
min_object_size=30;
max_object_size=40;
Nevents=5;

setOption("ExpandableArrays", true);
xs=newArray(1);
ys=newArray(1);
widths=xs;
heigths=ys;

events=0;
for (i=0;i<20;i++) {
xcent=(xpos[lengthOf(xpos)-1]+xpos[lengthOf(xpos)-2-i])/2;
dx=abs(xpos[lengthOf(xpos)-1]-xpos[lengthOf(xpos)-2-i]);


if ( (dx  >  min_object_size) &&  (dx  <  max_object_size) ){
 xs[events]=xcent;
 widths[events]=dx;
 events++;
 print("events= "+events);
 if (events>Nevents){
 	break;}
 }
}

Array.getStatistics(xs, minx, maxx, meanx, stdDev);
Array.getStatistics(widths, minw, maxw, meanw, stdDev);

Array.print(widths);
print("Bottle centre x="+meanx + " and its width is "+maxw);


//check y direction
selectWindow("edge image");
setKeyDown("alt");
Yprofile = getProfile();
setKeyDown("none");
ypos=Array.rankPositions(Yprofile);
//midy=(lengthOf(xpos)-1)/2;
events=0;
for (i=0;i<50;i++) {
ycent=( ypos[lengthOf(ypos)-1] + ypos[lengthOf(ypos)-2-i]  )/2;
dy=abs( ypos[lengthOf(ypos)-1] - ypos[lengthOf(ypos)-2-i]  );

if ( (dy  >  min_object_size) &&  (dy  <  max_object_size) ){
 ys[events]=ycent;
 heigths[events]=dy;
 events++;
 if (events>Nevents){
 	break;}
 }
}


Array.getStatistics(ys, miny, maxy, meany, stdDev);
Array.getStatistics(heigths, minh, maxh, meanh, stdDev);

Array.print(heigths);
print("Bottle centre y="+meany + " and its height is "+maxh);


myx=round(maxx);
myy=round(maxy);
myw=round(maxw);
myh=round(maxh);
position=newArray(myx,myy,myw,myh);
close();
return position;
	};//end of function


}