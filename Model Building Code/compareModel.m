function testPairs = compareModel(testPairs,modelList,modelA,modelB,description)

getLoc = [find(strcmpi(modelList(:,2),modelA)),find(strcmpi(modelList(:,2),modelB))];

testPairs(end+1,:) = {modelA,modelB,description,getLoc};