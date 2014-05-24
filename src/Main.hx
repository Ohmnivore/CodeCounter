package ;

import haxe.io.Output;
import haxe.io.Path;
import neko.Lib;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileSeek;

/**
 * ...
 * @author Ohmnivore
 */

class Main 
{
	static var args:Array<String>;
	static var count:Int = 0;
	
	static function main():Void
	{
		args = Sys.args();
		
		if (args[0] == null || args[0] == "help")
		{
			Lib.println("Usage: CodeCounter.exe [Path] [File extension]");
			Lib.println("Example: CodeCounter.exe C:\\Users\\Ohmnivore\\Desktop\\HAXEDEV hx");
		}
		
		else
		{
			scanDirectory(args[0]);
			
			Lib.println('Total lines of code: $count');
		}
	}
	
	static function scanDirectory(P:String):Void
	{
		P = Path.normalize(P);
		
		var files:Array<String> = [];
		
		try
		{
			files = FileSystem.readDirectory(P);
		}
		
		catch(e:Dynamic)
		{
			Lib.println(e);
			
			return;
		}
		
		Lib.println('Counting directory $P');
		
		for (f in files)
		{
			if (f.substring(f.lastIndexOf(".") + 1, f.length) == args[1] && f.lastIndexOf(".") != -1)
			{
				scanFile(Path.join([P, f]));
			}
			
			else
			{
				if(FileSystem.isDirectory(Path.join([P, f])))
					scanDirectory(Path.join([P, f]));
			}
		}
	}
	
	static function scanFile(P:String):Void
	{
		var cont:String = "";
		
		try
		{
			cont = File.getContent(P);
		}
		
		catch(e:Dynamic)
		{
			Lib.println(e);
			
			return;
		}
		
		var lines:Array<String> = [];
		var system:String = Sys.systemName();
		
		switch(system)
		{
			//case "Windows":
				//lines = cont.split("\n");
			default:
				lines = cont.split("\n");
		}
		
		for (l in lines)
		{
			if (l.length > 3)
			{
				count++;
			}
		}
	}
	
}