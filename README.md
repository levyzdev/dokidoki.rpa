# A simple .RPA extractor and .RPYC decompiler for Doki Doki Literature Club and Ren'Py-based games.

---

## How to Use

1. **Place this project folder in the root of your DDLC game or mod.**  
   **Example:**
```
DDLC/
 ├── game/
   ├── DokiDoki.rpa/ ← This tool goes here
     ├── assets/
     ├── put_rpyc/
     ├── dokidoki.exe
```

2. **Extract or Decompile:**
- Run `dokidoki.exe`
- Choose:
  - `[E]` to extract an `.RPA` archive
  - `[D]` to decompile `.RPYC` files

3. **Input the file name (no extension):**
- Example:
  - To extract `scripts.rpa`, just type: `scripts`
  - To decompile files in `put_rpyc/`, just type anything (the input is ignored)

4. **Output:**
- `.rpa` files will be extracted into a folder named after the input file
- `.rpyc` files will be decompiled into subfolders under the main output folder

---

## Folder Structure

Folders:
--------

- assets/api/         → Python scripts (unrpyc.py, rpatool.py, isRPC.py)
- put_rpyc/           → Put your .rpyc files here to decompile
- [output_folder]/    → Extracted .rpa files will be placed here


---

## Notes

- Make sure Python is installed, or use the included portable version.
- The decompiler only supports `.rpyc` files from **Ren'Py 6.x** or early **7.x** versions.

---

## Credits

**DokiDoki.rpa** by [levyzdev](https://github.com/levyzdev)  
Python scripts:
- [`unrpyc`](https://github.com/CensoredUsername/unrpyc) by [CensoredUsername](https://github.com/CensoredUsername/)
- [`rpatool`](https://github.com/Shizmob/rpatool) by [Shizmob](https://github.com/Shizmob/)

