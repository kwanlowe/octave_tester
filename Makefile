
VENV=p3_venv

setup:
	virtualenv -p $$(which python3) $(VENV)
	$(VENV)/bin/pip install ansible robotframework robotframework-sshlibrary
	
build-box:
	vagrant up 

run-test:
	mkdir -p Test_Results
	robot -d Test_Results client.robot
