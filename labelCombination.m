function labelCombination()
% Labels the combination M/F day/night
%-------------------------------------------------------------------------------

theFile = 'HCTSA.mat';
[~,TimeSeries,~,theFile] = TS_LoadData(theFile);
sexGroups = TS_LabelGroups({'M','F'},theFile,0); % Male (1), Female (2)
dayGroups = TS_LabelGroups({'day','night'},theFile,0); % day (1), night(2)

% First append/overwrite group names
groupNames = {'MaleDay','MaleNight','FemaleDay','FemaleNight'}';

groupLabels = cell(4,1);
groupLabels{1} = find(sexGroups==1 & dayGroups==1);
groupLabels{2} = find(sexGroups==1 & dayGroups==2);
groupLabels{3} = find(sexGroups==2 & dayGroups==1);
groupLabels{4} = find(sexGroups==2 & dayGroups==2);

% Make a cell version of group indices (to use cell2struct)
theGroupsCell = cell(1,length(TimeSeries));
for i = 1:length(theGroupsCell)
    theGroupsCell{i} = find(cellfun(@(x)ismember(i,x),groupLabels));
end

LabelBy(theGroupsCell,groupNames,TimeSeries,theFile);

end
