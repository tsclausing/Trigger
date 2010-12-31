package
{
import cc.trigger.Trigger;
import cc.trigger.actions.Callback;
import cc.trigger.actions.ICallback;

	public function addCallback(trigger:String, method:Function) :ICallback
	{
		return Trigger.INSTANCE.addCallback(new Callback(trigger, method));
	}
}