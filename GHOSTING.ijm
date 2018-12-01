
macro "GHOSTING" {

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
//GHOSTING_TEST(GHOSTING_2,Results_dir);




//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
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

open(filename);
myimage=getTitle();
open(filename2);
myimage2=getTitle();

selectWindow(myimage);  // Find centre from the NSA=1 image

centre_pos=find_bottle_centre();
print("Phantom centre at x,y ="); 
Array.print(centre_pos); //show central point (x,y) of the phantom

//create rois for noise measure
off_pos=newArray(centre_pos[0]+105,centre_pos[1]-105);
//off_pos=newArray(140+40,33+65);
roiManager("reset");
makeRectangle(off_pos[0]-40, off_pos[1]-65, 20, 20);
roiManager("add");
makeRectangle(off_pos[0]+40, off_pos[1]-65, 20, 20);
roiManager("add");
makeRectangle(off_pos[0]-40, off_pos[1]+65, 20, 20);
roiManager("add");
makeRectangle(off_pos[0]+40, off_pos[1]+65, 20, 20);
roiManager("add");
roiManager("select", newArray(0, 1, 2, 3));
roiManager("combine");
roiManager("add");
roiManager("select", newArray(0, 1, 2, 3));
roiManager("delete");
roiManager("select", 0);
roiManager("rename", "Noise");

//create roi for signal measure
makeRectangle(centre_pos[0]-10, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 1);
roiManager("rename", "Signal");


//mask the bottle

//create roi of max ghosting 
makeRectangle(centre_pos[0]-10 -20, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 2);
roiManager("rename", "G1");

makeRectangle(centre_pos[0]-10 +20, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 3);
roiManager("rename", "G2");

makeRectangle(centre_pos[0]-10 +40, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 4);
roiManager("rename", "G3");

makeRectangle(centre_pos[0]-10 +60, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 5);
roiManager("rename", "G4");

makeRectangle(centre_pos[0]-10 +80, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 6);
roiManager("rename", "G5");

makeRectangle(centre_pos[0]-10 +100, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 7);
roiManager("rename", "G6");



//roiManager("measure");
}


//////////////////////////
/// Function definition:  find_phantom_centre

function find_bottle_centre(){
//Finds x,y position in the centre of the phantom
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
centre_pos=newArray(myx,myy,myw,myh);
close();
return centre_pos;
	};//end of function


}