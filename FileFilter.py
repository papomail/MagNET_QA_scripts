
@ File    (label = "Input directory", style = "directory") srcFile
@ File    (label = "Output directory", style = "directory") dstFile
@ String  (label = "File extension", value=".tif") ext
@ String  (label = "File name contains", value = "") containString
@ boolean (label = "Keep directory structure when saving", value = true) keepDirectories

# See also Process_Folder.ijm for a version of this code
# in the ImageJ 1.x macro language.

import os
from ij import IJ, ImagePlus
from ij.util import DicomTools
import re

#srcFile=[]
FileDescriptions=[]
FilePaths=[]
#savedir=[]
#FilteredPaths=[]




###########
#### Function defs:

##
def make_file_lists():
  srcDir = srcFile.getAbsolutePath()
  dstDir = dstFile.getAbsolutePath()
  make_file_lists.savedir=dstDir
  for root, directories, filenames in os.walk(srcDir):
    filenames.sort();
    for filename in filenames:
      # Check for file extension
      if not filename.endswith(ext):
        continue
      # Check for file name pattern
      if containString not in filename:
        continue
      process(srcDir, dstDir, root, filename, keepDirectories)


##
def process(srcDir, dstDir, currentDir, fileName, keepDirectories):

  # Opening the image
  print "Proccesing file ",os.path.join(currentDir, fileName)
  imp = IJ.openImage(os.path.join(currentDir, fileName))
  #studyDescription = ij.util.DicomTools.getTag(imp, "0008,1030");
  SeriesDescription = DicomTools.getTag(imp, "0008,103E");

  FileDescriptions.append(SeriesDescription)
  FilePaths.append(os.path.join(currentDir, fileName))

  # Saving text files
  saveDir = currentDir.replace(srcDir, dstDir) if keepDirectories else dstDir
  if not os.path.exists(saveDir):
    os.makedirs(saveDir)
  #IJ.saveAs(imp, "png", os.path.join(saveDir, fileName));
  #imp.close()

  with open(saveDir+os.sep+"AllFiles.txt", "w") as f:
    for desc,path in zip(FileDescriptions,FilePaths):
    	f.write(str(desc) +  ',' +str(path) + "\n")



  with open(saveDir+os.sep+"FilesToProcess.txt", "w") as f:
  	for rf in required_files:
  		for desc,path in zip(FileDescriptions,FilePaths):
  			searchObj = re.findall(rf['keys'], desc, re.M|re.I)
  			if searchObj:
  				f.write(rf['id']+ ' = ' +str(path) +"\n")
  				break




######## Script execution

required_files=[
{'id':'HEAD_SNR_TRA_1','keys': '.*HEAD.*SNR.*TRA.*1.*'},
{'id':'HEAD_SNR_TRA_2','keys': '.*HEAD.*SNR.*TRA.*2.*'},
{'id':'HEAD_SNR_COR_1','keys': '.*HEAD.*SNR.*COR.*1.*'},
{'id':'HEAD_SNR_COR_2','keys': '.*HEAD.*SNR.*COR.*2.*'},
{'id':'HEAD_SNR_SAG_1','keys': '.*HEAD.*SNR.*SAG.*1.*'},
{'id':'HEAD_SNR_SAG_2','keys': '.*HEAD.*SNR.*SAG.*2.*'},

{'id':'BODY_SNR_TRA_1','keys': '.*BODY.*SNR.*TRA.*1.*'},
{'id':'BODY_SNR_TRA_2','keys': '.*BODY.*SNR.*TRA.*2.*'},
{'id':'BODY_SNR_COR_1','keys': '.*BODY.*SNR.*COR.*1.*'},
{'id':'BODY_SNR_COR_2','keys': '.*BODY.*SNR.*COR.*2.*'},
{'id':'BODY_SNR_SAG_1','keys': '.*BODY.*SNR.*SAG.*1.*'},
{'id':'BODY_SNR_SAG_2','keys': '.*BODY.*SNR.*SAG.*2.*'}]




## Run the make list script
make_file_lists()
print "FilesToProcess.txt and AllFiles.txt are saved in", make_file_lists.savedir
