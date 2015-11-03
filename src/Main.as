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
		
		public var _output:TextField = new TextField();
		public var _actions:Array = ["0"];
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
		
		public function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_output.x = 5; _output.y = 5;
			_output.width = 220; _output.height = 28;
			_output.border = true;
			_output.selectable = false;
			_output.defaultTextFormat = new TextFormat("_sans", 20, 0xffffff, true, null, null, null, null, "right");
			// bg colour is not working =( 
			_output.backgroundColor = 0x111111;
			_output.text = "0";
			addChild(_output);
			
			var i:int = _buttons.length;
			while (i--) {
				var button:MyButton = new MyButton(_buttons[i][0], _buttons[i][1], _buttons[i][2], _buttons[i][3], _buttons[i][4], _buttons[i][5]);
				
				addChild(button);
				button.addEventListener(MouseEvent.CLICK, _buttons[i][5]);				
			}
		}
		
		public function checkRange():void 
		{
			var ind:int = _output.text.indexOf (".");
			var sign:int = _output.text.indexOf ("-");	
				if ( ind > -1 ) {
					var decimal:String = _output.text.substring (ind+1);
					if (decimal.indexOf (".") > -1) {
						_actions[_actions.length - 1] = _output.text = _output.text.substring (0, ind + 1 + decimal.indexOf("."));
					}
					if (decimal.length > 2) {
						_actions[_actions.length - 1] = _output.text = _output.text.substring (0, ind + 3);
					}
				}else if (ind == -1 ) {
					if(sign == -1)
						_actions[_actions.length - 1] = _output.text = _output.text.substring (0, 4);
					else _actions[_actions.length - 1] = _output.text = _output.text.substring (0, 5);
				}
				
		}
		public function truncate ():void 
		{
			var error:String = "check";
			_output.text = _actions[_actions.length - 1]; 
			if (Number(_output.text) >= 10000 || Number(_output.text) <= -10000 ){
				_actions[_actions.length - 1] = _output.text = error;
			}
				
		}
		
		public function digit(e:MouseEvent):void 
		{
			if (isNaN(_actions[_actions.length - 1])) _actions.push("0");
			var value:String = e.target.name;
			var number:String = _actions[_actions.length - 1];
			if (value != ".") number = (number == "0") ? value : number + value;
			else if (number.indexOf(".") == -1) number += ".";
			_output.text = _actions[_actions.length - 1] = number;
			checkRange()
		}
		
		public function operation(e:MouseEvent):void 
		{
			if (_actions.length == 1) _actions[0] = _output.text;
			isNaN(_actions[_actions.length - 1]) ? _actions[_actions.length - 1] = e.target.name : _actions.push(e.target.name);
		}
		
		public function result(e:MouseEvent):void 
		{
			if (_actions.length < 3) return;
			var value:Number = Number(_actions[0]);
			for (var i:int = 1; i<_actions.length-1; i+=2) {
				switch (_actions[i]) {
					case "+": value += Number(_actions[i+1]); break;
					case "-": value -= Number(_actions[i+1]); break;
					case "*": value *= Number(_actions[i+1]); break;
					case "/": value /= Number(_actions[i+1]); break;
				}
			}
			if (value <= -10000 || value >= 10000) {
				_actions = ["0"];	
				_output.text = "Number is out of range";  				
			} else if (!isNaN(value) && isFinite(value)) {
				_actions = ["0"]; 
				_output.text = String(Number(value.toFixed(2)));				
			} else {
				
				_actions = ["0"];
				_output.text = "Error";  
									
			}
		}
		
		public function clear(e:MouseEvent):void 
		{
			_actions = ["0"];
			_output.text = "0";
		}
		
		public function flip(e:MouseEvent):void 
		{		
			if (_output.text.substr(0, 1) != "0" || _output.text.indexOf(".") > -1){
				if(_output.text.substr(0, 1) == "-") {
					_actions[_actions.length - 1] = _output.text = _output.text.substr(1, _output.text.length)
				} else {
					_actions[_actions.length - 1] = _output.text = "-" + _output.text
				}
			} else return; 
		}
		
		public function undo(e:MouseEvent):void 
		{						
			_output.text = _output.text.substr(0, _output.text.length - 1);
				if (_output.text.length == 0 || _output.text == "-") {
					_output.text = "0";
				}
			_actions[_actions.length - 1] = _output.text;
		}
		
	}
}
