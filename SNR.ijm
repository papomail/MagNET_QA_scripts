

macro "SNR" {

////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue");

// HEAD coil images
HEAD_SNR_TRA_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_TRA_1", "defaultValue");
HEAD_SNR_COR_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_COR_1", "defaultValue");
HEAD_SNR_SAG_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_SAG_1", "defaultValue");

HEAD_SNR_TRA_2 = call("ij.Prefs.get", "myMacros.HEAD_SNR_TRA_2", "defaultValue");
HEAD_SNR_COR_2 = call("ij.Prefs.get", "myMacros.HEAD_SNR_COR_2", "defaultValue");
HEAD_SNR_SAG_2 = call("ij.Prefs.get", "myMacros.HEAD_SNR_SAG_2", "defaultValue");



// BODY coil images
BODY_SNR_TRA_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_TRA_1", "defaultValue");
BODY_SNR_COR_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_COR_1", "defaultValue");
BODY_SNR_SAG_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_SAG_1", "defaultValue");

BODY_SNR_TRA_2 = call("ij.Prefs.get", "myMacros.BODY_SNR_TRA_2", "defaultValue");
BODY_SNR_COR_2 = call("ij.Prefs.get", "myMacros.BODY_SNR_COR_2", "defaultValue");
BODY_SNR_SAG_2 = call("ij.Prefs.get", "myMacros.BODY_SNR_SAG_2", "defaultValue");



// run SNR TEST for 3 slice orientations:
//head coil images
SNR_TEST(HEAD_SNR_TRA_1,HEAD_SNR_TRA_2,Results_dir);
SNR_TEST(HEAD_SNR_COR_1,HEAD_SNR_COR_2,Results_dir);
SNR_TEST(HEAD_SNR_SAG_1,HEAD_SNR_SAG_2,Results_dir);
//body coil images
SNR_TEST(BODY_SNR_TRA_1,BODY_SNR_TRA_2,Results_dir);
SNR_TEST(BODY_SNR_COR_1,BODY_SNR_COR_2,Results_dir);
SNR_TEST(BODY_SNR_SAG_1,BODY_SNR_SAG_2,Results_dir);


//Close images
close("*");







//////////////////////////
/// Function definition:   SNR_TEST
function SNR_TEST(filename,filename2,results_dir) {
//Will run the SNR_TEST of the selected image (one slice) and save the result in the results_dir/SNR_TEST directory


// Close all images
//while (nImages>0) {
 //         selectImage(nImages);
  //        close();
  //    } ;
  close("*");


outdir=results_dir+File.separator+"SNR";
screenshot_dir=outdir+File.separator+"ScreenshotCheck";


//Create SNR folder
if ( File.isDirectory(outdir)==0 ){
print("Creating folder "+ outdir);
File.makeDirectory(outdir);
}

//Create screenshot_dir folder
if ( File.isDirectory(screenshot_dir)==0 ){
print("Creating folder "+ screenshot_dir);
File.makeDirectory(screenshot_dir);
}

open(filename2);
myimage2=getTitle();

open(filename);
myimage=getTitle();
selectWindow(myimage);

centre_pos=find_phantom_centre();
print("Phantom centre at x,y =");
Array.print(centre_pos); //show central point (x,y) of the phantom

selectWindow(myimage);
run("ROI Manager...");
roiManager("reset");


//Create ROIs
makeRectangle(centre_pos[0]-10-45,  centre_pos[1]-10-45 ,20,   20);
roiManager("Add");
makeRectangle(centre_pos[0]-10+45,  centre_pos[1]-10-45 ,20,   20);
roiManager("Add");
makeRectangle(centre_pos[0]-10,  centre_pos[1]-10 ,20,   20);
roiManager("Add");
makeRectangle(centre_pos[0]-10-45,  centre_pos[1]-10+45 ,20,   20);
roiManager("Add");
makeRectangle(centre_pos[0]-10+45,  centre_pos[1]-10+45 ,20,   20);
roiManager("Add");



//////  Uncomment the next 7 lines to manually move ROIs
//roiManager("Combine");
//waitForUser( "Pause","Move ROI as required \n Press OK when finished");
//selectWindow("SE_HEAD_SNR_TRA_1");
//roiManager("Split");
//roiManager("Select", newArray(0,1,2,3,4));
//roiManager("Deselect");
//roiManager("Delete");

//Mean Signal Measurement from image1:
run("Set Measurements...", "  mean redirect=None decimal=3");
//run("Set Measurements...", "  mean standard ");
roiManager("Measure");


selectWindow(myimage);
run("Duplicate...", "dup1");
rename("dup1");

selectWindow(myimage2);
run("Duplicate...", "dup2");
rename("dup2");
//Subtraction image and Noise Measurements
run("Calculator Plus", "i1=dup1 i2=dup2 operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=200 create");

run("Set Measurements...", " mean standard redirect=None decimal=3");
roiManager("Measure");



//save results
saveAs("Results", outdir+File.separator+myimage+"SNR Results.csv");
run("Clear Results");

//take screenshots
selectWindow(myimage);
setLocation(1,1,1028,1028);
myscreenshot=screenshot_dir+File.separator+myimage+"_SNR.png";
roiManager("show all");
wait(100);
exec("screencapture", myscreenshot);
setLocation(1,1,300,300);

close("*dup*");


}





//////////////////////////
/// Function definition:  find_phantom_centre

function find_phantom_centre(){
//Finds x,y position in the centre of the phantom
name = "edge image";
run("Duplicate...", "title=&name");
run("Find Edges");

makeRectangle(0, 0, 256, 256);
Xprofile = getProfile();
xpos=Array.rankPositions(Xprofile);
midx=(lengthOf(xpos)-1)/2;

for (i=0;i<10;i++) {
xcent=(xpos[lengthOf(xpos)-1]+xpos[lengthOf(xpos)-2-i])/2;
if  ( abs(xcent- midx)  <=  midx/4  ){
 break;}
}

selectWindow("edge image");
run("Rotate 90 Degrees Left");
makeRectangle(0, 0, 256, 256);
Yprofile = getProfile();
ypos=Array.rankPositions(Yprofile);
midy=(lengthOf(xpos)-1)/2;

for (i=0;i<10;i++) {
ycent=( ypos[lengthOf(ypos)-1] + ypos[lengthOf(ypos)-2-i]  )/2;
if  ( abs(ycent- midy)  <=  midy/4  ){
 break;}
}

xcent=round(xcent);
ycent=round(ycent);
centre_pos=newArray(xcent,ycent);
close();
return centre_pos;
	};//end of function


  }
