/*
Simple chaincode to save DHT-22 temperature, humidity raspberryPI samplings
*/
package main

import (
	"fmt"
	"strings"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

// SamplingChaincode for sampling temperature, humidity
type SamplingChaincode struct {
}

func parseReading(reading string) (temp string, humid string) {
	arr := strings.SplitN(reading, ",", 2)

	return arr[0], arr[1]
}

// Init called once for each chaincode version deployment:
// initializes a chaincode and sets the initial ledger state
func (t *SamplingChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("samplingChaincode Init")
	args := stub.GetStringArgs()

	return setLedger(args, stub)
}

// Invoke calls a chaincode function multiple time to perform a ledger function
// Save ledger a temperature, humidity reading
func (t *SamplingChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("samplingChaincode Invoke")
	args := stub.GetStringArgs()

	return setLedger(args, stub)
}

func setLedger(args []string, stub shim.ChaincodeStubInterface) pb.Response {
	if len(args) != 2 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	if err := SaveReading(args, stub); err != nil {

		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func SaveReading(args []string, stub shim.ChaincodeStubInterface) error {
	samplingLocation := args[0]
	temperatureVal, humidityVal := parseReading(args[1])

	fmt.Printf("From node: %s, Temp in Celsius = %s, Humidity = %s\n",
		samplingLocation, temperatureVal, humidityVal)

	// Write the state to the ledger
	if err := stub.PutState(samplingLocation+", Temperature in C", []byte(temperatureVal)); err != nil {

		return err
	}

	if err := stub.PutState(samplingLocation+", Humidity %", []byte(humidityVal)); err != nil {

		return err
	}

	return nil
}

func main() {
	err := shim.Start(new(SamplingChaincode))
	if err != nil {
		fmt.Printf("Error starting Sample chaincode: %s", err)
	}
}
