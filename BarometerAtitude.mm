#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>
#import <math.h>

extern "C" {
    
    static CMAltimeter *altimeter;
    static float currentPressure = 0.0;
    static float  M = 0.0289644;
    static float  g = 9.80665;
    static float  R = 8.31432;

    void _startAltitudeUpdates() {
        if (!altimeter) {
            altimeter = [[CMAltimeter alloc] init];
        }

        if ([CMAltimeter isRelativeAltitudeAvailable]) {
            NSLog(@"Barometer is available. Starting updates...");

            [altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue mainQueue] 
            withHandler:^(CMAltitudeData * _Nullable data, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error in altitude updates: %@", error.localizedDescription);
                } else {
                    currentPressure = [data.pressure floatValue];
                    NSLog(@"Current Pressure: %f", currentPressure);
                }
            }
        ];
        } else {
            NSLog(@"Barometer is not available on this device.");
        }
    }

    void _stopAltitudeUpdates() {
        if (altimeter) {
            [altimeter stopRelativeAltitudeUpdates];
            NSLog(@"Stopped altitude updates.");
        }
    }

    // don't change the fixed numbers of the formula!
    float _altitudeFromPressure(float a, float k, float i) {
        if ((a / i) < (101325 / 22632.1)) {
            float d = -0.0065;
            float e = 0;
            float j = powf((i / a), (R * d) / (g * M));
            return e + ((k * ((1 / j) - 1)) / d);
        } else {
            if ((a / i) < (101325 / 5474.89)) {
                float e = 11000;
                float b = k - 71.5;
                float f = (R * b * (logf(i / a))) / ((-g) * M);
                float l = 101325;
                float c = 22632.1;
                float h = ((R * b * (logf(l / c))) / ((-g) * M)) + e;
                return h + f;
            }
        }
        return 0;
    }

    // pressureAtSeaLevel in Pa (Pascal) is the atmospheric pressure at sea
    // level of the current location, e.g.: 101325
    // kelving temperature, e.g.: 288.15
    float _getCurrentAltitude(float pressureAtSeaLevelPa, float kelvinTemperature) {
        NSLog(@"Getting current altitude from pressure: %f", currentPressure);
        return _altitudeFromPressure(pressureAtSeaLevelPa, kelvinTemperature, currentPressure * 1000);
    }

    float _getCurrentPressure() {
        NSLog(@"Getting current altitude from pressure: %f", currentPressure);
        return currentPressure;
    }
}