using Toybox.WatchUi;

class genericAntSerialDisplayView extends WatchUi.View {
	hidden var cgm;
	
    function initialize(cgmInit) {
        View.initialize();
        cgm = cgmInit;
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.drawText(
        	dc.getWidth() / 2,                      // gets the width of the device and divides by 2
        	dc.getHeight() / 4,                     // gets the height of the device and divides by 2
        	Graphics.FONT_NUMBER_HOT,                    // sets the font size
        	cgm.bloodSugar,                          // the String to display
        	Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
         );
         var lineOne = cgm.payload.slice(0, 4);
         var lineTwo = cgm.payload.slice(4, 8);
         dc.drawText(
        	dc.getWidth() / 2,                      // gets the width of the device and divides by 2
        	dc.getHeight() / 2,                     // gets the height of the device and divides by 2
        	Graphics.FONT_XTINY,                    // sets the font size
        	lineOne,                          // the String to display
        	Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
         );
         
         dc.drawText(
        	dc.getWidth() / 2,                      // gets the width of the device and divides by 2
        	3*dc.getHeight() / 5,                     // gets the height of the device and divides by 2
        	Graphics.FONT_XTINY,                    // sets the font size
        	lineTwo,                          // the String to display
        	Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
         );
         
         dc.drawText(
        	dc.getWidth() / 2,                      // gets the width of the device and divides by 2
        	4*dc.getHeight() / 5,                     // gets the height of the device and divides by 2
        	Graphics.FONT_XTINY,                    // sets the font size
        	cgm.msgId,                          // the String to display
        	Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
         );
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
