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
#
#
# import tkinter as tk
# from tkinter import filedialog,simpledialog,messagebox
#
# mywindow=tk.Tk()
# mywindow.geometry('400x200')
#
# def add_labels():
#     #label1=tk.Label(mywindow,text='Please select input folder')
#     #label1.pack()
#     indir = filedialog.askdirectory()
#
# def add_labels():
#     label2=tk.Label(mywindow,text='Select or create output folder')
#     label2.pack()
#     outdir = filedialog.askdirectory()
#
#
#
#
# button1=tk.Button(mywindow,text='Click to select input folder',command=add_labels)
# button1.pack()
#
# mywindow.mainloop()



import tkinter as tk
from tkinter import filedialog
import os

application_window = tk.Tk()

# Build a list of tuples for each file type the file dialog should display
my_filetypes = [('all files', '.*'), ('text files', '.txt')]

# Ask the user to select a folder.
answer = filedialog.askdirectory(parent=application_window,
                                 initialdir=os.getcwd(),
                                 title="Please select a folder:")

# Ask the user to select a single file name.
answer = filedialog.askopenfilename(parent=application_window,
                                    initialdir=os.getcwd(),
                                    title="Please select a file:",
                                    filetypes=my_filetypes)

# Ask the user to select a one or more file names.
answer = filedialog.askopenfilenames(parent=application_window,
                                     initialdir=os.getcwd(),
                                     title="Please select one or more files:",
                                     filetypes=my_filetypes)

# Ask the user to select a single file name for saving.
answer = filedialog.asksaveasfilename(parent=application_window,
                                      initialdir=os.getcwd(),
                                      title="Please select a file name for saving:",
                                      filetypes=my_filetypes)

application_window.mainloop()
