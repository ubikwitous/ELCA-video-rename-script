# Lutheran Church Service Video Renamer

This project helps Lutheran churches automatically rename recorded video files based on the **ELCA liturgical calendar**. 

It uses a PowerShell script to rename `.mp4` files based on the **modified date** and matches that to a prebuilt liturgical calendar through 2050, which also exist in the rep.

## 📦 Files

- `Rename-ChurchVideos.ps1` — The PowerShell script that renames `.mp4` files in your designated folder.
- `elca_liturgical_calendar_primary_titles.csv` — A calendar of ELCA liturgical Sundays from 2022–2050, including titles like "Fourth Sunday of Easter" and "Christ the King".
- `RunChurchVideoRename.bat` — (Optional) A batch file to run the PowerShell script with a simple double-click.

## 🔧 Requirements

- Windows 10 or 11
- PowerShell (built-in)
- `.mp4` files located in a folder (default: `D:\Recordings`)
- [Execution Policy](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy) must allow script execution (`RemoteSigned` or `Bypass`)

## 📁 Folder Structure

By default, this script assumes the recordings are kept or moved into a folder:

D:
└── Recordings
├── VID_001.mp4 (any file name)
├── VID_002.mp4 (any file name)
└── ...

## 🧠 How It Works

1. The script reads the **last modified date** of each `.mp4` file.
2. It looks up the corresponding **liturgical title** from the CSV.
3. It renames the file using this format:
    YYYY-MM-DD Liturgical Title.mp4
5. If multiple files exist for the same date, it appends `-A`, `-B`, etc.:
    2025-04-13 Fourth Sunday of Easter.mp4
    2025-04-13 Fourth Sunday of Easter-A.mp4

## ▶️ How to Use

1. Place your `.mp4` video files in the folder specified in the script (default: `D:\Recordings`).
2. Update the CSV path in `Rename-ChurchVideos.ps1` to match your setup.
3. Run the PowerShell script:
   ```powershell
   .\Rename-ChurchVideos.ps1
   OR double-click RunChurchVideoRename.bat to trigger the process.

⛪ Liturgical Calendar Notes
The calendar follows the Revised Common Lectionary (RCL) used by the Evangelical Lutheran Church in America (ELCA).

Some Major feast days and some fringe dates that fell on Sundays are included, but if you prefer to use other names, these can be edited manually the CSV.

📝 Customization
You can edit the PowerShell script to use the creation date instead of the modified date.

You can change the default folder or naming convention as needed.

Add custom logic for holidays or special services if applicable (e.g., Easter Vigil, Christmas Eve).

📜 License
This project is released under the MIT License. Use it freely for any church or community purpose.

🙏 Thanks to the ELCA and broader liturgical open data contributors for making structured worship planning possible through 2050!




