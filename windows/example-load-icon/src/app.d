/*
 * Copyright (C) 2017 by jasc2v8 at yahoo dot com
 * License: http://www.boost.org/LICENSE_1_0.txt
 *
 * Example of how to load an icon from;
 * 1. A file "icon.ico" 
 * 2. A Program extension from the Windows registry, e.g. "*.inf"
 * 3. A linked resource from the exe itsself
 *
/*

module loadicon;

//TODO: START WITH EXE ICON!, add 2nd row just for learning

//d lang imports
import std.stdio;			//writeln
import std.conv;			//to!string

//dwt imports
import org.eclipse.swt.all;
//import java.lang.all;

//Win32 imports
import org.eclipse.swt.internal.win32.OS;
import org.eclipse.swt.internal.C;
import org.eclipse.swt.internal.Library;

Image image;

Display display;
Shell shell;
Text text;
Button cancel;

int count;

void main () {

	buildShell();
	shell.setBackground(display.getSystemColor(SWT.COLOR_BLACK));
    setIconFromResource(r"load-icon.exe", 0);
    shell.setText("<-- Icon from linked resource.res index 0 (the exe icon)");
    shell.open ();
	    
    while (!shell.isDisposed ()) {
        if (!display.readAndDispatch ()) display.sleep ();
    }
    display.dispose ();
}

void setIconFromFile() {
	imageDispose(image);
	image = new Image(display, r"res\iconD.ico");
    shell.setImage (image);
}

void setIconFromProgram() {
	//load an icon asscociated with a program that is in the windows registry
	imageDispose(image);
	Program p = Program.findProgram (".inf");
    if (p !is null) {
        ImageData imageData = p.getImageData ();
        if (imageData !is null) {
            image = new Image (display, imageData);
            shell.setImage (image);
        }
    }
}

void setIconFromResource(string filename, int index) {
	//load an embeded resource icon from a file
	//designed to set the shell icon from this exe that has an embedded icon
 	imageDispose(image);
    int nIconIndex = index;
    int nIcons=1;
    StringT lpszFile = StrToTCHARs (0, filename, true);
    HICON [1] phiconSmall, phiconLarge;
    OS.ExtractIconEx (lpszFile.ptr, nIconIndex, phiconLarge.ptr, phiconSmall.ptr, nIcons);    
    image = Image.win32_new (null, SWT.ICON, phiconSmall [0]);  
    shell.setImage (image);
}

void doOK() {
	count++;	
	switch (count)
	{
	    default:
		    count = 1;
	        goto case;
        case 1:
            setIconFromResource(r"load-icon.exe", 1);
            shell.setText("<-- Icon from linked resource.res index 1");
            break;
        case 2:
            setIconFromResource(r"load-icon.exe", 2);
            shell.setText("<-- Icon from linked resource.res index 2");
            break;
        case 3:
            setIconFromResource(r"load-icon.exe", 3);
            shell.setText("<-- Icon from linked resource.res index 3");
            break;
        case 4:
            setIconFromResource(r"load-icon.exe", 4);
            shell.setText("<-- Icon from linked resource.res index 4");
            break;
	    case 5:
            setIconFromFile();
            shell.setText("<-- Icon from external iconD.ico file");
		    break;
        case 6:
		    setIconFromProgram();
            shell.setText("<-- Icon from Program '.inf' file association");
            break;
        case 7:
            setIconFromResource(r"load-icon.exe", 0);
            shell.setText("<-- Icon from linked resource.res index 0 (the exe icon)");
            break;
	}
}

void buildShell() {
	
 	display = new Display ();
    shell = new Shell (display);
    
    RowLayout rowLayout = new RowLayout();
    shell.setLayout(rowLayout);
    
    Label label = new Label(shell, SWT.BORDER);
    label.setText("Press the OK button several times to change the window icon");
    label.setLayoutData(new RowData(400, 35));
    
    Button ok = new Button (shell, SWT.PUSH);
    ok.setLayoutData(new RowData(50, 40));
    ok.setText ("OK");
    ok.addSelectionListener(new class SelectionAdapter {
        override
        public void widgetSelected(SelectionEvent e) {
           	doOK();

        }
    });
    cancel = new Button (shell, SWT.PUSH);
    cancel.setLayoutData(new RowData(50, 40));
    cancel.setText ("Cancel");
    cancel.addSelectionListener(new class SelectionAdapter {
        override
        public void widgetSelected(SelectionEvent e) {
		imageDispose(image);
            display.close();
        }
    });

   	shell.pack ();
	shell.setLocation(400, 400);
}

void imageDispose(Image sourceImage) {
    if (sourceImage !is null && !sourceImage.isDisposed()) {
	    sourceImage.dispose();
        sourceImage = null;
    }
}
