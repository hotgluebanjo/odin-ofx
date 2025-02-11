import subprocess

subprocess.run(["odin", "build", ".", "-debug", "-build-mode:shared", "-out:Invert.ofx"])
