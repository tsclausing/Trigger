package cc.trigger.actions
{
public class Command implements ICommand
{
	protected var _trigger :String;
	protected var _command :Class;
	protected var _method :String;
	
	public function Command(trigger:String, command:Class, method:String=null)
	{
		_trigger = trigger;
		_command = command;
		_method = method ? method : default_command_method;
	}
	
	
	//-------------------- ICommand --------------------//
	public function get command() :Class { return _command; }
	public function set command(value:Class) :void { _command = value; }
	
	public function get method() :String { return _method; }
	public function set method(value:String) :void { _method = value ? value : default_command_method; }
	
	
	//-------------------- ITriggerAction --------------------//
	public function get trigger() :String { return _trigger; }
	
	public function execute(params:Array) :*
	{
		var instance :Object = new command();
		return (instance[method] as Function).apply(null, params);
	}
	
	public function equals(o:Object) :Boolean
	{
		// Compare w/ like type
		if (o is ICommand)
			if ((o as ICommand).trigger == trigger &&
				(o as ICommand).command == command &&
				(o as ICommand).method == method)
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
			o.hasOwnProperty("command") && o.command == command)
			if (o.hasOwnProperty("method") && _method == o.method)
				return true;
			else
			if (!o.hasOwnProperty("method") && _method == default_command_method)
				return true;
		
		return false;
	}
	
	public static function newFromObject(o:Object) :ITriggerAction
	{
		return new Command(o.trigger, o.command, o.method);
	}
	
}
}