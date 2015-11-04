package {
	
	/**
	 * ...
	 * @author Pavlo K
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import MyButton;
	
	
	[SWF(backgroundColor = "#222222", width = 230, height = 240)]
	
	public class Main extends Sprite {
		
		public var output:TextField = new TextField();
		public var actions:Array = ["0"];
		public var _buttons:Array = [
										//value, x, y, width, height, type
										["C", 5, 50, 50, 30, clear],
										["←", 60, 50, 50, 30, undo],
										["±", 115, 50, 50, 30, flip],
										["/", 170, 50, 50, 30, operation],
										["7", 5, 85, 50, 30, digit],
										["8", 60, 85, 50, 30, digit],
										["9", 115, 85, 50, 30, digit],
										["*", 170, 85, 50, 30, operation],
										["4", 5, 120, 50, 30, digit],
										["5", 60, 120, 50, 30, digit],
										["6", 115, 120, 50, 30, digit],
										["-", 170, 120, 50, 30, operation],										
										["1", 5, 155, 50, 30, digit],
										["2", 60, 155, 50, 30, digit],
										["3", 115, 155, 50, 30, digit],
										["+", 170, 155, 50, 30, operation],
										["0", 5, 190, 50, 30, digit],
										[".", 60, 190, 50, 30, digit],
										["=", 115, 190, 105, 30, result]										
									];
		
		public function Main() {stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);}
		
		public function init(me:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			output.x = 5; output.y = 5;
			output.width = 215; output.height = 28;
			output.border = true;
			output.selectable = false;
			output.defaultTextFormat = new TextFormat("_sans", 20, 0xffffff, true, null, null, null, null, "right");
			// bg colour is not working =( 
			output.backgroundColor = 0x111111;
			output.text = "0";
			addChild(output);
			
			var i:int = _buttons.length;
			while (i--) {
				var button:MyButton = new MyButton(_buttons[i][0], _buttons[i][1], _buttons[i][2], _buttons[i][3], _buttons[i][4], _buttons[i][5]);
				
				addChild(button);
				button.addEventListener(MouseEvent.CLICK, _buttons[i][5]);				
			}
		}
		
		public function checkRange():void 
		{
			var ind:int = output.text.indexOf (".");
			var sign:int = output.text.indexOf ("-");	
				if ( ind > -1 ) {
					var decimal:String = output.text.substring (ind+1);
					if (decimal.indexOf (".") > -1) {
						actions[actions.length - 1] = output.text = output.text.substring (0, ind + 1 + decimal.indexOf("."));
					}
					if (decimal.length > 2) {
						actions[actions.length - 1] = output.text = output.text.substring (0, ind + 3);
					}
				}else if (ind == -1 ) {
					if(sign == -1)
						actions[actions.length - 1] = output.text = output.text.substring (0, 4);
					else actions[actions.length - 1] = output.text = output.text.substring (0, 5);
				}
				
		}
		public function truncate ():void 
		{
			var error:String = "check";
			output.text = actions[actions.length - 1]; 
			if (Number(output.text) >= 10000 || Number(output.text) <= -10000 ){
				actions[actions.length - 1] = output.text = error;
			}
				
		}
		
		public function digit(me:MouseEvent):void 
		{
			if (isNaN(actions[actions.length - 1])) actions.push("0");
			var value:String = me.target.name;
			var number:String = actions[actions.length - 1];
			if (value != ".") number = (number == "0") ? value : number + value;
			else if (number.indexOf(".") == -1) number += ".";
			output.text = actions[actions.length - 1] = number;
			checkRange()
		}
		
		public function operation(me:MouseEvent):void 
		{
			if (actions.length == 1) actions[0] = output.text;
			isNaN(actions[actions.length - 1]) ? actions[actions.length - 1] = me.target.name : actions.push(me.target.name);
		}
		
		public function result(me:MouseEvent):void 
		{
			if (actions.length < 3) return;
			var value:Number = Number(actions[0]);
			for (var i:int = 1; i < actions.length - 1; i += 2) {
				//to show last rezult
				//_output.text = String(Number(value.toFixed(2)));
				switch (actions[i]) {
					case "+": value += Number(actions[i+1]); break;
					case "-": value -= Number(actions[i+1]); break;
					case "*": value *= Number(actions[i+1]); break;
					case "/": value /= Number(actions[i+1]); break;
				}
			}
			if (value <= -10000 || value >= 10000) {
				actions = ["0"];	
				output.text = "Error";  				
			} else if (!isNaN(value) && isFinite(value)) {
				actions = ["0"]; 
				output.text = String(Number(value.toFixed(2)));				
			} else {
				
				actions = ["0"];
				output.text = "WoW what is that?";  
									
			}
		}
		
		public function clear(me:MouseEvent):void 
		{
			actions = ["0"];
			output.text = "0";
		}
		
		public function flip(me:MouseEvent):void 
		{		
			if (output.text.substr(0, 1) != "0" || output.text.indexOf(".") > -1){
				if(output.text.substr(0, 1) == "-") {
					actions[actions.length - 1] = output.text = output.text.substr(1, output.text.length)
				} else {
					actions[actions.length - 1] = output.text = "-" + output.text
				}
			} else return; 
		}
		
		public function undo(me:MouseEvent):void 
		{						
			output.text = output.text.substr(0, output.text.length - 1);
				if (output.text.length == 0 || output.text == "-") {
					output.text = "0";
				}
			actions[actions.length - 1] = output.text;
		}
		
	}
}
