package cc.trigger.actions
{
public interface ICallback extends ITriggerAction
{
	/** The method to invoke when the callback is executed. */
	function get method() :Function;
	function set method(value:Function) :void;
}
}