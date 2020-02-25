/*
Simple chaincode to save DHT-22 temperature, humidity raspberryPI samplings
*/
package main

import (
	"fmt"
	"strings"
	"time"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

// SamplingChaincode for sampling temperature, humidity
type SamplingChaincode struct {
}

type sampling struct {
	ObjectType string    `json:"docType"`  // docType is used to distinguish the various types of objects in state database
	Node       string    `json:"node"`     // sending node
	Temp       string    `json:"temp"`     // temperature reading
	Humidity   string    `json:"humidity"` // humidity reading
	AppendedAt time.Time `json:"appendedAt"`
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

	return appendLedger(args, stub)
}

// Invoke calls a chaincode function multiple time to perform a ledger function
// Save ledger a temperature, humidity reading
func (t *SamplingChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	fmt.Println("samplingChaincode Invoke")
	args := stub.GetStringArgs()

	return appendLedger(args, stub)
}

func appendLedger(args []string, stub shim.ChaincodeStubInterface) pb.Response {
	if len(args) != 2 {
		return shim.Error("Incorrect number of arguments. Expecting 2")
	}

	if err := saveSampling(args, stub); err != nil {

		return shim.Error(err.Error())
	}

	return shim.Success(nil)
}

func saveSampling(args []string, stub shim.ChaincodeStubInterface) error {
	nodeIPAddress := args[0]
	temperatureVal, humidityVal := parseReading(args[1])

	fmt.Printf("From node: %s, Temp in Celsius = %s, Humidity = %s\n",
		nodeIPAddress, temperatureVal, humidityVal)

	samplingJSONasString := `{"docType":"sampling",  "node": "` + nodeIPAddress + `", "Celsius temperature": "` +
		temperatureVal + `", "humidity": ` + humidityVal + `, "appendedAt": "` +
		time.Now().String() + `"}`
	samplingJSONasBytes := []byte(samplingJSONasString)

	// Write / append the state to the ledger
	if err := stub.PutState("sampling", samplingJSONasBytes); err != nil {

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
