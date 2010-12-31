package
{
import flash.display.Sprite;

public class CallbacksHelloWorld extends Sprite
{
	public function CallbacksHelloWorld()
	{
		addCallback("trigger1", myCallbackFunction1);
		addCallback("trigger2", myCallbackFunction2);
		addCallback("trigger3", myCallbackFunction3);
		addCallback("trigger4", myCallbackFunction4);
		addCallback("trigger5", myCallbackFunction5);
		addCallback("trigger6", myCallbackFunction6);
		addCallbacks(
			{trigger:"trigger multiple", method:myCallbackFunction7},
			{trigger:"trigger multiple", method:myCallbackFunction8},
			{trigger:"trigger multiple", method:myCallbackFunction9}
		);
		
		trigger("trigger1");
		trigger("trigger2", "Hello World 2!");
		trigger("trigger3");
		trigger("trigger4", null);
		trigger("trigger5", "Hello ", "World ", "5!");
		
		// Callbacks can return a value!
		trace(
			trigger("trigger6", "Hello ", "World ", "6!")
		);
		
		// A chain of callbacks can return multiple values!
		var message :String = "";
		for each (var value:String in trigger("trigger multiple"))
			message += value;
		trace(message);
	}
	
	// ZERO ARG
	private function myCallbackFunction1() :void {
		trace("Hello World 1!");
	}
	
	// REQUIRED ARG
	private function myCallbackFunction2(message:String) :void {
		trace(message);
	}
	
	// OPTIONAL ARG
	private function myCallbackFunction3(message:String="Hello World 3!") :void {
		trace(message);
	}
	
	// NULLABLE ARG
	private function myCallbackFunction4(message:String) :void {
		trace(message == null ? "Hello World 4!" : "");
	}
	
	// MULTIPLE or VARIABLE ARG
	private function myCallbackFunction5(...data) :void {
		var value :String = "";
		for each (var message:String in data)
			value += message;
		trace(value);
	}
	
	// RETURN
	private function myCallbackFunction6(...data) :String {
		var value :String = "";
		for each (var message:String in data)
			value += message;
		return value;
	}
	
	// RETURN MULTIPLE VALUES ...
	private function myCallbackFunction7() :String { return "Hello "; }
	private function myCallbackFunction8() :String { return "World "; }
	private function myCallbackFunction9() :String { return "7, 8 and 9! "; }
}
}