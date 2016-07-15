clc
close all
clear
folderName ='lab'
opts.fileReader.extension = 'jpg';
opts.fileReader.folderURL='./Data/'

opts.sift.totalKeypoints = 100;
opts.sift.levels=5;
opts.sift.loadKeypoints = false;

opts.plot.descriptor.activate=true;
opts.plot.descriptor.indexRange = [2:2];
opts.plot.descriptor.total=50;

opts.plot.mapper.activate=true;
opts.plot.mapper.indexRange=[2:3];
opts.plot.mapper.totalPoints=20;

mosaic(folderName,opts);