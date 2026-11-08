import subprocess
import sys
from pathlib import Path
from jinja2 import Template


template = Template(Path("./bin/main.ml").read_text())
properties = {"assoc_add_float": ("x","y","z","(a +. b) +. c", "a +. (b +. c)"),
              "assoc_mul_float": ("x","y","z","(a *. b) *. c", "a *. (b *. c)"),
              "assoc_add_Z": ("Z.of_float x","Z.of_float y","Z.of_float z","Z.( + ) (Z.( + ) a b ) c", "Z.( + ) a (Z.( + ) b  c)"),
               "assoc_mul_Z": ("Z.of_float x","Z.of_float y","Z.of_float z","Z.( * ) (Z.( * ) a b ) c", "Z.( * ) a (Z.( * ) b  c)")

                                  }
Path("generated").mkdir(exist_ok=True)
for name, (x,y,z,lhs, rhs) in properties.items():
    path = Path(f"generated/{name}.ml")
    path.write_text(template.render(x=x,y=y, z=z,f_l=lhs, f_r=rhs, repetitions=10000))
    result = subprocess.run([sys.executable, path], capture_output=True, text=True)
    print(name, result.stdout.strip())