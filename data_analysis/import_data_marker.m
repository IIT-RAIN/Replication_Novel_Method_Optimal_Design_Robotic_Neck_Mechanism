function data_marker = import_data_marker(filename, variableNames, dataLines)
%IMPORTFILE Import data from a text file
%  DATA_MARKER = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  DATA_MARKER = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  data_marker = importfile("D:\Documents\GitHub\INAIL\Neck_mockup\code\Matlab\data_analysis\experiments\subject_01\session_01\trial_1\data_marker.csv", [6, 1724]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 25-Oct-2021 10:53:00

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 3
    dataLines = [6, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 119);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
% opts.VariableNames = ["Frame", "Var2", "LFHD_X", "LFHD_Y", "LFHD_Z", "RFHD_X", "RFHD_Y", "RFHD_Z", "LBHD_X", "LBHD_Y", "LBHD_Z", "RBHD_X", "RBHD_Y", "RBHD_Z", "C7_X", "C7_Y", "C7_Z", "T10_X", "T10_Y", "T10_Z", "CLAV_X", "CLAV_Y", "CLAV_Z", "STRN_X", "STRN_Y", "STRN_Z", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119"];
opts.VariableNames = variableNames;
% opts.SelectedVariableNames = ["Frame", "LFHD_X", "LFHD_Y", "LFHD_Z", "RFHD_X", "RFHD_Y", "RFHD_Z", "LBHD_X", "LBHD_Y", "LBHD_Z", "RBHD_X", "RBHD_Y", "RBHD_Z", "C7_X", "C7_Y", "C7_Z", "T10_X", "T10_Y", "T10_Z", "CLAV_X", "CLAV_Y", "CLAV_Z", "STRN_X", "STRN_Y", "STRN_Z"];
opts.SelectedVariableNames = [variableNames(1),variableNames(3:end)];
% opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
opts.VariableTypes = repmat("double",size(variableNames));

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
% opts = setvaropts(opts, ["Var2", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119"], "WhitespaceRule", "preserve");
% opts = setvaropts(opts, ["Var2", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119"], "EmptyFieldRule", "auto");

% Import the data
data_marker = readtable(filename, opts);

% Order variables
desired_order = ["Frame", "LFHD_X", "LFHD_Y", "LFHD_Z", "RFHD_X", "RFHD_Y", "RFHD_Z", "LBHD_X", "LBHD_Y", "LBHD_Z", "RBHD_X", "RBHD_Y", "RBHD_Z", "C7_X", "C7_Y", "C7_Z", "T10_X", "T10_Y", "T10_Z", "CLAV_X", "CLAV_Y", "CLAV_Z", "STRN_X", "STRN_Y", "STRN_Z", "LSHO_X", "LSHO_Y", "LSHO_Z", "RSHO_X", "RSHO_Y", "RSHO_Z"]; 
[~, varOrder] = ismember(data_marker.Properties.VariableNames, desired_order); 
[~, resortOrder] = sort(varOrder); 
data_marker = data_marker(:,resortOrder);

end