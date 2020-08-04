%K refers to the number of groups
%We have to know the K! Three clusters = (K=3) Since K=3 I have to identify
%three center points for these clusters
%Sometimes we can pick three points arbitrarily from the dataset as the
%center for each clusters. Or it can be a random number also!
%We will use Rectilinear distance

clc;
clear all;
close all;

import java.util.ArrayList

%Importing the data
data = readmatrix('mammographic_masses_new4.csv');

%Split the data as train and test
%Cross validation (train: 90%, test: 10%)
cv = cvpartition(size(data,1),'HoldOut',0.1);
idx = cv.test;

%Separate to training and test data
dataTrain = data(~idx,:);
dataTest  = data(idx,:);

%Splitting the data into attributes
BIRADS   = dataTest(:, 1);
Age      = dataTest(:, 2);
Shape    = dataTest(:, 3);
Margin   = dataTest(:, 4);
Density  = dataTest(:, 5);
Severity = dataTest(:, 6);

%point eklenir
point = zeros(96,6);
point(:,1) = BIRADS;
point(:,2) = Age;
point(:,3) = Shape;
point(:,4) = Margin;
point(:,5) = Density;
point(:,6) = Severity;

%ClusterArray
ClusterArray=zeros(96, 1);
ClusterOldArray=zeros(96, 1);

%K=3 olsun. point-30 point-100 point-150 benim geçici merkezlerim
center1 = point(30,:);
center2 = point(40,:);
center3 = point(50,:);
clusterRepeat1=0;
clusterRepeat2=0;
clusterRepeat3=0;
clusterSum1=0;
clusterSum2=0;
clusterSum3=0;
for i=1:96
    distmean1=point(i,:)-center1;
    sumDistMean1=sum(abs(distmean1));
    distmean2=point(i,:)-center2;
    sumDistMean2=sum(abs(distmean2));
    distmean3=point(i,:)-center3;
    sumDistMean3=sum(abs(distmean3));
    A=min(sumDistMean1, sumDistMean2);
    A=min(A, sumDistMean3);
    %clusterSum1,2,3 represents how many times we have seen 1, 2, or 3.
    if(A == sumDistMean1)
        ClusterOldArray(i)=1;
        clusterRepeat1=clusterRepeat1+1;
        clusterSum1=clusterSum1+point(i,:);
    elseif(A == sumDistMean2)
        ClusterOldArray(i)=2;
        clusterRepeat2=clusterRepeat2+1;
        clusterSum2=clusterSum2+point(i,:);
    elseif(A == sumDistMean3)
        ClusterOldArray(i)=3;
        clusterRepeat3=clusterRepeat3+1;
        clusterSum3=clusterSum3+point(i,:);
    end
end
center1=clusterSum1/clusterRepeat1;
center2=clusterSum2/clusterRepeat2;
center3=clusterSum3/clusterRepeat3;

isChanged=1;
while(isChanged==1)
    isChanged=0;
    for i=1:96
        distmean1=point(i,:)-center1;
        sumDistMean1=sum(abs(distmean1));
        distmean2=point(i,:)-center2;
        sumDistMean2=sum(abs(distmean2));
        distmean3=point(i,:)-center3;
        sumDistMean3=sum(abs(distmean3));
        A=min(sumDistMean1, sumDistMean2);
        A=min(A, sumDistMean3);
        %clusterSum1,2,3 represents how many times we have seen 1, 2, or 3.
        if(A == sumDistMean1)
            ClusterArray(i)=1;
            if(ClusterArray(i)~=ClusterOldArray(i))
                isChanged=1;
                ClusterOldArray(i)=ClusterArray(i);
            end
            clusterRepeat1=clusterRepeat1+1;
            clusterSum1=clusterSum1+point(i,:);
        elseif(A == sumDistMean2)
            ClusterArray(i)=2;
            if(ClusterArray(i)~=ClusterOldArray(i))
                isChanged=1;
                ClusterOldArray(i)=ClusterArray(i);
            end
            clusterRepeat2=clusterRepeat2+1;
            clusterSum2=clusterSum2+point(i,:);
        elseif(A == sumDistMean3)
            ClusterArray(i)=3;
            if(ClusterArray(i)~=ClusterOldArray(i))
                isChanged=1;
                ClusterOldArray(i)=ClusterArray(i);
            end
            clusterRepeat3=clusterRepeat3+1;
            clusterSum3=clusterSum3+point(i,:);
        end
    end
    center1=clusterSum1/clusterRepeat1;
    center2=clusterSum2/clusterRepeat2;
    center3=clusterSum3/clusterRepeat3;
end

center1
center2
center3