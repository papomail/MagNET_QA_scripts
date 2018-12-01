
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
GHOSTING_TEST(GHOSTING_1,Results_dir);
GHOSTING_TEST(GHOSTING_2,Results_dir);




//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function GHOSTING_TEST(filename,results_dir) {



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

//create rois for signal measure
makeRectangle(centre_pos[0]-10, centre_pos[1]-10, 20, 20);
roiManager("add");
roiManager("select", 1);
roiManager("rename", "Signal");
roiManager("measure");
}


//////////////////////////
/// Function definition:  find_phantom_centre

function find_bottle_centre(){
//Finds x,y position in the centre of the phantom
name = "edge image";
run("Duplicate...", "title=&name");
run("Find Edges");

makeRectangle(0, 0, getWidth(), getHeight());
Xprofile = getProfile();
xpos=Array.rankPositions(Xprofile);
//midx=(lengthOf(xpos)-1)/2;
edge_uncertainty=10;
xs=newArray(5);
ys=newArray(5);
events=0;
for (i=0;i<30;i++) {
xcent=(xpos[lengthOf(xpos)-1]+xpos[lengthOf(xpos)-2-i])/2;
dx=abs(xpos[lengthOf(xpos)-1]-xpos[lengthOf(xpos)-2-i]);
toprint=newArray("dx=",dx);
Array.print(toprint);


if ( dx  >  edge_uncertainty ){
 xs[events]=xcent;
 events++;
 print("events= "+events);
 if (events>xs.length-1){
 	break;}
 }
}

Array.getStatistics(xs, min, max, xcent_mean, stdDev);
toprint=newArray("this is the mean x point",xcent_mean);
Array.print(toprint);


selectWindow("edge image");
//run("Rotate 90 Degrees Left");
//makeRectangle(0, 0, 250, 250);
setKeyDown("alt");
Yprofile = getProfile();
setKeyDown("none");
ypos=Array.rankPositions(Yprofile);
midy=(lengthOf(xpos)-1)/2;
events=0;
for (i=0;i<30;i++) {
ycent=( ypos[lengthOf(ypos)-1] + ypos[lengthOf(ypos)-2-i]  )/2;
dy=abs( ypos[lengthOf(ypos)-1] - ypos[lengthOf(ypos)-2-i]  );

if ( dy  >  edge_uncertainty ){
 ys[events]=ycent;
 events++;
 if (events>xs.length-1){
 	break;}
 }
}


Array.getStatistics(ys, min, max, ycent_mean, stdDev);
toprint=newArray("this is the mean y point",ycent_mean);
Array.print(toprint);

xcent=round(xcent_mean);
ycent=round(ycent_mean);
centre_pos=newArray(xcent,ycent);
close();
return centre_pos;
	};//end of function


}