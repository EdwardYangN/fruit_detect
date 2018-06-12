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
src = imread(img); % ��ȡԭͼ��
hsv = rgb2hsv(src);% ��RGB�ռ�ת����HSV�ռ�
H = medfilt2(hsv(:,:,1),[5,5]);% ��Hͨ������ֵ�˲�
Threshold = 0.8*max(H(:)); %ȷ�����Էָ�ͼ�����ֵ
BW = im2bw(H,Threshold); % ��Hͨ������ֵ�ָ��ö�ֵͼ��
SE = strel('disk',3); % ������̬ѧ�����ṹԪ(�뾶Ϊ3��Բ��)
BW1 = imopen(BW,SE); % ����������С������
BW2 = imfill(BW1,'holes');% �Զ�ֵͼ�����׶����
SE = strel('disk',8);% ������̬ѧ�����ṹԪ(�뾶Ϊ8��Բ��)
BW2 = imdilate(BW2,SE);% ���Ͳ�������Ŀ������

figure(1); % ��ʾԭͼ��Hͨ������ֵͼ��
subplot(221);imshow(src);title('ԭͼ��');
subplot(222);imshow(H);title('ƽ�����Hͨ��');
subplot(223);imshow(BW,[]);title('��ʼ��ֵ�ָ��');
subplot(224);imshow(BW2,[]);title('��̬ѧ������');

% ����ƻ�����ڱ��ָ����������ı߽缰����
[B,L] = bwboundaries(BW2,'noholes');% ��ȡ��ֵͼ����ÿƬ����ı߽�
P = regionprops(BW2,'basic');% ��ȡ�ָ��ÿ������Ļ�����Ϣ(��������ġ��߽��)
centroids = cat(1,P.Centroid); % �õ�ÿ���������������
figure(2); % ��ԭͼ�������ˮ������
subplot(121);imshow(src);
subplot(122);imshow(src);
hold on;
for k=1:length(B) % ��������߽�
    boundary = B{k};
   plot(boundary(:,2),boundary(:,1),'w','LineWidth',2); 
end
hold on;% ���������ıꡮ+��
plot(centroids(:,1),centroids(:,2),'r+','LineWidth',2);
% hold on; % �����߽��
% bbox = cat(1,P.BoundingBox);
% for i=1:size(bbox,1)
%     rectangle('Position',bbox(i,:));
% end
% Ȧ��ƻ������λ�ü�ƻ��
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
