/*
* Writes each Snippet module name and description to a text file
*/

module SnippetsIndexer;

import std.stdio;
import std.algorithm : sort;  // or import std.algorithm.sorting;
import std.array;
import std.conv;  //to!string
import std.file;
import std.path;
import std.process;
import std.range;
import std.string;
import core.stdc.stdlib; //exit

//global variables
string[] buffer;
int count = 0;	//count number of files processed
const string INDEX_FILE = "snippets-index.txt";

//start
void main()
{
	
	// if snippets subdirectory does not exist, then exit
	if (!exists("snippets")) {
		writeln("snippets subdirecotry does NOT exist, exiting...");
		exit(0);
	}
	
	//get a list of all *.d files in .\snippets
	auto dFiles = dirEntries("snippets", "*.d", SpanMode.shallow);
	
	// process one at a time
	foreach (file; dFiles) {
	    //writeln(file.name);
	    ProcessFile(file.name);
	}

	//inform how many snippets found
    writeln(to!string(count) ~ " Snippets indexed to " ~ INDEX_FILE);

	//just for fun
	auto pid = spawnProcess(["notepad", INDEX_FILE]);
}

void ProcessFile(string filename)
{
	//open file
	auto snippet = File(filename, "r");
	
	//loop through file
	int index;
	string line, module_name, module_description;
	while ((line = snippet.readln()) !is null)
	{
            //find the module name
            index = indexOf(line, "module");
            if (index != -1)
            {
	       		int dot = lastIndexOf(line,".");
				if (dot == -1) {
		        	module_name = line[dot+8..$];
            	} else {
		        	module_name = line[dot+1..$];
            	}

				//now find the description	        	
	        	int i = 0;
				while (i < 20)
				{
					line = snippet.readln();
					index = indexOf(line, " * ");
				    if (index != -1)
				    {
						if (index == 1){
							module_description = line[index+3..$];
						} else {
							module_description = line[index+2..$];
						}
						break;
				    }
				    i++;
				}
				string tmp = FixNumber(chop(module_name)) ~ chop(module_description);
				buffer ~= tmp;
				count++;
				break;
            }
    }
   	
	//close the file
	snippet.close();
	
	//sort the index
	sort(buffer);
	
	//if the index file exists, rename to .bak
	if (exists(INDEX_FILE)) {
		try
	    {
	        rename(INDEX_FILE, baseName(INDEX_FILE, ".txt")  ~ ".bak");
	    }
	    catch (FileException ex)
	    {
	        writeln("Error renaming " ~ INDEX_FILE);
	    }
	}
	
	//wite the buffer to the index file
	try
    {
    	auto file = File(INDEX_FILE, "w");
    	
    	//write the header
    	
    	file.writeln("Item, Snippet Number, Description");
    	file.writeln("=================================");
    	
		foreach (int i, string l; buffer)
		{
	        file.writeln(l);
	    }
    }
    catch (FileException ex)
    {
        writeln("Error writing to " ~ INDEX_FILE);
    }
    
 }
private string FixNumber(string line) {
	
	//find the first number	
	int i = 0;
	while (!isNumeric(line[i..i+1])) {
		i++;
	}

	//pad with leading zeros
	string numb = "000" ~ line[i..$-1];

	//keep the last 3 digits
	numb = numb[$-3..$];

	//pad count with leading zeros
	string c = "000" ~ to!string(count+1);
	
	//keep the last 3 digits
	c = c[$-3..$];	
	
	return c ~ " " ~ numb;
	
}