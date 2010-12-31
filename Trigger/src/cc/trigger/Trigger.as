package cc.trigger
{
import cc.trigger.actions.*;

import flash.utils.Dictionary;

/**
 * Trigger gets your app up and running instantly with Commands & Callbacks.
 * - No classes to extend.
 * - No files to configure.
 * - No special metadata syntax to learn.
 * - No import statements or framework code in your files (unless you choose to).
 * 
 * Just:
 * 1) Add the .swc to use the global function API.
 * 2) ?
 * 3) Profit!
 */
public class Trigger implements ITrigger
{
	/**
	 * Singleton instance.  Not required - the framework may be used with multiple Trigger instances.
	 */
	public static const INSTANCE :Trigger = new Trigger();
	
	//-------------------- TRIGGER LIST --------------------//
	protected const triggers :Dictionary = new Dictionary();
	
	
	//-------------------- TRIGGER --------------------//
	/** @copy com.triggerframework.ITrigger#trigger */
	public function trigger(trigger:String, params:Array) :*
	{
		// If the trigger string has not been registered, do nothing.
		if (triggers[trigger] == null)
			return;
		
		var actions :Array = triggers[trigger] as Array;
		var returnValues :Array = [];
		
		// Execute
		for each (var action:ITriggerAction in actions)
		{
			returnValues.push( action.execute(params) );
		}
		
		// Return value(s)
		switch (returnValues.length) {
			case 0: return null;
			case 1: return returnValues[0];
			default: return returnValues;
		}
	}
	
	
	//-------------------- CALLBACK API --------------------//
	/** @copy com.triggerframework.ITrigger#addCallback */
	public function addCallback(c:ICallback) :ICallback { return add(c) as ICallback; }
	
	/** @copy com.triggerframework.ITrigger#removeCallback */
	public function removeCallback(c:ICallback) :ICallback { return remove(c) as ICallback; }
	
	/** @copy com.triggerframework.ITrigger#addCallbacks */
	public function addCallbacks(callbacks:Array) :Array { return addMultiple(callbacks, Callback.newFromObject); }
	
	/** @copy com.triggerframework.ITrigger#removeCallbacks */
	public function removeCallbacks(callbacks:Array) :Array { return removeMultiple(callbacks, Callback.newFromObject); }
	
	/** @copy com.triggerframework.ITrigger#getCallback */
	public function getCallback(c:ICallback) :ICallback { return retrieve(c) as ICallback; }
	
	
	//-------------------- COMMAND API --------------------//
	/** @copy com.triggerframework.ITrigger#addCommand */
	public function addCommand(c:ICommand) :ICommand { return add(c) as ICommand; }
	
	/** @copy com.triggerframework.ITrigger#removeCommand */
	public function removeCommand(c:ICommand) :ICommand { return remove(c) as ICommand; }
	
	/** @copy com.triggerframework.ITrigger#addCommands */
	public function addCommands(commands:Array) :Array { return addMultiple(commands, Command.newFromObject); }
	
	/** @copy com.triggerframework.ITrigger#removeCommands */
	public function removeCommands(commands:Array) :Array { return removeMultiple(commands, Command.newFromObject); }
	
	/** @copy com.triggerframework.ITrigger#getCommand */
	public function getCommand(c:ICommand) :ICommand { return retrieve(c) as ICommand; }
	
	private static var _default_command_method :String = "execute";
	/** @copy com.triggerframework.ITrigger#default_command_method */
	public function get default_command_method() :String { return _default_command_method; }
	public function set default_command_method(value:String) :void { _default_command_method = value; }
	
	
	//-------------------- PROTECTED FUNCTIONS --------------------//
	protected function add(a:ITriggerAction) :ITriggerAction
	{
		if (triggers[a.trigger] != null) 
		{
			var list :Array = triggers[a.trigger] as Array;
			for each (var item:ITriggerAction in list)
			{
				if (item.equals(a))
					// Already exists
					return item;
			}
			// Add to list
			list.push(a);
		}
		else
			// Create new list and add
			triggers[a.trigger] = [a];
		
		return a;
	}
	
	protected function addMultiple(items:Array, newFromObject:Function) :Array
	{
		var returnValue :Array = [];
		
		for each (var object:Object in items) 
		{
			if (object is ITriggerAction)
				returnValue.push( add(object as ITriggerAction) );
			else
			{
				returnValue.push( add(newFromObject(object)) );
			}
		}
		return returnValue;
	}
	
	protected function remove(a:ITriggerAction) :ITriggerAction
	{
		var list :Array = [];
		if (triggers[a.trigger] != null) list = triggers[a.trigger] as Array;
		
		for each (var action:ITriggerAction in list)
		{
			if (action.equals(a))
			{
				var value :ITriggerAction = list.splice(list.indexOf(action), 1)[0] as ITriggerAction;
				
				// clean up the dictionary
				if (list.length == 0)
					delete triggers[a.trigger];
				
				return value
			}
		}
		
		return null;
	}
	
	protected function removeMultiple(items:Array, newFromObject:Function) :Array
	{
		var value :ITriggerAction;
		var returnValue :Array = [];
		
		for each (var object:Object in items) 
		{
			if (object is ITriggerAction)
				value = remove(object as ITriggerAction);
			else
			{
				value = remove(newFromObject(object));
			}
			if (value)
				returnValue.push(value);
		}
		return returnValue;
	}
	
	protected function retrieve(a:ITriggerAction) :ITriggerAction
	{
		var list :Array = [];
		if (triggers[a.trigger] != null) list = triggers[a.trigger] as Array;
		
		for each (var object:Object in list)
		{
			if ((object as ITriggerAction).equals(a))
				return object as ITriggerAction;
		}
		return null;
	}
	
}
}