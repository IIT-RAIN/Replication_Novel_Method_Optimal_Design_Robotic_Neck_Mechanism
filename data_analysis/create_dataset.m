function [dataset] = create_dataset(subjects)
%CREATE_DATASET create a dataset containing all the information about the
%experiments performed for the head motion measurements
%   subjects    ->  select the subjects to include in the dataset
%   dataset     ->  structure containing all the data required:
%                   dataset.subject{i}.session{j}.trial{k}.data_frame =
%                   anatomic angles of the head, thorax and neck
%                   dataset.subject{i}.session{j}.trial{k}.data_markers =
%                   position of all the markers located on the head and
%                   thorax
global parentFolder
switch nargin
    case 1
        path = fullfile(parentFolder,'data_analysis\experiments\subject_');
        dataset.subject=cell(size(subjects));
        for i = 1:length(subjects)
            if subjects(i)<10
                path = strcat(path,'0');
            end
            path_sub = strcat(path,num2str(i));
            folderContent = dir(path_sub);
            dirFlags = [folderContent.isdir] & ~strcmp({folderContent.name},'.') & ~strcmp({folderContent.name},'..');
            subfolder_sub = folderContent(dirFlags);            
            dataset.subject{i}.session=cell(size(subfolder_sub));
            for j = 1:length(subfolder_sub)
                path_ses = fullfile(path_sub,subfolder_sub(j).name);
                folderContent = dir(path_ses);
                dirFlags = [folderContent.isdir] & ~strcmp({folderContent.name},'.') & ~strcmp({folderContent.name},'..');
                subfolder_ses = folderContent(dirFlags);
                dataset.subject{i}.session{j}.trial=cell(size(subfolder_ses));
                for k = 1:length(subfolder_ses)
                    path_tri = fullfile(path_ses,subfolder_ses(k).name);
                    path_file = strcat(path_tri,'\data_frame');
                    data_frame = import_data_frame(path_file);
                    path_file = strcat(path_tri,'\data_marker');
                    data_marker = import_data_marker(path_file);
                    dataset.subject{i}.session{j}.trial{k}.data_frame = data_frame;
                    dataset.subject{i}.session{j}.trial{k}.data_marker = data_marker;
                end
            end
        end
    case 0
        path_exp = fullfile(parentFolder,'data_analysis\experiments');
        folderContent = dir(path_exp);
        dirFlags = [folderContent.isdir] & ~strcmp({folderContent.name},'.') & ~strcmp({folderContent.name},'..');
        subfolder_exp = folderContent(dirFlags);
        dataset.subject=cell(size(subfolder_exp));
        for i = 1:length(subfolder_exp)
            path_sub = fullfile(path_exp,subfolder_exp(i).name);
            folderContent = dir(path_sub);
            dirFlags = [folderContent.isdir] & ~strcmp({folderContent.name},'.') & ~strcmp({folderContent.name},'..');
            subfolder_sub = folderContent(dirFlags);
            dataset.subject{i}.session=cell(size(subfolder_sub));
            for j = 1:length(subfolder_sub)
                path_ses = fullfile(path_sub,subfolder_sub(j).name);
                folderContent = dir(path_ses);
                dirFlags = [folderContent.isdir] & ~strcmp({folderContent.name},'.') & ~strcmp({folderContent.name},'..');
                subfolder_ses = folderContent(dirFlags);
                dataset.subject{i}.session{j}.trial=cell(size(subfolder_ses));
                for k = 1:length(subfolder_ses)
                    path_tri = fullfile(path_ses,subfolder_ses(k).name);
                    path_file = strcat(path_tri,'\data_frame');
                    data_frame = import_data_frame(path_file);
                    %import data marker
                    path_file = strcat(path_tri,'\data_marker.csv');
                    variables_name = importVariablesName(path_file);
                    data_marker = import_data_marker(path_file,variables_name);
                    dataset.subject{i}.session{j}.trial{k}.data_frame = data_frame;
                    dataset.subject{i}.session{j}.trial{k}.data_marker = data_marker;
                end
            end
        end
    otherwise
        dataset = cell(0);
        disp('Error: too many inputs');
end

end

