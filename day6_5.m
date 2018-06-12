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

figure(1); % 显示原图、H通道、二值图像
subplot(221);imshow(src);title('原图像');
subplot(222);imshow(H);title('平滑后的H通道');
subplot(223);imshow(BW,[]);title('初始阈值分割后');
subplot(224);imshow(BW2,[]);title('形态学操作后');

% 画出苹果所在被分割出来的区域的边界及中心
[B,L] = bwboundaries(BW2,'noholes');% 获取二值图像中每片区域的边界
P = regionprops(BW2,'basic');% 获取分割后每个区域的基本信息(面积、中心、边界框)
centroids = cat(1,P.Centroid); % 得到每个区域的中心坐标
figure(2); % 在原图标出疑似水果区域
subplot(121);imshow(src);
subplot(122);imshow(src);
hold on;
for k=1:length(B) % 画出区域边界
    boundary = B{k};
   plot(boundary(:,2),boundary(:,1),'w','LineWidth',2); 
end
hold on;% 在区域中心标‘+’
plot(centroids(:,1),centroids(:,2),'r+','LineWidth',2);
% hold on; % 画出边界框
% bbox = cat(1,P.BoundingBox);
% for i=1:size(bbox,1)
%     rectangle('Position',bbox(i,:));
% end
% 圈出苹果所在位置及苹果
hold on;
for i=1:size(P,1)
    R = sqrt(P(i).Area/(1.5*pi));
    plotCircle(centroids(i,1),centroids(i,2),R);
end
% %
% aa = double(src);
% aaa = double(BW2);
% aaaa=aa;
% for i=1:3
%    aaaa(:,:,i)=aa(:,:,i).*aaa; 
% end
% figure(3);
% subplot(121);imshow(src);
% subplot(122);imshow(uint8(aaaa));
