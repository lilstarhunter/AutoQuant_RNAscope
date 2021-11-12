// @File(label = "Input directory", style = "directory") input
// @File(label = "Output directory", style = "directory") output
// @String(label = "File suffix", value = ".tif") suffix

/*******
 * Macro to batch process files to create a new files for images from 10x Genomics NAc Morphine Experiment
 * Pre-process images in subfolders and maintain structure
 ******/


var outputDir; // global variable to be passed to function later
var inputDir; 
outputDir = File.getName(output); // retrieves the folder name string of the master input folder selected by the user above
inputDir = File.getName(input);

setBatchMode(true);
processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	open(input + file);
	title = getTitle();
	selectWindow(title);

	if (matches(title, ".*CH1.*")) {
		run("8-bit");
		setOption("BlackBackground", false);
		run("Convert to Mask");
		run("Dilate");
		run("Fill Holes");
		run("Watershed");
	}
	else {
		run("8-bit");
	}

	saveDir = replace(input, inputDir, outputDir); // replaces the input folder name (string) with the output folder name (string)
	saveDir = replace(saveDir, "//", "/");
	File.makeDirectory(saveDir); // makes the above directory
	saveAs("TIFF", saveDir + file);

}