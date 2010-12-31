package
{
import flash.display.Sprite;

public class CommandsHelloWorld extends Sprite
{
	public function CommandsHelloWorld()
	{
		addCommand("trigger1", MyCommandClass1);
		addCommand("trigger1", MyCommandClass1, "custom");
		addCommand("trigger2", MyCommandClass2);
		addCommand("trigger2", MyCommandClass2, "custom");
		addCommand("trigger3", MyCommandClass3);
		addCommand("trigger3", MyCommandClass3, "custom");
		addCommand("trigger4", MyCommandClass4);
		addCommand("trigger4", MyCommandClass4, "custom");
		addCommand("trigger5", MyCommandClass5);
		addCommand("trigger5", MyCommandClass5, "custom");
		addCommand("trigger6", MyCommandClass6);
		addCommands(
			{trigger:"trigger multiple", command:MyCommandClass7},
			{trigger:"trigger multiple", command:MyCommandClass8},
			{trigger:"trigger multiple", command:MyCommandClass8, method:"custom"}
		);
		
		trigger("trigger1");
		trigger("trigger2", "Hello World 2!");
		trigger("trigger3");
		trigger("trigger4", null);
		trigger("trigger5", "Hello ", "World ", "5!");
		
		// Commands can return a value!
		trace(
			trigger("trigger6", "Hello ", "World ", "6!")
		);
		
		// A chain of commands can return multiple values!
		var message :String = "";
		for each (var value:String in trigger("trigger multiple"))
			message += value;
		trace(message);
	}
}
}

// ZERO ARG
class MyCommandClass1 {
	public function execute() :void { trace("Hello World 1!"); }
	public function custom() :void { trace("Hello World 1! #custom"); }
}

// REQUIRED ARG
class MyCommandClass2 {
	public function execute(message:String) :void { trace(message); }
	public function custom(message:String) :void { trace(message + " #custom"); }
}

// OPTIONAL ARG
class MyCommandClass3 {
	public function execute(message:String="Hello World 3!") :void { trace(message); }
	public function custom(message:String="Hello World 3! #custom") :void { trace(message); }
}

// NULLABLE ARG
class MyCommandClass4 {
	public function execute(message:String) :void { trace(message == null ? "Hello World 4!" : ""); }
	public function custom(message:String) :void { trace(message == null ? "Hello World 4! #custom" : ""); }
}

// MULTIPLE or VARIABLE ARG
class MyCommandClass5 {
	public function execute(...data) :void { 
		var value :String = "";
		for each (var message:String in data)
			value += message;
		trace(value); 
	}
	public function custom(...data) :void {
		data.push(" #custom")
		var value :String = "";
		for each (var message:String in data)
			value += message;
		trace(value); 
	}
}

// RETURN
class MyCommandClass6 {
	public function execute(...data) :String { 
		var value :String = "";
		for each (var message:String in data)
			value += message;
		return value;
	}
}

// RETURN MULTIPLE VALUES ...
class MyCommandClass7 { 
	public function execute() :String { return "Hello "; } 
}
class MyCommandClass8 { 
	public function execute() :String { return "World "; } 
	public function custom() :String { return "7, 8 and 8 #custom!"; }
}
