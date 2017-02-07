#Key Differences Between DWT 32 and 64 bit
##Reference
1. The [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt) on GitHub
2. The `README.markdown` document
3. The `build.d` file

##DWT 32 bit
1. Requires [DMD](https://www.dlang.org) and the [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt)
2. DWT includes the windows libs `dwt\lib\advapi32.lib` etc.
2. The DMD linker links the DWT windows libs to build 32 bit GUI apps
##DWT 64 bit
1. Requires [DMD](https://www.dlang.org) , the [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt), and the Microsoft Visual Studio (MVS) environment
2. DWT removes the windows libs `dwt\lib\advapi32.lib` etc.
2. The MVS linker links the installed Windows 64bit libs to build 64 but GUI apps
```d
/LIBPATH:"C:\Program Files (x86)\Windows Kits\10\\lib\10.0.10586.0\ucrt\x64" 
```
3. The MS VS tools are not required to build the dwt64 lib
4. However, the MS VS linker is required for DMD to use to link 64 bit dwt apps
##Building DWT 64 bit
>Compare the following with the "Building" instructions at the bottom of  [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt)

2. Follow the README.markdown instructions at the [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt) to clone and build the DWT 64 bit library on your local PC.  You do **not** need the MVS environment to build the DWT lib

	```dos
	E:\DEV\Libs\dwt>rdmd build.d base swt
	```
1. Install [DMD](https://www.dlang.org) , the [d-widget-toolkit](https://www.github.com/d-widget-toolkit/dwt), and the Microsoft Visual Studio (MVS) environment (web search for the current download location)

2. Alternatively, instead of the huge MVS environment, you can install the significantly smaller Visual C++ 2015 x64 Native Build Tools, currenlty located [here.](http://landinghub.visualstudio.com/visual-cpp-build-tools) Be sure to read the notes about the compatiablility between this install and the full Visual Studio suite.
3. Launch the `Visual C++ 2015 x64 Native Build Tools Command Prompt` (see instructions from the version you installed)
4. Compile, link, and run your 64 bit DWT GUI app, for example the `hellow-world` app:

	```
	C:\Program Files (x86)\Microsoft Visual C++ Build Tools>

	dmd -release -O hello-world.d -I%DWT%\imp -J%DWT%\res -L/LIBPATH:%DWT%\lib ^
	  "-Lorg.eclipse.swt.win32.win32.x86.lib" "-Ldwt-base.lib" ^
	  -L/SUBSYSTEM:Windows -L/ENTRY:mainCRTStartup -L/RELEASE -m64
	```
##How to check if your app is 32 or 64 bit
1. In Windows, right-click on the exe file you want to check
2. Select “Properties”
3. Click the tab “Compatibility”
4. In the section "Compatibility mode"
5. Check the box under "Run this program in compatibility mode for:"
6. Open the drop-down menu that lists operating systems
7. If the list begins with Vista, then the file is 64-bit
8. If the list begins with Window 95, or includes Windows XP, then the file is 32-bit
9. Press the cancel button to avoid making any changes
