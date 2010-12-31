package
{
import flash.display.Sprite;

import org.flexunit.internals.TraceListener;
import org.flexunit.runner.FlexUnitCore;

import suites.*;

public class TriggerUnitTtests extends Sprite
{
	private var core :FlexUnitCore;
	
	public function TriggerUnitTtests()
	{
		core = new FlexUnitCore();
		core.addListener(new TraceListener());
		
		core.run(TriggerSuite);
	}
}
}