function [] = cnn(MaxEpoch)
%CNN 此处显示有关此函数的摘要
%   此处显示详细说明

% clear;clc;
% [XTrain,TTrain] = japaneseVowelsTrainData;
% [XValidation,TValidation] = japaneseVowelsTestData;
load datasheet.mat
classes = categories(TTrain);
numClasses = numel(classes);
% numClasses=5;
numFeatures = size(XTrain{1},1);
filterSize = 3;
numFilters = 32;

layers = [ ...
    sequenceInputLayer(numFeatures)

    convolution1dLayer(filterSize,numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer
    convolution1dLayer(filterSize,2*numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer
    convolution1dLayer(filterSize,3*numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer
     convolution1dLayer(filterSize,numFilters,Padding="causal")
    reluLayer
    layerNormalizationLayer

    globalAveragePooling1dLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

miniBatchSize = 30;

options = trainingOptions("adam", ...
    MiniBatchSize=miniBatchSize, ...
    MaxEpochs=MaxEpoch, ...
    SequencePaddingDirection="left", ...
    ValidationData={XValidation,TValidation}, ...
    Plots="training-progress", ...
    Verbose=0);

net = trainNetwork(XTrain,TTrain,layers,options);

YPred = classify(net,XValidation, ...
    MiniBatchSize=miniBatchSize, ...
    SequencePaddingDirection="left");

acc = mean(YPred == TValidation);
confusionchart(TValidation,YPred);

save net net
end

