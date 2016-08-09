unit cv_types;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  CvSize = record
  	width:Integer;
    height:Integer;
  end;

  PIplImage = ^IplImage;
  TIplCallBack = procedure(const Img    : PIplImage;
                                 XIndex : Integer;
                                 YIndex : Integer;
                                 Mode   : Integer); stdcall;
  PIplTileInfo = ^IplTileInfo;
  IplTileInfo = record
    CallBack : TIplCallBack; // callback function
    Id       : Pointer;      // additional identification field
    TileData : PByte;        // pointer on tile data
    Width    : Integer;      // width of tile
    Height   : Integer;      // height of tile
  end;

  PIplROI = ^IplROI;
  IplROI = record
    Coi     : Integer;
    XOffset : Integer;
    YOffset : Integer;
    Width   : Integer;
    Height  : Integer;
  end;


	IplImage = record
    NSize           : Integer;                 // size of iplImage struct
    ID              : Integer;                 // version
    NChannels       : Integer;
    AlphaChannel    : Integer;
    Depth           : Integer;                 // pixel depth in bits
    ColorModel      : array [0..3] of char;//int8_t;
    ChannelSeq      : array [0..3] of char;//int8_t;
    DataOrder       : Integer;
    Origin          : Integer;
    Align           : Integer;                 // 4 or 8 byte align
    Width           : Integer;
    Height          : Integer;
    Roi             : PIplROI;
    MaskROI         : PIplImage;               // poiner to maskROI if any
    ImageId         : Pointer;                 // use of the application
    TileInfo        : PIplTileInfo;            // contains information on tiling
    ImageSize       : Integer;                 // useful size in bytes
    ImageData       : PByte;                   // pointer to aligned image
    WidthStep       : Integer;                 // size of aligned line in bytes
    BorderMode      : array [0..3] of Integer;
    BorderConst     : array [0..3] of Integer;
    ImageDataOrigin : PByte;                   // ptr to full, nonaligned image
  end;

implementation

end.

