package cc.trigger.actions
{
import cc.trigger.Trigger;

public class Callback implements ICallback
{
	protected var _trigger :String;
	protected var _method :Function;
	
	public function Callback(trigger:String, method:Function)
	{
		_trigger = trigger;
		_method = method;
	}
	
	
	//-------------------- ICallback --------------------//
	public function get method() :Function { return _method; }
	public function set method(value:Function) :void { _method = value; }
	
	
	//-------------------- ITriggerAction --------------------//
	public function get trigger() :String { return _trigger; }
	
	public function execute(params:Array) :*
	{
		return _method.apply(null, params);
	}
	
	public function equals(o:Object) :Boolean
	{
		// Compare w/ like type
		if (o is ICallback)
			if ((o as ICallback).trigger == trigger &&
				(o as ICallback).method == method)
				return true;
			else
				return false;
		
		// Compare w/ other action types
		else
		if (o is ITriggerAction)
			return false
		
		// Compare w/ generic object
		else
		if (o.hasOwnProperty("trigger") && o.trigger == trigger &&
			o.hasOwnProperty("method") && o.method == method)
			return true
		
		return false;
	}
	
	public static function newFromObject(o:Object) :ITriggerAction
	{
		return new Callback(o.trigger, o.method);
	}
	
}
}