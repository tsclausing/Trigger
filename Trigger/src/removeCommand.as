package
{
import cc.trigger.Trigger;
import cc.trigger.actions.Command;
import cc.trigger.actions.ICommand;

	public function removeCommand(trigger:String, command:Class, method:String=null) :ICommand
	{
		return Trigger.INSTANCE.removeCommand(new Command(trigger, command, method));
	}
}