function [ imres ] = mosaic( folderName,opts )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    url = [opts.fileReader.folderURL,folderName];
    if(url(end)~='/')
        url(end+1)='/';
    end
    files = dir([url, '*.' opts.fileReader.extension]);
    totalViews= size(files,1);
    x = imread([url files(1).name]);
    sift(size(files,1)).keypoints=[];
    imdb = zeros(size(x,1),size(x,2),size(files,1));
    imdbcolor = zeros(size(x,1),size(x,2),3,size(files,1));
    imdb= single(imdb);
    if(opts.sift.loadKeypoints&&exist([folderName 'sift.mat'],'file')~=2)
            display('Cannot Load Sift File , Computing Sift');
    end
    for i =1:totalViews
        x = imread([url , files(i).name]);
        imdbcolor(:,:,:,i)=im2single(x);
        x = rgb2gray(x);
        x=im2single(x);
        imdb(:,:,i)=single(x);
       
        if(~opts.sift.loadKeypoints||exist([folderName 'sift.mat'],'file')~=2)
            [sift(i).keypoints(:,:), sift(i).descriptor(:,:)]= vl_sift(imdb(:,:,i),'Levels',opts.sift.levels);       
        end
    end
    data.imdb=imdb;
    data.mapper(totalViews-1).correspondance.x1=0;
    if(opts.sift.loadKeypoints&&exist([folderName 'sift.mat'],'file')==2)
        load([folderName 'sift'])
    else
        save([folderName 'sift'],'sift')
    end
    data.sift=sift;
    H = zeros(3,3,totalViews-1);
    imdb=double(imdb);
    for i=1:totalViews-1
        [H(:,:,i),correspondance]=compHomography(sift(i),sift(i+1),opts);
        data.mapper(i).correspondance=correspondance;
        if(i~=1)
            H(:,:,i)=H(:,:,i-1)'*inv(H(:,:,i));
            H(:,:,i) = H(:,:,i)';

        else
            H(:,:,i) = inv(H(:,:,i))';
            warpData.im(i).warped=imdbcolor(:,:,:,1)
            warpData.im(i).ref=imref2d(size(imdb(:,:,1)));
        end
            Proj(i) = projective2d(H(:,:,i));
            [warpData.im(i+1).warped warpData.im(i+1).ref] = imwarp(imdbcolor(:,:,:,i+1),Proj(i),'FillValues',nan);
        
    end
    
    xlimmin=arrayfun(@(x)x.ref.XWorldLimits(1),warpData.im);
    xlimmax=arrayfun(@(x)x.ref.XWorldLimits(2),warpData.im);
    ylimMin=arrayfun(@(x)x.ref.YWorldLimits(1),warpData.im);
    ylimMax=arrayfun(@(x)x.ref.YWorldLimits(2),warpData.im);
    xlimmin = min(xlimmin);
    xlimmax = max(xlimmax);
    ylimMin = min(ylimMin);
    ylimMax = max(ylimMax);
    result.sizex = ceil(xlimmax-xlimmin);
    result.sizey = ceil(ylimMax-ylimMin);
    for j= 1:numel(warpData.im)
        warpData.im(j).ref.XWorldLimits(2)=-xlimmin+1+warpData.im(j).ref.XWorldLimits(2);
        warpData.im(j).ref.XWorldLimits(1)=-xlimmin+1+warpData.im(j).ref.XWorldLimits(1);
        
        warpData.im(j).ref.YWorldLimits(2)=-ylimMin+1+warpData.im(j).ref.YWorldLimits(2);
        warpData.im(j).ref.YWorldLimits(1)=-ylimMin+1+warpData.im(j).ref.YWorldLimits(1);
        
    end
    imresult = zeros(result.sizey,result.sizex,3);
    temp = zeros(result.sizey,result.sizex,3);
    for j=1:numel(warpData.im)
        warpData.im(j).ref.XWorldLimits(1)=ceil(warpData.im(j).ref.XWorldLimits(1));
        warpData.im(j).ref.XWorldLimits(2)=ceil(warpData.im(j).ref.XWorldLimits(2));
        warpData.im(j).ref.YWorldLimits(1)=ceil(warpData.im(j).ref.YWorldLimits(1));
        warpData.im(j).ref.YWorldLimits(2)=ceil(warpData.im(j).ref.YWorldLimits(2));
        temp(warpData.im(j).ref.YWorldLimits(1):warpData.im(j).ref.YWorldLimits(1)+size(warpData.im(j).warped,1)-1,...
            warpData.im(j).ref.XWorldLimits(1):warpData.im(j).ref.XWorldLimits(1)+size(warpData.im(j).warped,2)-1,:)=warpData.im(j).warped;
        i=find(~isnan(temp(:,:)));
        imresult(i)=temp(i);
    end
    plotter(data,opts,'descriptor');
    plotter(data,opts,'mapper');
    figure;
    imshow(imresult);
    imres = imresult;
    
    
end
function [H,correspondance] = compHomography(siftImage1,siftImage2,opts)
    [matches,score] = vl_ubcmatch(siftImage1.descriptor,siftImage2.descriptor);
    x1 = [siftImage1.keypoints(1:2,matches(1,:));ones(1,size(matches,2))];
    x2 = [siftImage2.keypoints(1:2,matches(2,:));ones(1,size(matches,2))];
    
    [H,inliers]=ransacfithomography(x1,x2,.01);
    correspondance.x1 = x1(:,inliers);
    correspondance.x2 = x2(:,inliers);
    
end
function []=plotter(data,opts,method)
    if(opts.plot.descriptor.activate&strcmp(method,'descriptor'))
        for i = opts.plot.descriptor.indexRange
            perm = randperm(size(data.sift(i).descriptor,2)) ;
            sel = perm(1:opts.plot.descriptor.total) ;
            figure;
            imshow(data.imdb(:,:,i));
            hold on;
            h3 = vl_plotsiftdescriptor(data.sift(i).descriptor(:,sel),data.sift(i).keypoints(:,sel));
            set(h3,'color','g') ;
           hold off; 
        end
    end
    if(opts.plot.mapper.activate&strcmp(method,'mapper'))
        for i = opts.plot.mapper.indexRange
            figure;
            imshow([data.imdb(:,:,i),data.imdb(:,:,i+1)]);
            hold on;
            perm = randperm(size(data.mapper(i).correspondance.x1(1,:),2)) ;
            sel = perm(1:opts.plot.mapper.totalPoints) ;
            
            plot(data.mapper(i).correspondance.x1(1,sel),data.mapper(i).correspondance.x1(2,sel),'x');
            plot(data.mapper(i).correspondance.x2(1,sel)+size(data.imdb,2),data.mapper(i).correspondance.x2(2,sel),'x');
            for j = sel
                plot([data.mapper(i).correspondance.x1(1,j),data.mapper(i).correspondance.x2(1,j)+size(data.imdb,2)],...
                [data.mapper(i).correspondance.x1(2,j),data.mapper(i).correspondance.x2(2,j)],'lineWidth',1,'color','g');
            end
            hold off;
        end
    end
end
