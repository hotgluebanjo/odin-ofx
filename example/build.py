import subprocess

subprocess.run(["odin", "build", ".", "-build-mode:shared", "-out:Invert.ofx"])
