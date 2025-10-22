

% New Battery
% Auth: Rares Stanciu,
% https://www.mathworks.com/help/simscape-battery/ug/build-battery-module.html

clear all;
close all;

% create a geometry
cylindGeometry = batteryCylindricalGeometry(simscape.Value(0.07, "m"), simscape.Value(0.01, "m"));

% create a battery cell with this geometry
foundationCell = batteryCell();

% link the geometry object to the battery cell
foundationCell.Geometry = cylindGeometry;


% specify the mass property
foundationCell.Mass = simscape.Value(0.8, "kg");

% display the cell
disp(foundationCell)

% visualize the battery cell
f = figure("Color", "white");
cellChart = batteryChart(f, foundationCell);
title(cellChart, "Cylindrical Cell");

% create a thermal port
foundationCell.CellModelOptions.BlockParameters.thermal_port = "model";



% Create a parallel assembly 
parallelAssembly = batteryParallelAssembly(foundationCell, 8, Rows = 4, ...
    Topology = "Square", ModelResolution = "Detailed")


% display the parallel assembly
disp(parallelAssembly)

% visualize the battery cell
f = figure("Color", "white");
parallelAssemblyChart = batteryChart(f, parallelAssembly);
title(parallelAssemblyChart, "Parallel Assembly");



% Create a module 
module = batteryModule(parallelAssembly,...
    10, ...
    InterParallelAssemblyGap=simscape.Value(0.01,"m"), ...
    ModelResolution="Detailed", ...
    AmbientThermalPath="CellBasedThermalResistance")


% display the module
disp(module)

% visualize the battery cell
f = figure("Color", "white");
parallelModuleChart = batteryChart(f, module);
title(parallelModuleChart, "Module");


% Build the battery
buildBattery(module, LibraryName = "newBattery")