clc;clear;close all;
% img = '20130320T004404.563948.Cam6_51.png';
% img = '20130320T004405.325839.Cam6_34.png';
% img = '20130320T004407.040126.Cam6_63.png';
% img = '20130320T004421.516678.Cam6_41.png';
% img = '20130320T004422.088064.Cam6_43.png';
% img = '20130320T004422.849954.Cam6_32.png';
% img = '20130320T004352.373192.Cam6_51.png';
% img = '20130320T004354.277980.Cam6_41.png';
% img = '20130320T004401.897143.Cam6_31.png';
clc;clear;close all;
img = '20130320T004353.135082.Cam6_53.png';
src = imread(img); % 读取原图像
hsv = rgb2hsv(src);% 将RGB空间转换到HSV空间
H = medfilt2(hsv(:,:,1),[5,5]);% 对H通道做中值滤波
Threshold = 0.8*max(H(:)); %确定用以分割图像的阈值
BW = im2bw(H,Threshold); % 对H通道做阈值分割获得二值图像
SE = strel('disk',3); % 创建形态学操作结构元(半径为3的圆盘)
BW1 = imopen(BW,SE); % 开操作消除小块区域
BW2 = imfill(BW1,'holes');% 对二值图像做孔洞填充
SE = strel('disk',8);% 创建形态学操作结构元(半径为8的圆盘)
BW2 = imdilate(BW2,SE);% 膨胀操作扩大目标区域
