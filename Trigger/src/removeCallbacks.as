package
{
import cc.trigger.Trigger;

	public function removeCallbacks(...callbacks) :Array
	{
		return Trigger.INSTANCE.removeCallbacks(callbacks);
	}
}