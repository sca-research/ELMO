instr_num=125;
R2=zeros(instr_num,1000);
%Ftable=zeros(5,instr_num);
Ftable=zeros(125,1000);
for target=1:1:instr_num
  %id=find(opcodes(:,2)==(target-1));
  id=find((opcodes(:,1)-1)*25+(opcodes(:,2)-1)*5+opcodes(:,3)==(target));
  %Traces=fulltraces(id,POI(:,target));
  Traces=fulltraces(id,:);
  input_t{1}=input{1}(id,:);
  input_t{2}=input{2}(id,:);
  input_t{3}=input{3}(id,:);
  [Rsquared,Ftable] = LRA_ModelBuilding(Traces,input_t,result(id,:));
  %[Rsquared,Ftable(:,target)] = LRA_ModelBuilding(Traces,input_t,result(id,:));
  R2(target,:)=Rsquared(:,1)';
  disp(['------Target = ',num2str(target),'--------']);
end
