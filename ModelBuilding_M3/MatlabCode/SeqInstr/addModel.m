function modelList = addModel(modelList,Xcols,modelTerms,drop,modelName)

if isempty(drop)
    modelList(end+1,:) = {cell2mat(Xcols(ismember(Xcols(:,1),modelTerms),3)'),modelName};
else
    modelList(end+1,:) = {setdiff(cell2mat(Xcols(ismember(Xcols(:,1),modelTerms),3)'),...
        cell2mat(Xcols(ismember(Xcols(:,1),drop),3)')),modelName};
end