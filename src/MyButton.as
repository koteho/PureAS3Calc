package 
{
	/**
	 * ...
	 * @author Pavlo K
	 */
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class MyButton extends Sprite
	{		
	
		public var _button:Sprite = new Sprite();
		public var _label:TextField = new TextField();
		
		public function MyButton($label:String, $x:Number, $y:Number, $width:Number, $height:Number, $type:String) 
		{
			_button.graphics.lineStyle(1);
			//just for fun, lets make it looks better
			if ($label.indexOf("C") > -1) _button.graphics.beginFill(0xDF7401); 
			else if ($label.indexOf("=") > -1) _button.graphics.beginFill(0x5882FA); 
			else   _button.graphics.beginFill(0x424242); 
			
			_button.graphics.drawRoundRect(0, 0, $width, $height, 5);			
			_button.graphics.endFill();
			_button.buttonMode = true;
			_button.x = $x; _button.y = $y;
			_button.name = _label.text = $label;
			_label.x = $width/2 - 10; _label.y = $height/2 - 10;
			_label.width = 20; _label.height = 20;
			_label.selectable = _label.mouseEnabled = false;
			_label.backgroundColor = 0x000000;
			_label.setTextFormat(new TextFormat("_sans", 15, 0xffffff, true, null, null, null, null, "center"));
			
			_button.addChild(_label);
			addChild(_button);
		}
		
	}

}