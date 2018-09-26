using Toybox.WatchUi;
using Toybox.Ant;

class CGMController {
	var bloodSugar = 0;
	var payload = [0,0,0,0,0,0,0,0];
	var channel;
	var msgId = -1;
	
	function initialize(){
	}
	
	function messageCallBack(msg){
		
		payload = msg.getPayload();
		msgId = msg.messageId;
		
		System.println("MessageId: " + msgId);
		System.println("payload: " + payload);
		
		//only allows single bytes to be passed in the future should be longs
		if(msgId == Ant.MSG_ID_BROADCAST_DATA){
			bloodSugar = payload[7];
			WatchUi.requestUpdate();
		} else if(msgId == Ant.MSG_ID_CHANNEL_RESPONSE_EVENT){
			if(payload[1] == Ant.MSG_CODE_EVENT_CHANNEL_CLOSED){
                    // Reopen the channel if it closed due to search timeout
                    var openResult = channel.open();
                    System.println("Channel had to be reopened result: " + openResult);
            }
		}
		
	}
	
	function setupChannel(){
		var channelAssign = new Ant.ChannelAssignment(Ant.CHANNEL_TYPE_RX_NOT_TX, Ant.NETWORK_PUBLIC);
		channel = new Ant.GenericChannel(method(:messageCallBack), channelAssign);
		
		var deviceConfig = new Ant.DeviceConfig({
    		:deviceNumber => 6161,                
    		:deviceType => 0,                  // 1 byte type identifier
    		:transmissionType => 0,             // Manufacturer-specific transport type
    		:messagePeriod => 8192,             // The message period
    		:radioFrequency => 66,              // Ant Frequency
    	});
    	
    	channel.setDeviceConfig(deviceConfig);
	}	
}