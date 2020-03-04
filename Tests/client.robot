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

Check if Octave can run
    [Documentation]   Absolute basic test
    Run Keyword and Continue on Failure   test000  

Check if symbolic package can run
    [Documentation]   Loads symbolic package and attempts to create new sym
    Run Keyword and Continue on Failure   test001  

Get sympref diagnose information
    [Documentation]   Run the sympref diagnose script
    Run Keyword and Continue on Failure   test002  

Set PYTHON to python3 and run test
    [Documentation]   Run the sympref diagnose script
    Run Keyword and Continue on Failure   test003  

Set PATH to host virtualenv (python3.6) and run test
    [Documentation]   Run the sympref diagnose script
    Run Keyword and Continue on Failure   test004  

Set PATH to host virtualenv (python3.6m) and run test
    [Documentation]   Run the sympref diagnose script
    Run Keyword and Continue on Failure   test005  

Set PATH to snap virtualenv (python3.6) and run test
    [Documentation]   Runs the test against a Python venv created from the
    ...               /snap/core18/current/usr/bin/python3 environment.
    Run Keyword and Continue on Failure   test006  


*** Keywords ***

test000
    [Documentation]   Canary suite - if this fails, nothing else matters
    ${output}=        Execute Command     octave test000.m 2>&1
    Log               ${output}
    Should Contain    ${output}   Hello, World!

test001
    [Documentation]   Runs test_symbolic.m 
    ${output}=        Execute Command     octave test001.m 2>&1
    Log               ${output}
    Should Contain    ${output}   x = (sym) x

test002
    [Documentation]   Runs sympref diagnose
    ${output}=        Execute Command     octave test002.m 2>&1
    Log               ${output}

test003
    [Documentation]   Runs sympref diagnose
    ${output}=        Execute Command     octave test003.m 2>&1
    Log               ${output}
    Should Contain    ${output}   x = (sym) x

test004
    [Documentation]   Sets PATH to virtualenv
    ${output}=        Execute Command     octave test004.m 2>&1
    Log               ${output}
    Should Contain    ${output}   x = (sym) x

test005
    [Documentation]   Installs python3.6m (pymalloc) virtualenv and tests
    ${output}=        Execute Command     octave test005.m 2>&1
    Log               ${output}
    Should Contain    ${output}   x = (sym) x

test006
    [Documentation]   Checks against the snap based Python virtualenv
    ${output}=        Execute Command     octave test006.m 2>&1
    Log               ${output}
    Should Contain    ${output}   x = (sym) x



Open Connection And Log In
   Open Connection           ${HOST}  port=${SSH_PORT}
   Login With Public Key     ${USERNAME}     ${PRIVKEY}

