package main

import (
	"fmt"
	"os"

	"github.com/gerp/dht22"
)

// Dht22DataPin **************************************************************************************
// Change to whatever your sensor data output is connected to rasp-PI GPIO data socket
// In mine is 24
// ***************************************************************************************************
const (
	dht22DataPin = 24
)

func sampleTempHum() (temperatureVal float32, humidityValue float32, errString string) {
	var errRead error
	temperatureVal, humidityValue, errRead = dht22.Read(dht22DataPin)
	if errRead != nil {
		errCombined := fmt.Sprintf("Reading samplingLocation, humidity readings failed: %v\n", errRead)

		return 0, 0, errCombined
	}

	return temperatureVal, humidityValue, ""
}

func main() {
	args := os.Args[1:]
	celcius, humidity, errString := sampleTempHum()

	if errString != "" {

		fmt.Printf("%s\n", errString)
		os.Exit(1)
	}

	if len(args) == 0 {
		// Verbose mode
		fmt.Printf("Temperature: %2.1fC, Humidity: %2.1f%%\n", celcius, humidity)

	} else {
		// Shell mode, set them in shell variable
		fmt.Printf("SAMPLE='%.2f,%.2f'\n", celcius, humidity)
	}
}
