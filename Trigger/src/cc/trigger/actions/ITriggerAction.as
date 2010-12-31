package cc.trigger.actions
{
/**
 * Trigger contains two built-in actions: Commands & Callbacks.  Every action that 
 * the framework operates on must implement ITriggerAction.
 * 
 * @see com.triggerframework.actions.Command
 * @see com.triggerframework.actions.Callback
 */
public interface ITriggerAction
{
	/** The trigger string used to execute this action. */
	function get trigger() :String;
	
	/** Executes the action when the trigger string is passed to trigger(). */
	function execute(params:Array) :*;
	
	/** Returns true if the input is logically identical to this instance. */
	function equals(o:Object) :Boolean;
}
}