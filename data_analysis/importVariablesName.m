function variables_name = importVariablesName(filename, dataLines)
%IMPORTFILE Import data from a text file
%  DATAMARKER = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a string array.
%
%  DATAMARKER = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  datamarker = importfile("D:\Documents\GitHub\INAIL\Neck_mockup\code\Matlab\data_analysis\experiments_2022_11_04\subject_04\session_01\trial_2\data_marker.csv", [3, 3]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 24-Nov-2021 16:56:04

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [3, 3];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 32);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "Sub4LFHD", "VarName4", "VarName5", "Sub4RFHD", "VarName7", "VarName8", "Sub4LBHD", "VarName10", "VarName11", "Sub4RBHD", "VarName13", "VarName14", "Sub4C7", "VarName16", "VarName17", "Sub4T10", "VarName19", "VarName20", "Sub4CLAV", "VarName22", "VarName23", "Sub4STRN", "VarName25", "VarName26", "Sub4LSHO", "VarName28", "VarName29", "Sub4RSHO", "VarName31", "VarName32"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["VarName1", "VarName2", "Sub4LFHD", "VarName4", "VarName5", "Sub4RFHD", "VarName7", "VarName8", "Sub4LBHD", "VarName10", "VarName11", "Sub4RBHD", "VarName13", "VarName14", "Sub4C7", "VarName16", "VarName17", "Sub4T10", "VarName19", "VarName20", "Sub4CLAV", "VarName22", "VarName23", "Sub4STRN", "VarName25", "VarName26", "Sub4LSHO", "VarName28", "VarName29", "Sub4RSHO", "VarName31", "VarName32"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["VarName1", "VarName2", "Sub4LFHD", "VarName4", "VarName5", "Sub4RFHD", "VarName7", "VarName8", "Sub4LBHD", "VarName10", "VarName11", "Sub4RBHD", "VarName13", "VarName14", "Sub4C7", "VarName16", "VarName17", "Sub4T10", "VarName19", "VarName20", "Sub4CLAV", "VarName22", "VarName23", "Sub4STRN", "VarName25", "VarName26", "Sub4LSHO", "VarName28", "VarName29", "Sub4RSHO", "VarName31", "VarName32"], "EmptyFieldRule", "auto");

% Import the data
variables_name = readmatrix(filename, opts);
variables_name(1) = "Frame";
variables_name(2) = "SubFrame";
counter = 1;
axis_name = ['_X';'_Y';'_Z'];
for i=3:length(variables_name)
    if variables_name(i) ~= ""
        counter = 1;
        var_name_char = convertStringsToChars(variables_name(i));
        var_name_char = var_name_char(6:end);
        var_name_char_temp = [var_name_char,axis_name(counter,:)];
        counter = counter+1;
        variables_name(i) = string(var_name_char_temp);
    else
        var_name_char_temp = [var_name_char,axis_name(counter,:)];
        counter = counter+1;
        variables_name(i) = string(var_name_char_temp);
    end
end
end