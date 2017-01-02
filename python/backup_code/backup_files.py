import os
import datetime
import shutil
import sys

# get current time folder name
folder_name=str(datetime.datetime.now())[:16]
# folder_name=folder_name.replace(' ', '_').replace(":", "")

def Get_suffix_lst(filter_suffix_lst):
    tmp_lst=[]
    for filter_suffix in filter_suffix_lst:
        name, suffix = os.path.splitext(filter_suffix)
        tmp_lst.append(suffix)
    return tmp_lst

def filter_files(file_name, filter_suffix_lst):
    name, suffix = os.path.splitext(file_name)
    if suffix in filter_suffix_lst:
        return True
    else:
        return False

# 1. recursion search direction
def RecursionDirection(curDir, filter_suffix_lst, files, dirs):
    ls_name=os.listdir(curDir)
    for name in ls_name:
        name=os.path.join(curDir, name)
        if os.path.isfile(name):
            if filter_files(name, filter_suffix_lst):
                files.append(name)
        else:
            dirs.append(name)
            RecursionDirection(name, filter_suffix_lst, files, dirs)

def ResursionCopyDirFiles(srcDir, dstDir, filter_suffix_lst, files, dirs):
    ls_name=os.listdir(srcDir)
    for name in ls_name:
        if os.path.isfile(os.path.join(srcDir, name)):
            if filter_files(name, filter_suffix_lst):
                shutil.copy(os.path.join(srcDir, name), dstDir)
        else:
            nameDst = dstDir + "/" + name
            os.makedirs(nameDst, 0o777, True)
            name=os.path.join(srcDir, name)
            ResursionCopyDirFiles(name, nameDst, filter_suffix_lst, files, dirs)

# 1. set src directory to current directory

if __name__ == '__main__':
    files=[]
    dirs=[]
    filter_suffix_lst=["*.c", "*.h", "*.cpp", "*.cpp", "*.pas", "*.lpr", "*.sh", "*.py"]
    filter_suffix_lst=Get_suffix_lst(filter_suffix_lst)
    cur_dir=os.getcwd()
    dst_dir=cur_dir+"_backup/"+str(datetime.datetime.now())[:16]
    # os.makedirs(dst_dir, 0o777, True)
    os.makedirs(dst_dir, 0o777, True)
    ResursionCopyDirFiles(cur_dir, dst_dir, filter_suffix_lst, files, dirs)