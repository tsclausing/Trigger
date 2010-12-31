package
{
import cc.trigger.Trigger;

	public function addCommands(...commands) :Array
	{
		return Trigger.INSTANCE.addCommands(commands);
	}
}