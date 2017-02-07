# Config DWT GUI for Eclipse DDT on Windows
## Introduction
**DWT - D Widget Toolkit**
1. DWT is a library for creating cross-platform GUI applications
2. It's a port of the SWT Java library from Eclipse
3. DWT is compatible with D2 using the standard library (Phobos)
## Objectives
 1, Help new D programmers and hobbyists to config DWT for Eclipse DDT on Windows
 2. Make it more fun and enjoyable to learn D with a stable and easy to use gui
 3. Advance the use of the D language
## High-Level Overview
1. Start with Windows 10 Home (or other compatible Windows version)
2. Install the DMD D2 language compiler
3. Install the DUB D2 language package manager
4. Install Eclipse
5. Install the Eclipse DDT plugin
6. Clone the DWT repository from GitHub
7. Build the DWT library on your local PC
8. Create a new DUB project in Eclipse with DDT called "hello-dwt"
9. Edit the dub.json file to link with the DWT library on your local PC
10. Enter the D code for a simple "Hellow World" window using DWT
11. Run hello-dwt. If successful, a simple "Hello World!" window will appear
12. Modify the Build Target for a "release" build version
## Step-by-Step Instructions
1. Start with Windows 10 Home (or other compatible Windows version)
	*test version: 10.0.14393 Build 14393*
2. Install DMD
	Download DMD from [dlang.org](https://www.dlang.org), press `Install.exe`
	*test version: DMD32 D Compiler v2.073.0*
3. Install DUB
	Download DUB from  [dlang.org](https://www.code.dlang.org/download), click `DUB 1.2.0 installer for Windows (X86`)
	*test version: 1.2.0, built on Jan 22 2017*
4. Install Eclipse
	Download from [eclipse.org](https://www.eclipse.org/downloads), click "Get Eclipe Neon", press the orange button `DOWNLOAD 64 BIT`
	This will download the installer: `eclipse-inst-win64.exe`
	Select **"Eclipse IDE for Java Developers"**
	*test version: Neon.2 Release (4.6.2), Build id: 20161208-0600*
5. Install DDT plugin
	In Eclipse: Help, Eclipse Marketplace, Search, Find: DDT, Install
	*test version: D Development Tools 1.0.3.v201611011228*
	Do **not** exit Eclipse
6. Clone the DWT repository from GitHub
	a. Download from [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt), press the green button, `Clone or download`
	*(do not download because it will download the folders only, not everything)*
	b. Copy the git uri to clipboard `https://github.com/d-widget-toolkit/dwt.git`
	c. In Eclispe: File, import, Git, Projects from Git, Clone URI
	d. Paste the git uri for DWT, press Next
	 e. Select the master branch, press Next
	 f. Enter your local directory `E:\DEV\Data\GitHub\dwt`
	g. **CHECK** `Clone submodules`, press Next
	h. Do ***not*** import into the project, press Cancel
7. Build the DWT library on your local PC
>Compare the following with the "Building" instructions at the bottom of  [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt)

	a) Copy the Git clone:
	-- From: your local git repository `E:\DEV\Data\GitHub\dwt`
	-- To: your local lib directory `E:\DEV\Libs\dwt`
	b) Open a command window in your local lib directory:
	```dos
    E:\DEV\Libs\dwt>
    ```
	c) Enter the rdmd build command, then press ENTER to execute:
	```dos
    E:\DEV\Libs\dwt>rdmd build.d base swt
    ```
	d) You should see the following command line output during the short build process:
	```dos
    E:\DEV\Libs\dwt> rdmd build.d base swt
	(in E:\DEV\Libs\dwt)
	Building dwt-base
	workdir=>E:\DEV\Libs\dwt\base\src
	dmd.exe @E:\DEV\Libs\dwt\rsp
	dmd.exe @E:\DEV\Libs\dwt\rsp > E:\DEV\Libs\dwt\olog.txt
	Building org.eclipse.swt.win32.win32.x86
	workdir=>E:\DEV\Libs\dwt\org.eclipse.swt.win32.win32.x86\src
	dmd.exe @E:\DEV\Libs\dwt\rsp
	dmd.exe @E:\DEV\Libs\dwt\rsp > E:\DEV\Libs\dwt\olog.txt
    E:\DEV\Libs\dwt>
	```

	e) Create a simple DUB Project, "Hellow World" 
	Eclipse with DDT: File, New, Other, D, DUB Project, press Next,
	Enter Project name: `hello-dwt`, press Finish
8. Edit the dub.json file to link with the DWT library on your local PC
	a) In the hello-dwt project: Open the `dub.json` file,
	b) Replace the entire contents with the following:
	
	```json
	{
		"name": "hello-dwt",
		"description": "Hello World - A minimal DUB bundle.",
		"dflags": ["-Ie:\\dev\\libs\\dwt\\imp\\",
			"-Je:\\dev\\libs\\dwt\\res\\"],
		"lflags": ["-L+e:\\dev\\libs\\dwt\\lib\\",
			" -L+e:\\dev\\libs\\dwt\\lib\\org.eclipse.swt.win32.win32.x86.lib",
			" -L+e:\\dev\\libs\\dwt\\lib\\dwt-base.lib",
			" /SUBSYSTEM:WINDOWS:4.0"]
	}
	```
	>*edit the above for your local lib path: e:\\dev\\libs\\dwt)*
	*note the required space before the dash in lines 7 and 8 below: " -L+e..."*

9. Enter the D code for a simple "Hellow World" window using DWT
	a) In the `hello-dwt` project:
	b) Open the `app.d` file, and replace the entire contents with the following:
	
	```d
	import org.eclipse.swt.widgets.Display;
	import org.eclipse.swt.widgets.Shell;
	void main ()
	{
		auto display = new Display;
		auto shell = new Shell;
		shell.setText("Hello World!");
		shell.open();
		while (!shell.isDisposed)
			if (!display.readAndDispatch())
				display.sleep();
		display.dispose();
	}
	```
10. Run `hello-dwt`
	a) Eclipse menu: Run, Run As, 1 D Application
	b) If successful, a simple "Hello World!" window will appear.
	
	```
	Hello World!
	```
11. Modify the Build Target for a "release" build version
	a) Eclispe DDT comes with only two Build Targets - default and unittest
	b) The default target builds a "debug" version, and the unittest target builds a "unittest" version
	c) Currently, you cannot create a build rarget "release", so here is a work-around:
	 d) In the `hello-dwt` project: modify the `dub.json` to add `"buildTypes"` as follows:
	 
	```json
	{
	"name": "hello-dwt",
	"description": "Hello World - A minimal DUB bundle.",
	"buildTypes":
	   {
	    "unittest":
	    {
	     "buildOptions": ["releaseMode", "optimize", "inline"]
	    }
	   },
	"dflags": ["-Ie:\\dev\\libs\\dwt\\imp\\", 
		"-Je:\\dev\\libs\\dwt\\res\\"],
	"lflags": ["-L+e:\\dev\\libs\\dwt\\lib\\",
		" -L+e:\\dev\\libs\\dwt\\lib\\org.eclipse.swt.win32.win32.x86.lib",
		" -L+e:\\dev\\libs\\dwt\\lib\\dwt-base.lib",
		" /SUBSYSTEM:WINDOWS:4.0"]
	}
	```
	e) Now, when you use the "unittest" build target, it will actually build a "release" version
	f) If you need the "unittest", simply rename to "unittest-disable" in the dub.json
	g) Here is the impact on the exe size with my Windows environment:
	 - "debug" version of hellow-dwt = 2,580 KB
	 - "release" version of hellow-dwt = 714 KB
	 - After upx --brute compression = 615 KB *(upx not included in this document)*


