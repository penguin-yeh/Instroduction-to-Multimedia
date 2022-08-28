
clear;
origin_image= imread('D:\3rd_grade\MM\Project_2\result\柴犬飛飛.jpg');
[row, column, numberofchannel] = size(origin_image);%get size
%disp(origin_image);
subplot(3,3,1);
imshow(origin_image);
title('original');hold  on

origin_image = im2double(origin_image);
test_image = origin_image;
test_image = im2double(test_image);
% a
% 3*3 G
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [3,3], 1);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            for a = 1:3
                for b = 1:3
                    image(j-1, k-1, i) = image(j-1, k-1, i) + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                end
            end
        end
    end
end
a_3by3 = image ; % save
subplot(3,3,2);
imshow(a_3by3);
title('(a) 3X3');hold on
a_peaksnr_3by3 = psnr(a_3by3,origin_image) ;
fprintf('(a)PSNR when hsize=3X3 : %f\n', a_peaksnr_3by3);

% 7*7 G
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+6, column+6, numberofchannel);
for i = 1:numberofchannel
    for j = 4:row+3
        for k = 4:column+3
            zero_edge_image(j, k, i) = test_image(j-3, k-3, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [7,7], 1);
for i = 1:numberofchannel
    for j = 4:row+3
        for k = 4:column+3
            for a = 1:7
                for b = 1:7
                    image(j-3, k-3, i) = image(j-3, k-3, i) + zero_edge_image(j-4+a, k-4+b, i)*G(a, b);
                end
            end
        end
    end
end
a_7by7 = image ; % save
%disp(a_7by7);
subplot(3,3,3);
imshow(a_7by7);
title('(a) 7X7');hold on
a_peaksnr_7by7 = psnr(a_7by7,origin_image) ;
fprintf('   PSNR when hsize=7X7 : %f\n', a_peaksnr_7by7);

%13*13
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+12, column+12, numberofchannel);
for i = 1:numberofchannel
    for j = 7:row+6
        for k = 7:column+6
            zero_edge_image(j, k, i) = test_image(j-6, k-6, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [13,13], 1);
for i = 1:numberofchannel
    for j = 7:row+6
        for k = 7:column+6
            for a = 1:13
                for b = 1:13
                    image(j-6, k-6, i) = image(j-6, k-6, i) + zero_edge_image(j-7+a, k-7+b, i)*G(a, b);
                end
            end
        end
    end
end
a_13by13 = image ; % save
%disp(a_13by13);
subplot(3,3,4);
imshow(a_13by13);
title('(a) 13X13');hold on
a_peaksnr_13by13 = psnr(a_13by13,origin_image) ;
fprintf('   PSNR when hsize=13X13 : %f\n', a_peaksnr_13by13);

%b
%sigma = 1
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [3,3], 1);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            for a = 1:3
                for b = 1:3
                    image(j-1, k-1, i) = image(j-1, k-1, i) + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                end
            end
        end
    end
end
b_1 = image ; % save
b_peaksnr_1 = psnr(b_1,origin_image) ;
subplot(3,3,5);
imshow(b_1);
title('(b) 1');
fprintf('(b)PSNR when sigma=1 : %f\n', b_peaksnr_1);

%sigma = 30
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [3,3], 30);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            for a = 1:3
                for b = 1:3
                    image(j-1, k-1, i) = image(j-1, k-1, i) + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                end
            end
        end
    end
end
b_30 = image ; % save
b_peaksnr_30 = psnr(b_30,origin_image) ;
subplot(3,3,6);
imshow(b_30);
title('(b) 30');
fprintf('   PSNR when sigma=30 : %f\n', b_peaksnr_30);

%sigma = 100
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image:(1~row, 1~column, 1~numberofchannel)
G = fspecial('gaussian', [3,3], 100);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            for a = 1:3
                for b = 1:3
                    image(j-1, k-1, i) = image(j-1, k-1, i) + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                end
            end
        end
    end
end
b_100 = image ; % save
b_peaksnr_100 = psnr(b_100,origin_image) ;
subplot(3,3,7);
imshow(b_100);
title('(b) 100');hold on
%saveas(gcf,'penguin.jpg');
fprintf('   PSNR when sigma=100 : %f\n', b_peaksnr_100);

%d
%unsharp mask
%create image that edges' elements are all zeros

zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%zero_edge_image = im2double(zero_edge_image);
%disp(zero_edge_image);
%image = im2uint8(image);
%image:(1~row, 1~column, 1~numberofchannel)
G = [0 -1 0; -1 5 -1;0 -1 0];
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
                temp = 0.0;
                for a = 1:3
                    for b = 1:3
                        temp = temp + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                    end
                end
                image(j-1, k-1, i) = temp;
        end
    end
end
unsharp = image ; % save
%disp(unsharp);
subplot(3,3,8);
imshow(unsharp);
title('(d) unsharp');hold on

%edge detection
%create image that edges' elements are all zeros
zero_edge_image = zeros(row+2, column+2, numberofchannel);
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            zero_edge_image(j, k, i) = test_image(j-1, k-1, i);
        end
    end
end
%disp(zero_edge_image);
image = zeros(row, column, numberofchannel);
%image = im2uint8(image);
%image:(1~row, 1~column, 1~numberofchannel)
G = [-1 -1 -1; -1 8 -1; -1 -1 -1];
for i = 1:numberofchannel
    for j = 2:row+1
        for k = 2:column+1
            temp = 0;
            for a = 1:3
                for b = 1:3
                    temp = temp + zero_edge_image(j-2+a, k-2+b, i)*G(a, b);
                end
            end
            image(j-1, k-1, i) = temp;
        end
    end
end
edge_detection = image ; % save
%disp(edge_detection);
subplot(3,3,9);
imshow(edge_detection);
title('(d) edge detection');hold on

%disp(origin_image);
G_1 = fspecial('gaussian', [3,3], 1);
G_30 = fspecial('gaussian', [3,3], 30);
G_100 = fspecial('gaussian', [3,3], 100);


