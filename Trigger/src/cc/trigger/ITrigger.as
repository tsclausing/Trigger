package cc.trigger
{
import cc.trigger.actions.ICallback;
import cc.trigger.actions.ICommand;

/**
 * The public, global Trigger API.  
 * 
 * Each method is implemented as a global function that is available in your application by simply including the .swc.
 */
public interface ITrigger
{
	//-------------------- TRIGGER --------------------//
	/** Execute any Commands or Callbacks registered to the <code>trigger</code> string and return the value. */
	function trigger(trigger:String, params:Array) :*;
	
	
	//-------------------- CALLBACKS --------------------//
	/** Register a callback with a trigger string.  */
	function addCallback(c:ICallback) :ICallback;
	/** Un-register a callback with a trigger string. */
	function removeCallback(c:ICallback) :ICallback;
	
	/** Register multiple callbacks at a time. */
	function addCallbacks(callbacks:Array) :Array;
	/** Un-register multiple callbacks at a time. */
	function removeCallbacks(callbacks:Array) :Array;
	
	/** Get an existing callback. */
	function getCallback(c:ICallback) :ICallback;
	
	
	//-------------------- COMMANDS --------------------//
	/** Register a command with a trigger string.  */
	function addCommand(c:ICommand) :ICommand;
	/** Un-register a command with a trigger string. */
	function removeCommand(c:ICommand) :ICommand;
	
	/** Register multiple commands at a time. */
	function addCommands(commands:Array) :Array;
	/** Un-register multiple commands at a time. */
	function removeCommands(commands:Array) :Array;
	
	/** Get an existing command. */
	function getCommand(c:ICommand) :ICommand;
	
	/** Gets and Sets the default command method for the application. */
	function get default_command_method() :String;
	function set default_command_method(value:String) :void;
}
}