package
{
import cc.trigger.Trigger;
import cc.trigger.actions.Callback;
import cc.trigger.actions.ICallback;

	public function removeCallback(trigger:String, method:Function) :ICallback
	{
		return Trigger.INSTANCE.removeCallback(new Callback(trigger, method));
	}
}