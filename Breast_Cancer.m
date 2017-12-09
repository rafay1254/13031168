
B = A(:,2:10);
C = A(:,11);
meanMat = mean(A);
meanValue = round(meanMat(6));
A(A==0)=meanValue;

trainData= B(1:350,:);
testData= B(350:699,:);
trainClass= C(1:350,:);
testClass= C(350:699,:);



net = newff(trainData',trainClass',20, {'tansig' 'tansig'}, 'trainr', 'learngd', 'mse');
net.trainParam.goal = 0.01;
net.trainParam.epochs = 100;
net.trainParam.max_fail = 100;
net. trainParam.lr = 0.02;
view(net);
net = train(net, trainData',trainClass');
output=net(testData');
error=0;
for i=1:size(output,2)
    if((output(i)<3 && testClass(i)~=2)||(output(i)>3 && testClass(i)~=4))
        error=error+1;
    end;
end;
disp('Errors: ')
disp(error)
disp('Accuracy (%)')
percentageAccuracy=((size(testClass)-error)/size(testClass))*100;
disp(percentageAccuracy)