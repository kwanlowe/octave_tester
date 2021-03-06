curPath=getenv("PATH")
newPath=strcat("/home/vagrant/python_venv/p3/bin/:", curPath)
setenv("PATH", newPath)
setenv("PYTHON", "/home/vagrant/python_venv/p3/bin/python3")
pkg install -forge symbolic
pkg load symbolic 

disp("\nDiagnostic Information")
disp("\nPath to Python Executable:")
unix("python3 -c 'import sys;  print(sys.executable)'")

disp("\nLDD against python3")
unix("ldd $(which python3)")

syms x
output=sympref("diagnose")
disp(output)
