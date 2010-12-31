package
{
import cc.trigger.Trigger;
import cc.trigger.actions.Command;
import cc.trigger.actions.ICommand;

	public function addCommand(trigger:String, command:Class, method:String=null) :ICommand
	{
		return Trigger.INSTANCE.addCommand(new Command(trigger, command, method));
	}
}