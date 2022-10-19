
*** Settings ***
Library    SerialLibrary      encoding=ascii
Library    String

*** Variables ***
${is_verbose}   ${VERBOSE}

*** Keywords ***
Open Serial Port
    [Arguments]    ${SERIAL_PORT_1}    ${SERIAL_PORT_2}    
    
    Add Port   ${SERIAL_PORT_1}
    ...        baudrate=115200
    ...        bytesize=8
    ...        parity=N
    ...        stopbits=1
    ...        timeout=999
    IF    "${SERIAL_PORT_2}" != "NONE"
        Add Port   ${SERIAL_PORT_2}
        ...        baudrate=115200
        ...        bytesize=8
        ...        parity=N
        ...        stopbits=1
        ...        timeout=999
    END
   
Close Serial Port
    Delete All Ports
    
#    Port parameters:
#        data          = data
#        encoding      = None
#        encoding_mode = None
#        port_locator  = port

Send
    [Arguments]    ${data}     ${port}
    Write Data    ${data}    NONE    NONE    ${port}


Expect And Timeout   
    [Arguments]    ${data}    ${timeout}    ${port}
    [Timeout]    ${timeout}
    ${read} =     Read Until    ${data}    NONE    NONE    ${port}
    Log Serial Traffic    ${read}
    
Expect And Timeout No Verbose  
    [Arguments]    ${data}    ${timeout}    ${port}
    [Timeout]    ${timeout}
    ${read} =     Read Until    ${data}    NONE    NONE    ${port}
   
   
Log Serial Traffic
    [Arguments]    ${data}
    Log To Console    \n
    Log To Console  ${data}
    Log To Console    \n
    
Flush Serial Port
    [Arguments]    ${port}
    Flush Port    ${port}

Clear Port Input Buffer
    [Arguments]    ${port}
    Reset Input Buffer    ${port}