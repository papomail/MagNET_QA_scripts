


macro "SIGNAL_UNIFORMITY_NOPLOTS" {

////Use if you want to call the macro with arguments
//arguments=getArgument()
//arguments="hello, world";
//arg_array=split(arguments,",,");
//myfilename=arg_array[0];
//Results_dir=arg_array[0];


//Retrieve filenames and Results_dir path 
Results_dir = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 
HEAD_SNR_TRA_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_TRA_1", "defaultValue"); 
HEAD_SNR_COR_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_COR_1", "defaultValue"); 
HEAD_SNR_SAG_1 = call("ij.Prefs.get", "myMacros.HEAD_SNR_SAG_1", "defaultValue"); 

BODY_SNR_TRA_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_TRA_1", "defaultValue"); 
BODY_SNR_COR_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_COR_1", "defaultValue"); 
BODY_SNR_SAG_1 = call("ij.Prefs.get", "myMacros.BODY_SNR_SAG_1", "defaultValue"); 


// run SIGNAL UNIFORMITY TEST for 3 slice orientations:
SIGNAL_UNIFORMITY_TEST(HEAD_SNR_TRA_1,Results_dir);
SIGNAL_UNIFORMITY_TEST(HEAD_SNR_COR_1,Results_dir);
SIGNAL_UNIFORMITY_TEST(HEAD_SNR_SAG_1,Results_dir);




// run SIGNAL UNIFORMITY TEST for 3 slice orientations BODY COIL:
SIGNAL_UNIFORMITY_TEST(BODY_SNR_TRA_1,Results_dir);
SIGNAL_UNIFORMITY_TEST(BODY_SNR_COR_1,Results_dir);
SIGNAL_UNIFORMITY_TEST(BODY_SNR_SAG_1,Results_dir);







//////////////////////////
/// Function definition:   SIGNAL_UNIFORMITY_TEST
function SIGNAL_UNIFORMITY_TEST(filename,results_dir) {
//Will run the horizontal and vertical signal uniformity test of the selected image (one slice) and save the result in the results_dir/Uniformity directory


// Close all images
//while (nImages>0) {
 //         selectImage(nImages);
  //        close();
  //    } ;
  close("*");

uniformity_outdir=results_dir+File.separator+"UNIFORMITY";

//Create uniformity folder
if ( File.isDirectory(uniformity_outdir)==0 ){
print("Creating folder "+ uniformity_outdir);
File.makeDirectory(uniformity_outdir);
}


open(filename);
myimage=getTitle();
selectWindow(myimage);

centre_pos=find_phantom_centre();
print("Phantom centre at x,y ="); 
Array.print(centre_pos); //show central point (x,y) of the phantom

selectWindow(myimage);
run("ROI Manager...");
roiManager("reset");


//roiManager("Open", TRA_ROI_CENTRAL);
makeRectangle(centre_pos[0]-10,  centre_pos[1]-10 ,20,   20);
roiManager("Add");
roiManager("Select", 0);

//move ROIs, pause here...
//waitForUser( "Pause","Move ROI to the centre of the phantom. \n Press OK when finished");
roiManager("Update");


Table.reset("Results");
//Mean Signal Measurement from image1:
run("Set Measurements...", "  mean redirect=None decimal=3");
//run("Set Measurements...", "  mean standard ");
roiManager("Measure");


run("Add Selection...");
//roiManager("Open", UNI_HORZ_160by10);
//Horizontal ROI
makeRectangle(centre_pos[0]-80,  centre_pos[1]-5, 160, 10);
roiManager("Add");
roiManager("Select", 1);
//waitForUser( "Pause","Put the rectangular ROI symetrically on top of the central ROI. \n Press OK when finished");
roiManager("Update");
 Horizontal_profile = getProfile();


//Vertical ROI
makeRectangle(centre_pos[0]-5,  centre_pos[1]-80, 10, 160);
roiManager("Add");
roiManager("Select", 2);
//waitForUser( "Pause"," ...same but with the vertical rectangle now. \n Press OK when finished");
roiManager("Update");
setKeyDown("alt");
 Vertical_profile = getProfile();

// Get profile and display values in "Results" window

  for (i=0; i<Horizontal_profile.length; i++){
      setResult("Horizontal profile values", i, Horizontal_profile[i]);
      setResult("Vertical profile values", i, Vertical_profile[i]);

  updateResults;}
saveAs("Results", uniformity_outdir+File.separator+myimage+"_UNIFORMITY.csv");
//////////




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
close("*")