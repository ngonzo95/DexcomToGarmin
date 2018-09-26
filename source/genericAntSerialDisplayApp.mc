using Toybox.Application;
using Toybox.Ant;
using Toybox.Timer;

class genericAntSerialDisplayApp extends Application.AppBase {
	hidden var cgm;
	hidden var counter = 0;
	
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	cgm = new CGMController();
    	System.println("Starting APP");
    	//Setup the ant channel to recieve messages
		cgm.setupChannel();
    	var openResult = cgm.channel.open();
    	System.println("Open result: " + openResult);
    	System.println("Startup completed");
    	
//    	var myTimer = new Timer.Timer();
//    	myTimer.start(method(:timerCallback), 1000, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	System.println("Closing APP");
    }

    // Return the initial view of your application here
    function getInitialView() {
    	
        return [ new genericAntSerialDisplayView(cgm) ];
    }
    
    function createFakeMessage(val){
    	var message = new Ant.Message();
    	message.setPayload([val,val+1,val+2,val+3,val+4,val+5,val+6,val+7]);
    	cgm.messageCallBack(message);
    }
    
    function timerCallback(){
    	counter += 1;
    	createFakeMessage(counter);
    }

}