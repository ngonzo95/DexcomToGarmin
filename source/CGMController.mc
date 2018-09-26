using Toybox.WatchUi;
using Toybox.Ant;

class CGMController extends Ant.GenericChannel {
	var bloodSugar = -1;
	var rate = -1;
	var timeSinceLastReading = -1;
	
	var rateEnum = {0 => "Increasing Quickly",
				   1 => "Increasing",
				   2 => "Stable",
				   3 => "Decreasing",
				   4 => "Decreasing Quickly"};
				   
	var payload = [0,0,0,0,0,0,0,0];
	var msgId = -1;
	
	function initialize(){
		var channelAssign = new Ant.ChannelAssignment(Ant.CHANNEL_TYPE_RX_NOT_TX, Ant.NETWORK_PUBLIC);
		GenericChannel.initialize(method(:messageCallBack), channelAssign);
		
		var deviceConfig = new Ant.DeviceConfig({
    		:deviceNumber => 6161,                
    		:deviceType => 2,                  // 1 byte type identifier
    		:transmissionType => 0,             // Manufacturer-specific transport type
    		:messagePeriod => 8192,             // The message period
    		:radioFrequency => 66,              // Ant Frequency
    		:searchTimeoutLowPriority => 10,    // Timeout in 25s
            :searchThreshold => 0
    	});
    	
    	GenericChannel.setDeviceConfig(deviceConfig);
	}
	
	function messageCallBack(msg){
		
		payload = msg.getPayload();
		msgId = msg.messageId;
		
		System.println("MessageId: " + msgId);
		System.println("payload: " + payload);
		
		//only allows single bytes to be passed in the future should be longs
		if(msgId == Ant.MSG_ID_BROADCAST_DATA){
			bloodSugar = (payload[6] << 8) + (payload[7]);
			rate = rateEnum[payload[5]];
			timeSinceLastReading = getLastReadTime(payload[4]);
			
			
			WatchUi.requestUpdate();
			
		} else if(msgId == Ant.MSG_ID_CHANNEL_RESPONSE_EVENT){
			if(payload[1] == Ant.MSG_CODE_EVENT_CHANNEL_CLOSED){
                    // Reopen the channel if it closed due to search timeout
                    open();
                    System.println("Channel had to be reopened");
            }
		}
		
	}
	
	function getLastReadTime(val){
		if(val > 60){
			return "> 1 Hour";
		} else {
			return val + " Mins";
		}
	}
	
	function open(){
		GenericChannel.open();
	}
	
	function closeSensor() {
        GenericChannel.close();
    }
}