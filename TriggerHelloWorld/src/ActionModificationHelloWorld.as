package
{
import flash.display.Sprite;

public class ActionModificationHelloWorld extends Sprite
{
	private var command :Object;
	private var callback :Object;
	
	public function ActionModificationHelloWorld()
	{
		var message :String;
		
		//-------------------- Modify Command --------------------//
		command = addCommand("command", MyCommandClass1);
		message = trigger("command");
		
		command.method = "custom";
		message += trigger("command");
		
		command.command = MyCommandClass2;
		command.method = default_command_method;
		message += trigger("command");
		
		trace("Command: " + message);
		
		//-------------------- Modify Callback --------------------//
		callback = addCallback("callback", myCallbackFunction1);
		message = trigger("callback");
		
		callback.method = myCallbackFunction2;
		message += trigger("callback");
		
		trace("Callback: " + message);
	}
	
	
	private function myCallbackFunction1() :String {
		return "Hello ";
	}
	
	private function myCallbackFunction2() :String {
		return "World!";
	}
}
}

class MyCommandClass1 {
	public function execute() :String { return "Hello "; }
	public function custom() :String { return "World"; }
}

class MyCommandClass2 {
	public function execute() :String { return "!"; }
}