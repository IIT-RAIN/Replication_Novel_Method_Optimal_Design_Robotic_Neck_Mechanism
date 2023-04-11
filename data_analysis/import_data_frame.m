function data_frame = import_data_frame(filename, dataLines)
%IMPORTFILE Import data from a text file
%  DATAFRAME = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  DATAFRAME = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  dataframe = importfile("D:\Documents\GitHub\INAIL\Neck_mockup\code\Matlab\data_analysis\experiments\subject_01\session_01\trial_1\data_frame.csv", [6, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 28-Oct-2021 17:52:01

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [6, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 11);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Frame", "Var2", "LHeadAngle_X", "LHeadAngle_Y", "LHeadAngle_Z", "NeckAngle_X", "NeckAngle_Y", "NeckAngle_Z", "ThorsoAngle_X", "ThorsoAngle_Y", "ThorsoAngle_Z"];
opts.SelectedVariableNames = ["Frame", "LHeadAngle_X", "LHeadAngle_Y", "LHeadAngle_Z", "NeckAngle_X", "NeckAngle_Y", "NeckAngle_Z", "ThorsoAngle_X", "ThorsoAngle_Y", "ThorsoAngle_Z"];
opts.VariableTypes = ["double", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var2", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var2", "EmptyFieldRule", "auto");

% Import the data
data_frame = readtable(filename, opts);

end