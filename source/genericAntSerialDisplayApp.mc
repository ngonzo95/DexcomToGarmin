using Toybox.Application;
using Toybox.Ant;
using Toybox.Timer;

class genericAntSerialDisplayApp extends Application.AppBase {
	hidden var cgm;
	hidden var counter = 200;
	
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	System.println("Starting APP");
    	cgm = new CGMController();
    	cgm.open();

    	var myTimer = new Timer.Timer();
    	myTimer.start(method(:timerCallback), 1000, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	System.println("Closing APP");
    	cgm.closeSensor();
    	cgm.release();
    }

    // Return the initial view of your application here
    function getInitialView() {
    	
        return [ new genericAntSerialDisplayView(cgm) ];
    }
    
    function createFakeMessage(val){
    	var message = new Ant.Message();
    	message.setPayload([1,1,1,1,(counter/5),(counter/5)%5,(counter & 0xff00) >> 8, counter & 0xff]);
    	message.messageId = 78;
    	cgm.messageCallBack(message);
    }
    
    function timerCallback(){
    	counter += 1;
    	createFakeMessage(counter);
    }

}