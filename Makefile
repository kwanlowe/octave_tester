
VENV=p3_venv

setup:
	virtualenv -p $$(which python3) $(VENV)
	$(VENV)/bin/pip install ansible robotframework robotframework-sshlibrary
	
build-box:
	vagrant up 

provision-box: 
	vagrant provision

run-test:
	mkdir -p Test_Results
	$(VENV)/bin/robot -d Test_Results Tests/client.robot
