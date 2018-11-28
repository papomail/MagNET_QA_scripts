
macro "GHOSTING" {

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
GHOSTING(GHOSTING_1,Results_dir);
GHOSTING(GHOSTING_2,Results_dir);




//////////////////////////
/// Function definition:   GEOMETRIC_LINEARITY_TEST
function GHOSTING(filename,results_dir) {



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






}