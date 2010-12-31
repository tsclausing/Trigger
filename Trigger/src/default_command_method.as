package
{
import cc.trigger.Trigger;

	public function get default_command_method() :String { return Trigger.INSTANCE.default_command_method; }
	public function set default_command_method(value:String) :void { if (value) Trigger.INSTANCE.default_command_method = value; }
}