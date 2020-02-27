*** Settings ***
Documentation          This suite tests an Octave snapd installation 

# Resource               ../Resources/client-resources.robot
Library                SSHLibrary
Library                BuiltIn
Library                String
Library                OperatingSystem
Suite Setup            Open Connection And Log In
# Suite Teardown         Close All Connections



# Suite Teardown         Close All Connections

*** Variables ***
${HOST}                localhost
${SSH_PORT}            2222
${USERNAME}            vagrant
${PRIVKEY}             .vagrant/machines/default/virtualbox/private_key


*** Test Cases ***

Get Local System Information
    [Documentation]    Show System Information
    ${system}=    Evaluate    platform.system()    platform
    Log    \nRunning on ${system}

    ${NIC}=            Run   ip route show default 0.0.0.0/0|awk '{print $5}'
    ${output}=         Run   ip addr show ${NIC}|awk '/inet /{print $2}'
    Log    \IP Address of Client: ${output}

Run test_symbolic.m
    [Documentation]   Runs the test_symbolic.m file in the snap octave
    ${output}=        Execute Command   octave test_symbolic.m
    Log               ${output}
    Should Contain    ${output}   Hello


*** Keywords ***


Open Connection And Log In
   Open Connection           ${HOST}  port=${SSH_PORT}
   Login With Public Key     ${USERNAME}     ${PRIVKEY}

