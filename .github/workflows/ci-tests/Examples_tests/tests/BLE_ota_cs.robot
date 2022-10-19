*** settings ***
Library    SerialLibrary      encoding=ascii
Library    String
Resource     ../resources/Serial.robot
Suite Setup        Serial.Open Serial Port    ${SERIAL_PORT_1}    ${SERIAL_PORT_2}    
Suite Teardown     Serial.Close Serial Port

*** Variables ***
${SERIAL_PORT_1}  /dev/ttyUSB0
${SERIAL_PORT_2}  /dev/ttyUSB1

${VERBOSE}     None

*** test cases ***
Original Firmware Test
    [Timeout]    30s
    Sleep     5s
    # inital sleep to allow device time to boot up after programming
    Serial.send    btn 2 m\n    ${SERIAL_PORT_2}
    Serial.Expect And Timeout    FW_VERSION: 1    5s    ${SERIAL_PORT_2}

File Discovery Test
    [Timeout]    30s
     Serial.send    btn 2 s\n    ${SERIAL_PORT_1}
     Serial.Expect And Timeout    >>> File discovery complete <<<    5s    ${SERIAL_PORT_1}

File Transfer Test
    [Timeout]    30s
     Serial.Send    btn 2 m\n    ${SERIAL_PORT_1}
    Serial.Expect And Timeout No Verbose    >>> File transfer complete    20s    ${SERIAL_PORT_1}

File Verification Test
    [Timeout]    30S
    Serial.Send    btn 2 l\n    ${SERIAL_PORT_1}
    Serial.Expect And Timeout    >>> Verify complete status: 0 <<<    2s    ${SERIAL_PORT_1}

Peer Device Reset Test
    [Timeout]    30s
    Serial.Send    btn 2 x\n    ${SERIAL_PORT_1}
    Serial.Expect And Timeout    >>> Scanning started <<<    5s    ${SERIAL_PORT_1}


Firmware Reconnect Succesful Test
    [Timeout]    60s
    Serial.Expect And Timeout    AppDiscComplete connId:1 status:0x08    30s    ${SERIAL_PORT_1}


Firmware Update Verification Test
    [Timeout]    30s
    Sleep     5
    Serial.Flush Serial Port    ${SERIAL_PORT_2}
    Sleep     1
    Serial.send    btn 2 m\n    ${SERIAL_PORT_2}

