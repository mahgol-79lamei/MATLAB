clc
clear

%reading the image and converting to appropriate format for matlab
img = imread('img2.tif');
bw = im2bw(img);
[r,c] = size(bw);

%getting the coordinates
disp('enter your pixel coordinates:');
x=input('x: ');
y=input('y: ');
while x>r || y>c || x<0 || y<0
    disp('out of range! enter again:')
    x=input('x: ');
    y=input('y: ');
end
    
list=[x,y];

while ~isempty(list)
    cur = list(1,:);
    list(1,:)=[];
    if bw(cur(1),cur(2))==1
        bw(cur(1),cur(2))=0;
        if cur(1)-1 > 0 & bw(cur(1)-1,cur(2))==1
            list=[list;[cur(1)-1,cur(2)]];
        end
        if cur(1) < r & bw(cur(1)+1,cur(2))==1
            list=[list;[cur(1)+1,cur(2)]];
        end
        if cur(2)-1 > 0 & bw(cur(1),cur(2)-1)==1
            list=[list;[cur(1),cur(2)-1]];
        end
        if cur(2) < c & bw(cur(1),cur(2)+1)==1
            list=[list;[cur(1),cur(2)+1]];
        end        
    end
end

figure
imshowpair(img,bw,'montage')
