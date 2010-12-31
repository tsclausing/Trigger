package
{
import cc.trigger.Trigger;

	public function addCallbacks(...callbacks) :Array
	{
		return Trigger.INSTANCE.addCallbacks(callbacks);
	}
}