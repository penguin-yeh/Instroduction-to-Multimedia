clear

correct_sad_cnt = 0;
correct_ssd_cnt = 0;
false_face_sad = 0;
false_glasses_sad = 0;
false_scarf_sad = 0;
false_face_ssd = 0;
false_glasses_ssd = 0;
false_scarf_ssd = 0;
accuracy = 0.0;
accuracy = typecast(accuracy,'double');
%read testing data
testing_file_path = 'D:\3rd_grade\MM\Project_1\dataset\test\';
testing_img_path_list = dir(strcat(testing_file_path,'*.bmp'));
testing_img_num = length(testing_img_path_list);
if testing_img_num > 0
    for i = 1:testing_img_num

        min_sad = 1000000000.0;
        min_sad = typecast(min_sad,'double');
        min_ssd = 1000000000.0;
        property_sad = 0;
        testing_img_name = testing_img_path_list(i).name;
        testing_img = imread(strcat(testing_file_path,testing_img_name));
%         for j=1:165
%             for k=1:120
%                 fprintf('%d ',testing_img(j,k));
%             end
%         end
        testing_img = im2double(testing_img);
        % read training data
        training_file_path = 'D:\3rd_grade\MM\Project_1\dataset\training\';
        training_img_path_list = dir(strcat(training_file_path,'*.bmp'));
        training_img_num = length(training_img_path_list);
        if training_img_num > 0
            for j = 1:training_img_num
                SAD = 0;
                SAD = typecast(SAD,'double');
                SSD = 0;
     
                training_img_name = training_img_path_list(j).name; %get img_name from list
                training_img = imread(strcat(training_file_path,training_img_name)); %read this img according to img_name
                training_img = im2double(training_img);
                %processing SAD
                [row, column, numberofchannel] = size(testing_img);%get size
                for k = 1:row
                    for m = 1:column
                        tmp = abs(testing_img(k,m) - training_img(k,m));
                        SAD = SAD + tmp;
                        %fprintf('%f %f\n',testing_img(k,m),training_img(k,m));
                        %fprintf('SAD=%d',SAD);
                        tmp = (testing_img(k,m) - training_img(k,m))^2;
                        %fprintf('%f \n',tmp);
                        SSD = SSD + tmp;
                        %fprintf('SSD=%d\n',SSD);
                    end
                end 

%                     group = j/13;
%                     group = fix(group) + 1;
                    C = strsplit(training_img_name,'-');
                    group = C{1,2};
                    group = str2num(group);
                    %for SAD
                    if SAD < min_sad
                        min_sad = SAD;
                        property_sad = group;
                    end
                    %for SSD
                    if SSD < min_ssd
                        min_ssd = SSD;
                        property_ssd = group;
                    end
%                 end
%                  fprintf('%d %s\n',i,strcat(training_file_path,training_img_name)); % print idx and path of this img
%                  imshow(training_img); % show this image
            end
        end
%         true = i/13;
%         res = mod(i,13);
        new = testing_img_name(1:end-4);
        D = strsplit(new,'-');
        true = D{1,2};
        true = str2num(true);
        false = D{1,3};
        false = str2num(false);
%         if res~=0
%             true = fix(true) + 1;
%         end
        %fprintf('testing:group=%d, %s\n',true,testing_img_name);
        if true==property_sad
            correct_sad_cnt = correct_sad_cnt + 1;
        elseif true~=property_sad
            if false>=14 & false<=20
               false_face_sad = false_face_sad + 1;
            end
            if false>=21 & false<=23
               false_glasses_sad = false_glasses_sad + 1;
            end
            if false>=24 & false<=26
                false_scarf_sad = false_scarf_sad + 1;
            end                
        end
        if true==property_ssd
            correct_ssd_cnt = correct_ssd_cnt + 1;
        elseif true~=property_ssd
            if false>=14 & false<=20
               false_face_ssd = false_face_ssd + 1;
            end
            if false>=21 & false<=23
               false_glasses_ssd = false_glasses_ssd + 1;
            end
            if false>=24 & false<=26
                false_scarf_ssd = false_scarf_ssd + 1;
            end                
        end

        fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~\n');
        fprintf('file name = %s\n',testing_img_name);
        fprintf('-----------SAD-----------\n');
        fprintf('%dth tests:belong:%d,find:%d\n',i,true,property_sad);
        %fprintf('min = %.5f\n',min_sad);
        accuracy =  correct_sad_cnt/training_img_num;
        fprintf('accuracy of sad= %.5f\n',accuracy);
        fprintf('-----------SSD-----------\n');
        fprintf('%dth tests:belong:%d,find:%d\n',i,true,property_ssd);
        %fprintf('min = %.5f\n',min_ssd);
        accuracy =  correct_ssd_cnt/training_img_num;
        fprintf('accuracy of ssd= %.5f\n',accuracy);
        fprintf('~~~~~~~~~~~~~~~~~~~~~~~~~\n\n');

%         imshow(testing_img);  

    end  
        fprintf('~~~~~~~~Conclusion~~~~~~~~\n');
        fprintf('-----------SAD-----------\n');
        accuracy_sad =  correct_sad_cnt/training_img_num;
        fprintf('final accuracy of sad = %.5f\n',accuracy_sad);
        fprintf('error:\n');
        fprintf('face without decoration:%.1f%%\n',false_face_sad/(testing_img_num-correct_sad_cnt)*100);
        fprintf('face with glasses:%.1f%%\n',false_glasses_sad/(testing_img_num-correct_sad_cnt)*100);
        fprintf('face with scarf:%.1f%%\n',false_scarf_sad/(testing_img_num-correct_sad_cnt)*100);
        fprintf('-----------SSD-----------\n');
        accuracy_ssd =  correct_ssd_cnt/training_img_num;
        fprintf('final accurary 0f ssd = %.5f\n',accuracy_ssd);
        fprintf('error percentage:\n');
        fprintf('face without decoration:%.1f%%\n',false_face_ssd/(testing_img_num-correct_ssd_cnt)*100);
        fprintf('face with glasses:%.1f%%\n',false_glasses_ssd/(testing_img_num-correct_ssd_cnt)*100);
        fprintf('face with scarf:%.1f%%\n',false_scarf_ssd/(testing_img_num-correct_ssd_cnt)*100);

        %graphics
%         subplot(1,2,1);
%         x = 1:3;
%         y = [10;20;30];
% 
%         bar(x,y);
%         ylabel('error percentage(%)');
%         set(gca, 'xticklabel', {'face','glasses','scarf'});
end


%size
% [rows, columns, numberofchannels] = size(testing_img);

%im2double
% testing_img_1 = im2double(testing_img_1);
% testing_img_2 = im2double(testing_img_2);

%SAD 
% sum_ab = 0;
% sum_ab = typecast(sum_ab,'double');
% for i = 1:rows
%     for j = 1:columns
%         tmp = abs(testing_img_2(i,j) - testing_img_1(i,j));
%         sum_ab = sum_ab + tmp;
%         fprintf('%d %d\n',sum_ab,tmp);
%     end
% end    

%SSD
% sum_sq = 0;
% for i = 1:rows
%     for j = 1:columns
%         tmp = testing_img_2(i,j) - testing_img_1(i,j);
%         tmp = tmp*tmp;
%         sum_sq = sum_sq + tmp;
%         fprintf('%d %d\n',sum_sq,tmp);
%     end
% end
