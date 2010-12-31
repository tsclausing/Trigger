package
{
import cc.trigger.Trigger;

	public function removeCommands(...commands) :Array
	{
		return Trigger.INSTANCE.removeCommands(commands);
	}
}