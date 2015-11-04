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
	
		public var button:Sprite = new Sprite();
		public var label:TextField = new TextField();
		
		public function MyButton($label:String, $x:Number, $y:Number, $width:Number, $height:Number, $typme:String) 
		{
			button.graphics.lineStyle(1);
			//just for fun, lets make it looks better
			if ($label.indexOf("C") > -1) button.graphics.beginFill(0xDF7401); 
			else if ($label.indexOf("=") > -1) button.graphics.beginFill(0x5882FA); 
			else   button.graphics.beginFill(0x424242); 
			
			button.graphics.drawRoundRect(0, 0, $width, $height, 5);			
			button.graphics.endFill();
			button.buttonMode = true;
			button.x = $x; button.y = $y;
			button.name = label.text = $label;
			label.x = $width/2 - 10; label.y = $height/2 - 10;
			label.width = 20; label.height = 20;
			label.selectable = label.mouseEnabled = false;
			label.backgroundColor = 0x000000;
			label.setTextFormat(new TextFormat("_sans", 15, 0xffffff, true, null, null, null, null, "center"));
			
			button.addChild(label);
			addChild(button);
		}
		
	}

}