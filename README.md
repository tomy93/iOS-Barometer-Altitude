Altitude from iOS GPS can be inconsistent. 
While it is generally accurate, there can be fluctuations of 5 to 30 meters during intervals of 5 to 10 minutes.
This issue can occur even when using two devices placed side by side, which may show the same discrepancy.

In contrast, barometer-based altitude measurements tend to be more accurate and do not exhibit these inconsistencies. 
However, to obtain the altitude value from a barometer, you need to know the current temperature and the atmospheric pressure at sea level for your location.

The formula for converting sea-level pressure (Pa), temperature in Kelvin, and current pressure (Pa), which is used here, comes from: https://www.mide.com/air-pressure-at-altitude-calculator.

Instructions to setup this as a Unity plugin:
- Place BarometerAtitude.mm in Assets/Plugins/iOS.
- Add the necessary interop functions where needed, i.e:
```
#if UNITY_IOS && !UNITY_EDITOR
  [DllImport("__Internal")]
  private static extern int _startAltitudeUpdates();
#endif
```
- Start the altimeter sensor with _startAltitudeUpdates.
- Get the altitute with _getCurrentAltitude, you will need to send the expected parameters.
