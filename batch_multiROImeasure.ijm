// @File(label = "Input directory", style = "directory") input
// @File(label = "Output directory", style = "directory") output


/******
 * Batch process subfolder (different sections S1- S4) 
 * Run Measure function on individual ROIs (derived from EZ Colocalization)
 * Macro to batch process files to create a new files for images from Yafang that process images in subfolders and maintain structure
 * 
 ******/


//

setBatchMode(true);
processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);

	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(matches(list[i], ".*CH2.*"))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	outputSt = output; //Create variable for unique file naming purposes
	open(input + file);
	roiManager("open", input + "ROIset.zip");
	title = getTitle();
	
	setAutoThreshold("Otsu");
	run("Set Measurements...", "area integrated area_fraction limit display redirect=None decimal=3");
	
	
	
	if (matches(title, ".*CH2.*")) { //GOI in channel 3
	run("Clear Results");	
	selectWindow(title);
	run("Threshold...");

	numROIs = roiManager("Count");
	for(i=0; i<numROIs; i++) {	
		roiManager("select",i);
		run("Measure", "size=0.01-Infinity circularity=0.00-1.00 show=Nothing display summarize");
	};
	
	imageTitleNoExten = replace(title, ".tif", "");
	saveAs("Results", outputSt + File.separator + imageTitleNoExten + "_results.csv");
	roiManager("reset");
	run("Clear Results");
		
	}

}