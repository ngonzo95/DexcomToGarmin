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
        displayBloodSugar(dc);
        displayRate(dc);
        displayTime(dc);
    }
    
    function displayBloodSugar(dc){
    	dc.drawText(
        	10, 5, Graphics.FONT_LARGE, "CGM Reading",  
        	Graphics.TEXT_JUSTIFY_LEFT
        );
    	dc.drawText(
        	dc.getWidth() / 2, (dc.getHeight() / 5) - 10, Graphics.FONT_NUMBER_HOT,
        	cgm.bloodSugar,Graphics.TEXT_JUSTIFY_CENTER
         );
    }
    
    function displayRate(dc){
    	dc.drawText(
        	10, 2*dc.getHeight() / 5, Graphics.FONT_LARGE, "CGM Rate",  
        	Graphics.TEXT_JUSTIFY_LEFT
        );
        dc.drawText(
        	dc.getWidth() / 2, (2*dc.getHeight() / 5) + 25, Graphics.FONT_LARGE, cgm.rate,  
        	Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    function displayTime(dc){
    	dc.drawText(
        	10, 3*dc.getHeight() / 4, Graphics.FONT_LARGE, "Last Reading",  
        	Graphics.TEXT_JUSTIFY_LEFT
        );
        dc.drawText(
        	dc.getWidth() / 2, (3*dc.getHeight() / 4) + 25, Graphics.FONT_LARGE, cgm.timeSinceLastReading,  
        	Graphics.TEXT_JUSTIFY_CENTER
        );
    
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
