package
{
import cc.trigger.Trigger;

	public function trigger(trigger:String, ...params) :*
	{
		return Trigger.INSTANCE.trigger(trigger, params);
	}
}