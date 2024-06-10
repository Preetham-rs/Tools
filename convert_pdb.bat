@echo off
setlocal enabledelayedexpansion

:: Set your input and output directories
set "input_dir=C:\Users\vikyv\OneDrive\Desktop\test"
set "template_file=receptor.pdb"
set "output_dir=%input_dir%\combined_comb"

:: Create the output directory if it doesn't exist
if not exist "%output_dir%" mkdir "%output_dir%"

:: Loop through each PDB file in the input directory
for %%f in ("%input_dir%\*.pdb") do (
    if /I not "%%~nxf" == "%template_file%" (
        echo Merging %%~nxf with %template_file%...
        
        :: Read the content of the template file and the current file
        obabel "%input_dir%\%template_file%" -O "%output_dir%\template.pdb"
        obabel "%%f" -O "%output_dir%\current.pdb"

        :: Combine the two files
        type "%output_dir%\template.pdb" > "%output_dir%\%%~nf_comb.pdb"
        type "%output_dir%\current.pdb" >> "%output_dir%\%%~nf_comb.pdb"

        :: Clean up temporary files
        del "%output_dir%\template.pdb"
        del "%output_dir%\current.pdb"
    )
)

echo All files merged successfully.
pause
