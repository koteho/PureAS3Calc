package {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	[SWF(backgroundColor = "#ffffff", width = 240, height = 230)]
	
	public class Main extends Sprite {
		
		public var _output:TextField = new TextField();
		public var _actions:Array = ["0"];
		public var _buttons:Array = [
										["1", 5, 130, 40, 40, digit],
										["2", 50, 130, 40, 40, digit],
										["3", 95, 130, 40, 40, digit],
										["4", 5, 85, 40, 40, digit],
										["5", 50, 85, 40, 40, digit],
										["6", 95, 85, 40, 40, digit],
										["7", 5, 40, 40, 40, digit],
										["8", 50, 40, 40, 40, digit],
										["9", 95, 40, 40, 40, digit],
										["0", 5, 175, 85, 40, digit],
										[".", 95, 175, 40, 40, digit],
										["+", 140, 40, 40, 40, operation],
										["-", 140, 85, 40, 40, operation],
										["*", 140, 130, 40, 40, operation],
										["/", 140, 175, 40, 40, operation],
										["C", 185, 40, 40, 85, clear],
										["=", 185, 130, 40, 85, result]
									];
		
		public function Main() {stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);}
		
		public function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_output.x = 5; _output.y = 5;
			_output.width = 220; _output.height = 30;
			_output.border = true;
			_output.selectable = false;
			_output.defaultTextFormat = new TextFormat("_sans", 20, 0x000000, true, null, null, null, null, "right");
			_output.text = "0";
			addChild(_output);
			
			var i:int = _buttons.length;
			while (i--) {
				var button:MyButton = new MyButton(_buttons[i][0], _buttons[i][1], _buttons[i][2], _buttons[i][3], _buttons[i][4]);
				addChild(button);
				button.addEventListener(MouseEvent.CLICK, _buttons[i][5]);
			}
		}
		
		public function digit(e:MouseEvent):void {
			if (isNaN(_actions[_actions.length-1])) _actions.push("0");
			var value:String = e.target.name;
			var number:String = _actions[_actions.length - 1];
			if (value != ".") number = (number == "0") ? value : number + value;
			else if (number.indexOf(".") == -1) number += ".";
			_output.text = _actions[_actions.length - 1] = number;
		}
		
		public function operation(e:MouseEvent):void {
			if (_actions.length == 1) _actions[0] = _output.text;
			isNaN(_actions[_actions.length - 1]) ? _actions[_actions.length - 1] = e.target.name : _actions.push(e.target.name);
		}
		
		public function result(e:MouseEvent):void {
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
			_actions = ["0"];
			_output.text = String(Number(value.toFixed(10)));
		}
		
		public function clear(e:MouseEvent):void {
			_actions = ["0"];
			_output.text = "0";
		}
		
	}
}

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

class MyButton extends Sprite {
	
	public var _button:Sprite = new Sprite();
	public var _label:TextField = new TextField();
	
	public function MyButton($label:String, $x:Number, $y:Number, $width:Number, $height:Number) {
		_button.graphics.lineStyle(1);
		_button.graphics.beginFill(0xffffff);
		_button.graphics.drawRoundRect(0, 0, $width, $height, 5);
		_button.graphics.endFill();
		_button.buttonMode = true;
		_button.x = $x; _button.y = $y;
		_button.name = _label.text = $label;
		_label.x = $width/2 - 10; _label.y = $height/2 - 10;
		_label.width = 20; _label.height = 20;
		_label.selectable = _label.mouseEnabled = false;
		_label.setTextFormat(new TextFormat("_sans", 15, 0x000000, true, null, null, null, null, "center"));
		
		_button.addChild(_label);
		addChild(_button);
	}
}