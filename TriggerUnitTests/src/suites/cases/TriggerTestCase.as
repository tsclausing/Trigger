package suites.cases
{
import cc.trigger.Trigger;
import cc.trigger.actions.Callback;
import cc.trigger.actions.Command;
import cc.trigger.actions.ICallback;
import cc.trigger.actions.ICommand;

import org.flexunit.assertThat;
import org.flexunit.asserts.*;

public class TriggerTestCase
{
	[AfterClass]
	public static function afterClass() :void
	{
		var t :Trigger = Trigger.INSTANCE;
	}
	
	//-------------------- CALLBACKS --------------------//
	[Test]  
	public function testAddGetRemoveCallback():void 
	{ 
		// ADD
		var v1 :ICallback = addCallback("testAddGetRemoveCallback", function():void{});
		assertTrue(v1 is ICallback);
		
		// GET
		var v2 :ICallback = getCallback(v1.trigger, v1.method);
		assertTrue(v1 == v2);
		
		// REMOVE
		var v3 :ICallback = removeCallback(v1.trigger, v1.method);
		assertTrue(v1 == v3);
		
		// GET null
		var v4 :ICallback = getCallback(v1.trigger, v1.method);
		assertTrue(v4 == null);
	}
	
	[Test]  
	public function testAddGetRemoveCallbacks():void 
	{ 
		function f():void{}
		
		// ADDs
		var v1 :Array = addCallbacks(
			{trigger:"testAddGetRemoveCallbacks1", method:f},
			new Callback("testAddGetRemoveCallbacks2", f)
		);
		assertTrue(v1 != null);
		assertTrue(v1.length == 2);
		assertTrue(v1[0] is ICallback && v1[1] is ICallback);
		
		// GETs
		var v2 :Array = [];
			v2.push( getCallback(v1[0].trigger, v1[0].method) );
			v2.push( getCallback(v1[1].trigger, v1[1].method) );
		assertTrue(v1[0] == v2[0] && v1[1] == v2[1]);
		
		// REMOVEs
		var v3 :Array = removeCallbacks(
			{trigger:v1[0].trigger, method:v1[0].method},
			v1[1]
		);
		assertTrue(v3 != null);
		assertTrue(v3.length == 2);
		assertTrue(v1[0] == v3[0] && v1[1] == v3[1]);
		
		// GET nulls
		var v4 :Array = [];
			v4.push( getCallback(v1[0].trigger, v1[0].method) );
			v4.push( getCallback(v1[1].trigger, v1[1].method) );
		assertTrue(v4[0] == null && v4[1] == null);
	}
	
	[Test]  
	public function testTriggerCallbacks():void 
	{
		function f1a() :Boolean { return true; }
		function f1b() :Boolean { return true; }
		function f2a(v:Boolean) :Boolean { return v; }
		function f2b(v:Boolean) :Boolean { return v; }
		function f3a(v1:int, v2:int) :Boolean { return v1 / v2 == 2; }
		function f3b(v1:int, v2:int) :Boolean { return v1 / v2 == 2; }
		
		var a1 :Array = addCallbacks(
			{trigger:"testTriggerCallbacks1", method:f1a},
			new Callback("testTriggerCallbacks1", f1b)
		);
		var a2 :Array = addCallbacks(
			{trigger:"testTriggerCallbacks2", method:f2a},
			new Callback("testTriggerCallbacks2", f2b)
		);
		var a3: Array = addCallbacks(
			{trigger:"testTriggerCallbacks3", method:f3a},
			new Callback("testTriggerCallbacks3", f3b)
		);
		
		var v1 :Array = trigger("testTriggerCallbacks1");
		var v2 :Array = trigger("testTriggerCallbacks2", true);
		var v3 :Array = trigger("testTriggerCallbacks3", 2, 1);
		
		// TODO: Find out why length comes back as 3 sometimes for v1,2&3... wtf?
		assertEquals(2, v1.length);
		assertEquals(2, v2.length);
		assertEquals(2, v3.length);
		assertTrue(v1[0] && v1[1] && v2[0] && v2[1] && v3[0] && v3[1]);
		
		var a4 :Array = removeCallbacks(a1[0], a1[1], a2[0], a2[1], a3[0], a3[1]);
		assertTrue(a4.length == 6);
	}
	
	//-------------------- COMMANDS --------------------//
	[Test]  
	public function testAddGetRemoveCommand():void 
	{ 
		// ADD
		var v1a :ICommand = addCommand("testAddGetRemoveCommand", C);
		var v1b :ICommand = addCommand("testAddGetRemoveCommand", C, "custom");
		assertTrue(v1a is ICommand);
		assertTrue(v1b is ICommand);
		assertTrue(v1a != v1b);
		
		// GET
		var v2a :ICommand = getCommand(v1a.trigger, v1a.command);
		var v2b :ICommand = getCommand(v1b.trigger, v1b.command, v1b.method);
		assertTrue(v1a == v2a);
		assertTrue(v1b == v2b);
		
		// REMOVE
		var v3a :ICommand = removeCommand(v1a.trigger, v1a.command);
		var v3b :ICommand = removeCommand(v1b.trigger, v1b.command, v1b.method);
		assertTrue(v1a == v3a);
		assertTrue(v1b == v3b);
		
		// GET null
		var v4a :ICommand = getCommand(v1a.trigger, v1a.command);
		var v4b :ICommand = getCommand(v1b.trigger, v1b.command, v1b.method);
		assertTrue(v4a == null);
		assertTrue(v4b == null);
	}
	
	[Test]  
	public function testAddGetRemoveCommands():void 
	{ 
		// ADDs
		var v1 :Array = addCommands(
			{trigger:"testAddGetRemoveCommands1", command:C},
			{trigger:"testAddGetRemoveCommands1", command:C, method:"custom"},
			new Command("testAddGetRemoveCommands2", C),
			new Command("testAddGetRemoveCommands2", C, "custom")
		);
		assertTrue(v1 != null);
		assertTrue(v1.length == 4);
		assertTrue(v1[0] is ICommand && v1[1] is ICommand && v1[2] is ICommand && v1[3] is ICommand);
		assertTrue(v1[0].method == default_command_method);
		assertTrue(v1[2].method == default_command_method);
		
		// GETs
		var v2 :Array = [];
			v2.push( getCommand(v1[0].trigger, v1[0].command) );
			v2.push( getCommand(v1[1].trigger, v1[1].command, v1[1].method) );
			v2.push( getCommand(v1[2].trigger, v1[2].command) );
			v2.push( getCommand(v1[3].trigger, v1[3].command, v1[3].method) );
		assertTrue(v1[0] == v2[0] && v1[1] == v2[1] && v1[2] == v2[2] && v1[3] == v2[3]);
		
		// REMOVEs
		var v3 :Array = removeCommands(
			{trigger:v1[0].trigger, command:v1[0].command},
			{trigger:v1[1].trigger, command:v1[1].command, method:v1[1].method},
			v1[2],
			v1[3]
		);
		assertTrue(v3 != null);
		assertTrue(v3.length == 4);
		assertTrue(v1[0] == v3[0] && v1[1] == v3[1] && v1[2] == v3[2] && v1[3] == v3[3]);
		
		// GET nulls
		var v4 :Array = [];
		v4.push( getCommand(v1[0].trigger, v1[0].command) );
		v4.push( getCommand(v1[1].trigger, v1[1].command, v1[1].method) );
		v4.push( getCommand(v1[2].trigger, v1[2].command) );
		v4.push( getCommand(v1[3].trigger, v1[3].command, v1[3].method) );
		assertTrue(v4[0] == null && v4[1] == null && v4[2] == null && v4[3] == null);
	}
	
	
	[Test]  
	public function testTriggerCommands():void 
	{
		var a :Array = addCommands(
			new Command("testTriggerCommands1", C1),
			new Command("testTriggerCommands1", C2, "custom"),
			new Command("testTriggerCommands2", C3),
			new Command("testTriggerCommands2", C4, "custom"),
			new Command("testTriggerCommands3", C5),
			new Command("testTriggerCommands3", C6, "custom")
		);
		
		var v1 :Array = trigger("testTriggerCommands1");
		var v2 :Array = trigger("testTriggerCommands2", true);
		var v3 :Array = trigger("testTriggerCommands3", 2, 1);
		
		assertEquals(2, v1.length);
		assertEquals(2, v2.length);
		assertEquals(2, v3.length);
		assertTrue(v1[0] && v1[1] && v2[0] && v2[1] && v3[0] && v3[1]);
		
		var a4 :Array = removeCommands(a[0], a[1], a[2], a[3], a[4], a[5]);
		assertTrue(a4.length == 6);
	}
	
}
}

class C { public function execute():void{} }

class C1 { public function execute():Boolean{ return true; } }
class C2 { public function custom():Boolean{ return true; } }

class C3 { public function execute(v:Boolean):Boolean{ return v; } }
class C4 { public function custom(v:Boolean):Boolean{ return v; } }

class C5 { public function execute(v1:int, v2:int):Boolean{ return v1 / v2 == 2; } }
class C6 { public function custom(v1:int, v2:int):Boolean{ return v1 / v2 == 2; } }
