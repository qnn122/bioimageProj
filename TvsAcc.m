a = 1200:5:1300;
Average_Accuracy = zeros(1,length(a));
for i = a
    i
    Average_Accuracy(i) = AccAnalyFunc(i,0,0);
end
stem(Average_Accuracy)