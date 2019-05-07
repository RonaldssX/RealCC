@interface CCUILabeledRoundButton
@property (nonatomic, copy, readwrite) NSString *title;
@end

@interface CCUILabeledRoundButtonViewController

@end

@interface SBWiFiManager
-(id)sharedInstance;
-(void)setWiFiEnabled:(BOOL)enabled;
-(bool)wiFiEnabled;
@end

@interface BluetoothManager
-(id)sharedInstance;
-(void)setEnabled:(BOOL)enabled;
-(bool)enabled;

-(void)setPowered:(BOOL)powered;
-(bool)powered;

@end

static BOOL BTenabbled;


%hook CCUILabeledRoundButton
-(void)buttonTapped:(id)arg1 {


if ([self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_WIFI_NAME" value:@"CONTROL_CENTER_STATUS_WIFI_NAME" table:@"Localizable"]]) {
    
    SBWiFiManager *wiFiManager = (SBWiFiManager *)[%c(SBWiFiManager) sharedInstance];

    [wiFiManager setWiFiEnabled: ![wiFiManager wiFiEnabled]];
    
    return;
   
}

if ([self.title isEqualToString:[[NSBundle bundleWithPath:@"/System/Library/ControlCenter/Bundles/ConnectivityModule.bundle"] localizedStringForKey:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" value:@"CONTROL_CENTER_STATUS_BLUETOOTH_NAME" table:@"Localizable"]]) {
    
    BluetoothManager *btoothManager = (BluetoothManager *)[%c(BluetoothManager) sharedInstance];
    
    BOOL inverseEnabled = ![btoothManager enabled];
    
    [btoothManager setEnabled: inverseEnabled];
    [btoothManager setPowered: inverseEnabled];

    BTenabbled = inverseEnabled;
    
  }
    
}

%end


%hook BluetoothManager


- (BOOL)setEnabled:(BOOL)arg1 {
   return %orig(BTenabbled);
}

- (BOOL)setPowered:(BOOL)arg1{
    return %orig(BTenabbled);
}

-(BOOL)enabled {
    BTenabbled = !%orig;
    return %orig;
}
%end

