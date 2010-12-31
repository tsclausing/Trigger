package cc.trigger.actions
{
public interface ICommand extends ITriggerAction
{
	/** The class to instantiate when the command is executed. */
	function get command() :Class;
	function set command(value:Class) :void;
	
	/** The command method to invoke when the command is executed. */
	function get method() :String;
	function set method(value:String) :void;
}
}