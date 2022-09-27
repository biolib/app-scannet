import subprocess
import os
import sys
import glob
import base64

subprocess.run(['python', 'predict_bindingsites.py', *sys.argv[1:]])

output_files = glob.glob('/ScanNet/predictions/*/*')

pdb_file = None
for output_file in output_files:
    if output_file.endswith('.pdb'):
        pdb_file = output_file

if pdb_file:
    with open(pdb_file, mode='rb') as f:
        pdb_content_bytes = f.read()

    with open('molstar.html', mode='r') as f:
        molstar_html = f.read()

    pdb_base_64_string = base64.b64encode(pdb_content_bytes).decode()
    html_with_pdb = molstar_html.replace('MOLSTAR_INPUT_REPLACE_THIS_STRING', pdb_base_64_string)

    open('/output.html', 'w').write(html_with_pdb)