class GithubClass {
    link := ""

    __New(github_user, repo) {
        this.link := "https://github.com/" github_user "/" repo
    }

    GetLatestVersionURL(item) {
        return this.link "/releases/latest/download/" item
    }
}

macro_path := A_ScriptDir "\Main.exe"

try FileDelete(macro_path)

Sleep 1000

try {
    g := GithubClass("Rapxi", "Brook-Reroll-Event-Macro")

    Download(g.GetLatestVersionURL("Main.exe"), macro_path)

    if !FileExist(macro_path)
        throw Error("Download failed: file does not exist.")

    if FileGetSize(macro_path) < 100000
        throw Error("Download failed: file is too small.")

    f := FileOpen(macro_path, "r")
    sig := f.Read(2)
    f.Close()

    if sig != "MZ"
        throw Error("Download failed: file is not a valid EXE.")

} catch Error as e {
    MsgBox "Updater error:`n" e.Message
    ExitApp
}

Sleep 500
Run macro_path
ExitApp