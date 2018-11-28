// RUNS MAGNetQA TESTS
close("*")
roiManager("reset");

//SNR measurements with the HEADCOIL 
 SE_HEAD_SNR_TRA_1="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_TRA_1";
 SE_HEAD_SNR_COR_1="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_COR_1";
 SE_HEAD_SNR_SAG_1="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_SAG_1";

 SE_HEAD_SNR_TRA_2="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_TRA_2";
 SE_HEAD_SNR_COR_2="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_COR_2";
 SE_HEAD_SNR_SAG_2="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_HEAD_SNR_SAG_2";


//GEOMETRIC_LINEARITY_TRA measurements
 GEOMETRIC_LINEARITY_TRA="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_BODY_GEOMETRIC_LINEARITY_TRA";
 GEOMETRIC_LINEARITY_COR="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_BODY_GEOMETRIC_LINEARITY_COR";
 GEOMETRIC_LINEARITY_SAG="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/SE_BODY_GEOMETRIC_LINEARITY_SAG";

//GHOSTING measurements
 GHOSTING_1="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/MultiEchoSE_HEAD_GHOSTING_TRA_NSA1";
 GHOSTING_2="/Users/papo/Documents/QA and Acceptance tests/PETMR_QA_20181029_Pat/hierarchixca/Annual_Qa_Mmr_Biograph/All_Physics_Marilena/MultiEchoSE_HEAD_GHOSTING_TRA_NSA2";


 Results_dir="/Users/papo/Desktop/QAResults";


//Create Results_dir folder
if ( File.isDirectory(Results_dir)==0 ){
print("Creating folder "+ Results_dir);
File.makeDirectory(Results_dir);
}

 
//store results_dir path
call("ij.Prefs.set", "myMacros.savedir", Results_dir); 
//store filename paths 
call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_TRA_1", SE_HEAD_SNR_TRA_1);
call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_COR_1", SE_HEAD_SNR_COR_1);
call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_SAG_1", SE_HEAD_SNR_SAG_1);

call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_TRA_2", SE_HEAD_SNR_TRA_2);
call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_COR_2", SE_HEAD_SNR_COR_2);
call("ij.Prefs.set", "myMacros.SE_HEAD_SNR_SAG_2", SE_HEAD_SNR_SAG_2);


call("ij.Prefs.set", "myMacros.GEOMETRIC_LINEARITY_TRA", GEOMETRIC_LINEARITY_TRA);
call("ij.Prefs.set", "myMacros.GEOMETRIC_LINEARITY_COR", GEOMETRIC_LINEARITY_COR);
call("ij.Prefs.set", "myMacros.GEOMETRIC_LINEARITY_SAG", GEOMETRIC_LINEARITY_SAG);


call("ij.Prefs.set", "myMacros.GHOSTING_1", GHOSTING_1);
call("ij.Prefs.set", "myMacros.GHOSTING_2", GHOSTING_2);


//this will retrieve stored valeu of myMacros.savedir to myvalue 
//myvalue = call("ij.Prefs.get", "myMacros.savedir", "defaultValue"); 




// RUN SIGNAL UNIFORMITY: 
//runMacro("/Users/papo/Documents/QA and Acceptance tests/NEW_MACROS/SIGNAL_UNIFORMITY.ijm") ;

// RUN GEOMETRIC_LINEARITY:
//runMacro("/Users/papo/Documents/QA and Acceptance tests/NEW_MACROS/GEOMETRIC_LINEARITY.ijm");


// RUN SLICE WIDTH:
//runMacro("/Users/papo/Documents/QA and Acceptance tests/NEW_MACROS/SLICE_WIDTH.ijm");


// RUN SLICE WIDTH:
//runMacro("/Users/papo/Documents/QA and Acceptance tests/NEW_MACROS/GHOSTING.ijm");

//close("*");



//runMacro("/Users/papo/Documents/QA and Acceptance tests/Macros/Generate_file_list.py") ;

print("");
print("Done!");
print("");
print("");