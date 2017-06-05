#!/bin/bash

OutputName=$(basename $(pwd))

Cli=$1
ExtPr=$2

SDKPath=/home/ouo/code/sdk
OpencvPath=$SDKPath/opencv
OpencvInclude=$OpencvPath/include
OpencvLibPath=$OpencvPath/lib
OpencvLibs="\
 -lopencv_highgui \
 -lopencv_imgproc \
 -lopencv_highgui_pch_dephelp \
 -lopencv_core \
 -lopencv_core_pch_dephelp \
 -lopencv_calib3d \
 -lopencv_calib3d_pch_dephelp \
 -lopencv_contrib \
 -lopencv_contrib_pch_dephelp \
 -lopencv_features2d \
 -lopencv_features2d_pch_dephelp \
 -lopencv_flann \
 -lopencv_flann_pch_dephelp \
 -lopencv_gpu \
 -lopencv_gpu_pch_dephelp \
 -lopencv_haartraining_engine \
 -lopencv_imgproc_pch_dephelp \
 -lopencv_legacy \
 -lopencv_legacy_pch_dephelp \
 -lopencv_ml \
 -lopencv_ml_pch_dephelp \
 -lopencv_nonfree \
 -lopencv_nonfree_pch_dephelp \
 -lopencv_objdetect \
 -lopencv_objdetect_pch_dephelp \
 -lopencv_ocl \
 -lopencv_ocl_pch_dephelp \
 -lopencv_perf_calib3d_pch_dephelp \
 -lopencv_perf_core_pch_dephelp \
 -lopencv_perf_features2d_pch_dephelp \
 -lopencv_perf_gpu_pch_dephelp \
 -lopencv_perf_highgui_pch_dephelp \
 -lopencv_perf_imgproc_pch_dephelp \
 -lopencv_perf_nonfree_pch_dephelp \
 -lopencv_perf_objdetect_pch_dephelp \
 -lopencv_perf_ocl_pch_dephelp \
 -lopencv_perf_photo_pch_dephelp \
 -lopencv_perf_stitching_pch_dephelp \
 -lopencv_perf_superres_pch_dephelp \
 -lopencv_perf_video_pch_dephelp \
 -lopencv_photo \
 -lopencv_photo_pch_dephelp \
 -lopencv_stitching \
 -lopencv_stitching_pch_dephelp \
 -lopencv_superres \
 -lopencv_superres_pch_dephelp \
 -lopencv_test_calib3d_pch_dephelp \
 -lopencv_test_contrib_pch_dephelp \
 -lopencv_test_core_pch_dephelp \
 -lopencv_test_features2d_pch_dephelp \
 -lopencv_test_flann_pch_dephelp \
 -lopencv_test_gpu_pch_dephelp \
 -lopencv_test_highgui_pch_dephelp \
 -lopencv_test_imgproc_pch_dephelp \
 -lopencv_test_legacy_pch_dephelp \
 -lopencv_test_ml_pch_dephelp \
 -lopencv_test_nonfree_pch_dephelp \
 -lopencv_test_objdetect_pch_dephelp \
 -lopencv_test_ocl_pch_dephelp \
 -lopencv_test_photo_pch_dephelp \
 -lopencv_test_stitching_pch_dephelp \
 -lopencv_test_superres_pch_dephelp \
 -lopencv_test_video_pch_dephelp \
 -lopencv_ts \
 -lopencv_ts_pch_dephelp \
 -lopencv_video \
 -lopencv_video_pch_dephelp \
 -lopencv_videostab \
 -lopencv_videostab_pch_dephelp \
 -lIlmImf \
 -lzlib \
 -llibjasper \
 -llibjpeg \
 -llibpng \
 -llibtiff \
 -lpthread \
 -lgobject-2.0 \
 -lgtk-x11-2.0 \
 -lgdk-x11-2.0 \
"
$Cli $ExtPr ./loaddemo.cpp -I$OpencvInclude -L$OpencvLibPath $OpencvLibs -lglib-2.0 -fPIC -o$OutputName
