package
{
import cc.trigger.Trigger;
import cc.trigger.actions.Callback;
import cc.trigger.actions.ICallback;

	public function getCallback(trigger:String, method:Function) :ICallback
	{
		return Trigger.INSTANCE.getCallback(new Callback(trigger, method));
	}
}