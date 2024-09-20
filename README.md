**UNITY READY PLUGIN**

Altitude from iOS GPS can be inconsistent. 
While it is generally accurate, there can be fluctuations of 5 to 30 meters during intervals of 5 to 10 minutes.
This issue can occur even when using two devices placed side by side, which may show the same discrepancy.

In contrast, barometer-based altitude measurements tend to be more accurate and do not exhibit these inconsistencies. 
However, to obtain the altitude value from a barometer, you need to know the current temperature and the atmospheric pressure at sea level for your location.

The formula for converting sea-level pressure (Pa), temperature in Kelvin, and current pressure (Pa), which is used here, comes from: https://www.mide.com/air-pressure-at-altitude-calculator.
