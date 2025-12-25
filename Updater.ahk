class GithubClass {
    link := ''

    __new(github_user, repo) {
        this.link := 'https://github.com/' github_user '/' repo
    }

    GetLatestVersionURL(item) {
        return this.link '/releases/latest/download/' item
    }
}

macro_path := A_ScriptDir '\Main.exe'
try FileDelete(macro_path)

Sleep 5000


try {
    g := GithubClass('Rapxi', 'Main')


    Download(g.GetLatestVersionURL('Main.exe'), macro_path)
} catch Error as e {
    MsgBox e.Message
    ExitApp()
}

Sleep 500
Run macro_path