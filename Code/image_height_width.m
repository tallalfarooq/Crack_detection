function [ height,width,out_img ] = image_height_width ( gray_img )
level = graythresh(gray_img);
seg_img = im2bw(gray_img,level);
[L num] = bwlabel(seg_img);
    for j = 1:num
        if length(find(L == j)) < 20
            L(L==j) = 0;
        end
    end
    L1 = imdilate(L,ones(3));
    [labe num] = bwlabel(L1);
    %%impixelinfo
    %hold on
    box = regionprops(labe,'BoundingBox');
    m_bounv=0;
    m_bounl=0;
    
    for j = 1:num
      
        r_size=  round(box(j).BoundingBox);
        
        
        
        if(m_bounv<(r_size(4)*r_size(3))  ) 
           
           
            m_bounv=r_size(4)*r_size(3);
            m_bounl=j;
        end
        
    end
    %hold off
 if(m_bounl~=0)
r_size=  round(box(m_bounl).BoundingBox);
 r_img=(seg_img(r_size(2):r_size(2)+r_size(4)-1,r_size(1):r_size(1)+r_size(3)-1,:));
 else
   r_img=zeros(32,32);  
 end
seg_img=~r_img;
w_h_img=seg_img;
%Program for height measurement
pos=0;
height_val=0;
center_pos=1;
for i=1:size(seg_img,1)
    for j=1:size(seg_img,2)
        if(seg_img(i,j)==0 && pos==0) 
            pos=pos+1;
            center_pos=j;
        elseif(seg_img(i,center_pos)==1 && pos==1)
         break;   
        end
      if(j==center_pos && pos==1)
          w_h_img(i,j)=1;
          height_val=height_val+1;
      end
    end
end
% figure, imshow(w_h_img);
%Program for width measurement
col_pos=size(seg_img,2);
row_pos=1;
for i=1:size(seg_img,1)
    for j=1:size(seg_img,2)
        if(seg_img(i,j)==0 && col_pos> j )
            col_pos=j;
            row_pos=i;
            break;
        end
    end
end
 
width_val=0;
%for i=1:size(seg_img,1)
    for j=col_pos:size(seg_img,2)
        
        if(seg_img(row_pos,j)==1 )
         %break;   
        
        else
          w_h_img(row_pos,j)=1;
          width_val=width_val+1;
        end
      
    end
%end
width= width_val;
out_img=w_h_img;
height=height_val;
end
