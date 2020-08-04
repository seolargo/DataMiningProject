%Author: Ömer Faruk Yavuz
%Project for Data Mining Lecture.
%Instructor: Songül Varl?.

clc;
clear all;
close all;

import java.util.ArrayList

%Importing the data
data = readmatrix('mammographic_masses_new4.csv');

%Split the data as train and test
%K-Fold Cross Validation
%Data has been split up into 10 K-Fold Cross Validation, Severity is the
%class attribute.
cv = cvpartition(data(:, 6),'KFold',10);
idxTest = test(cv, 1); %Test indices for cross-validation
idxTraining = training(cv, 10); %Training indices for cross-validation

%Separate to training and test data
dataTrain = data(~idxTraining,:);
dataTest  = data(idxTest,:);

%Max information gain
maxInfo=0;

%Splitting the data into attributes
BIRADS   = data(:, 1);
Age      = data(:, 2);
Shape    = data(:, 3);
Margin   = data(:, 4);
Density  = data(:, 5);
Severity = data(:, 6);

attributeArray=ArrayList;
attributeArray.add('BIRADS');
attributeArray.add('Age');
attributeArray.add('Shape');
attributeArray.add('Margin');
attributeArray.add('Density');
attributeArray.add('Severity');

BIRADSValues=ArrayList;
for i=1:960
    if(BIRADSValues.contains(BIRADS(i)) == 0)
        BIRADSValues.add(BIRADS(i));
    end
end
BIRADSValues;

AgeValues = ArrayList;
for i=1:960
    if(AgeValues.contains(Age(i)) == 0)
        AgeValues.add(Age(i));
    end
end
AgeValues;

ShapeValues = ArrayList;
for i=1:960
    if(ShapeValues.contains(Shape(i)) == 0)
        ShapeValues.add(Shape(i));
    end
end
ShapeValues;

MarginValues = ArrayList;
for i=1:960
    if(MarginValues.contains(Margin(i)) == 0)
        MarginValues.add(Margin(i));
    end
end
MarginValues;

DensityValues = ArrayList;
for i=1:960
    if(DensityValues.contains(Density(i)) == 0)
        DensityValues.add(Density(i));
    end
end
DensityValues;

%Class Label
SeverityValues = ArrayList;
for i=1:960
    if(SeverityValues.contains(Severity(i)) == 0)
        SeverityValues.add(Severity(i));
    end
end
SeverityValues;

%Gain Calculation
yes=0;
no=0;
for i=1:960
    if(Severity(i) == 1)
        yes=yes+1;
    else
        no=no+1;
    end
end
disp("Sinif etiketi için Evet sayisi: " + yes);
disp("Sinif etiketi için Hayir sayisi: " + no);
info = -(yes/(yes+no)*log2(yes/(yes+no))) -(no/(yes+no)*log2(no/(yes+no)));
disp("Info(D)=" + info);

disp("******************************************************************");

disp("BIRADS için evet/hayir oranlari");
countYes=0;
countNo=0;
entropy=0;
totalEntropy=0;
for i=1:BIRADSValues.size()
    tempVal = BIRADSValues.get(i-1);
    countYes=0;
    countNo=0;
    for k=1:960
        if(Severity(k)==1 && tempVal==BIRADS(k))
            countYes=countYes+1;
        elseif(Severity(k)==0 && tempVal==BIRADS(k))
            countNo=countNo+1;
        end
    end
    entropy = ((countYes+countNo) / 960)*(-countYes/(countYes+countNo)*log2(countYes/(countYes+countNo)) -countNo/(countYes+countNo)*log2(countNo/(countYes+countNo)));
    disp("BIRADS="+tempVal+" degeri için");
    disp("Yes: " + countYes);
    disp("No: " + countNo);
    disp("Info_birads(D): " + entropy);
    totalEntropy = totalEntropy + entropy;
end
disp("Information Gain=" + (info-totalEntropy));

if(maxInfo<(info-totalEntropy))
    maxInfo = (info-totalEntropy);
end

disp("*****************************************************************");

disp("Age için evet/hayir oranlari");
countYes=0;
countNo=0;
entropy=0;
totalEntropy=0;
for i=1:AgeValues.size()
    tempVal = AgeValues.get(i-1);
    countYes=0;
    countNo=0;
    for k=1:960
        if(Severity(k)==1 && tempVal==Age(k))
            countYes=countYes+1;
        elseif(Severity(k)==0 && tempVal==Age(k))
            countNo=countNo+1;
        end
    end
    if(countYes ~= 0 && countNo ~= 0)
        entropy = ((countYes+countNo) / 960)*(-countYes/(countYes+countNo)*log2(countYes/(countYes+countNo)) -countNo/(countYes+countNo)*log2(countNo/(countYes+countNo)));
        disp("Yes: " + countYes);
        disp("No: " + countNo);
        disp("Info_age(D): " + entropy);
        totalEntropy = totalEntropy + entropy; 
    end
end
disp("Information Gain=" + (info-totalEntropy));

if(maxInfo<(info-totalEntropy))
    maxInfo = (info-totalEntropy);
end

disp("******************************************************************");

disp("Density için evet/hayir oranlari");
countYes=0;
countNo=0;
entropy=0;
totalEntropy=0;
for i=1:DensityValues.size()
    tempVal = DensityValues.get(i-1);
    countYes=0;
    countNo=0;
    for k=1:960
        if(Severity(k)==1 && tempVal==Density(k))
            countYes=countYes+1;
        elseif(Severity(k)==0 && tempVal==Density(k))
            countNo=countNo+1;
        end
    end
    if(countYes ~= 0 && countNo ~= 0)
        entropy = ((countYes+countNo) / 960)*(-countYes/(countYes+countNo)*log2(countYes/(countYes+countNo)) -countNo/(countYes+countNo)*log2(countNo/(countYes+countNo)));
        disp("Yes: " + countYes);
        disp("No: " + countNo);
        disp("Info_density(D): " + entropy);
        totalEntropy = totalEntropy + entropy; 
    end
end
disp("Information Gain=" + (info-totalEntropy));

if(maxInfo<(info-totalEntropy))
    maxInfo = (info-totalEntropy);
end

disp("******************************************************************");

disp("Margin için evet/hayir oranlari");
countYes=0;
countNo=0;
entropy=0;
totalEntropy=0;
for i=1:MarginValues.size()
    tempVal = MarginValues.get(i-1);
    countYes=0;
    countNo=0;
    for k=1:960
        if(Severity(k)==1 && tempVal==Margin(k))
            countYes=countYes+1;
        elseif(Severity(k)==0 && tempVal==Margin(k))
            countNo=countNo+1;
        end
    end
    if(countYes ~= 0 && countNo ~= 0)
        entropy = ((countYes+countNo) / 960)*(-countYes/(countYes+countNo)*log2(countYes/(countYes+countNo)) -countNo/(countYes+countNo)*log2(countNo/(countYes+countNo)));
        disp("Yes: " + countYes);
        disp("No: " + countNo);
        disp("Info_margin(D): " + entropy);
        totalEntropy = totalEntropy + entropy; 
    end
end
disp("Information Gain=" + (info-totalEntropy));

if(maxInfo<(info-totalEntropy))
    maxInfo = (info-totalEntropy);
end

disp("******************************************************************");

disp("Shape için evet/hayir oranlari");
countYes=0;
countNo=0;
entropy=0;
totalEntropy=0;
for i=1:ShapeValues.size()
    tempVal = ShapeValues.get(i-1);
    countYes=0;
    countNo=0;
    for k=1:960
        if(Severity(k)==1 && tempVal==Shape(k))
            countYes=countYes+1;
        elseif(Severity(k)==0 && tempVal==Shape(k))
            countNo=countNo+1;
        end
    end
    if(countYes ~= 0 && countNo ~= 0)
        entropy = ((countYes+countNo) / 960)*(-countYes/(countYes+countNo)*log2(countYes/(countYes+countNo)) -countNo/(countYes+countNo)*log2(countNo/(countYes+countNo)));
        disp("Yes: " + countYes);
        disp("No: " + countNo);
        disp("Info_shape(D): " + entropy);
        totalEntropy = totalEntropy + entropy; 
    end
end
disp("Information Gain=" + (info-totalEntropy));

if(maxInfo<(info-totalEntropy))
    maxInfo = (info-totalEntropy);
end
disp("******************************************************************");

disp("Maximum information gain=" + maxInfo);
disp("Attribute: BIRADS");

%Root is in the BIRADS.
disp("Root: BIRADS");

count=0;
tempArray = [];
severityTempArray = [];
indis=1;
for j=1:960
   %By changing the value "6",... 
   %you can decide the leaves of the decision tree .
   if(BIRADS(j) == 6)
      disp(data(j, :));
      tempArray(indis, :) = data(j,:);
      severityTempArray(indis) = Severity(j);
      count=count+1;
      indis=indis+1;
   end
end
count;

index=1;
for j=3:5
    isOk=1;
    for i=1:count-1
        for k=i+1:count
            %disp("tempArray("+i+","+j+")=" + tempArray(i,j) + " " + "tempArray("+k+","+j+")=" + tempArray(k,j))
            %disp("severityTempArray("+i+")=" + severityTempArray(i) + " " + "severityTempArray("+k+")=" + severityTempArray(k))
            if(tempArray(i,j) == tempArray(k,j) && severityTempArray(k) ~= severityTempArray(i))
                isOk=0; 
            end
        end
    end
    disp("ok: "+ isOk);
    if(isOk == 1)
        disp("Attribute: " + attributeArray.get(j-1));
        
    end
end

count=0;
indis=1;
for i=1:960
        if(BIRADS(i)==6)
            disp(data(i,:))
            count=count+1;
            
        end
end
count