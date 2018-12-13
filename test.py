#from tkinter import filedialog
# import tkinter

# @ File    (label = "Input directory", style = "directory") srcFile
# @ File    (label = "Output directory", style = "directory") dstFile
# @ String  (label = "File extension", value=".tif") ext
# @ String  (label = "File name contains", value = "") containString
# @ boolean (label = "Keep directory structure when saving", value = true) keepDirectories

#
# srcPath = filedialog.askdirectory()
# dstPath = filedialog.askdirectory()


from tkinter import filedialog
dirselect = filedialog.Directory()
dirs = []
while True:
    d = dirselect.show()
    if not d: break
    dirs.append(d)
