# octave\_tester
Test suite for Octave Snap

Creates a local CentOS Vagrant box, installs the Octave snap and runs some test scripts.

# Running

You will need Vagrant and somewhat recent Python3 installed for this to work.

```
git clone git@github.com:kwanlowe/octave_tester.git
cd octave_tester
make setup
source p3_venv/bin/activate
make build box   
make run-test
```

Once the test completes, results should be available in the Test\_Results dir.
